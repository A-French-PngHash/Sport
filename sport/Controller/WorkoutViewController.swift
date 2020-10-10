//
//  WorkoutViewController.swift
//  sport
//
//  Created by Titouan Blossier on 11/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import UIKit
import AVFoundation

class WorkoutViewController: UIViewController {

    //MARK: - View And Interface Outlets
    @IBOutlet weak var timeAndStatusView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var workoutImageView: UIImageView!
    @IBOutlet weak var workoutNavigationBar: UINavigationBar!
    @IBOutlet weak var restView: UIView!
    
    //MARK: - Other Outlets
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var sportDetailLabel: UILabel!
    @IBOutlet weak var setsDoneLabel: UILabel!
    @IBOutlet weak var nextSportLabel: UILabel!
    @IBOutlet weak var timeUntilEndOfPauseLabel: UILabel!
    @IBOutlet weak var repsDoneLabel: UILabel!
    @IBOutlet weak var workoutTimeLabel: UILabel!
    @IBOutlet weak var workoutProgressView: UIProgressView!
    @IBOutlet weak var previousSportButton: UIButton!
    @IBOutlet weak var nextSportButton: UIButton!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var endInLabel: UILabel!
    @IBOutlet weak var endInTimerLabel: UILabel!
    
    //MARK: - Variables
    var workoutName : String!
    var session : SportSession!
    var beginSessiondate : Double!
    var currentImageDisplayedIndex : Int = 0
    var player : AVAudioPlayer?
    var timers : Array<Timer>! //Used to shutdown/start all timers when app become inactive or rebecome active
    var dataUpdateTimer : Timer!
    
    var anounceWorkoutPlayer : AVQueuePlayer!
    var anounceRestPlayer : AVQueuePlayer!
    
    var numberOfAudioFilesPlayed : Int! // Keeping a track of the number of audio file played in order to know when to switch state
    var notificationObserver : NSObjectProtocol?
    
    /*
     Both of these variables define the number of audio file that need to be played depending on the situation. These allow us to know when we can continue the workout.
     */
    var numberOfAnounceWorkoutAudioFileToPlay = 7
    var numberOfAnounceRestAudioFileToPlay = 4
    
    //MARK: - IBActions
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func previousSportButtonClicked(_ sender: Any) {
        session.executeTransitionToPreviousSport()
    }
    @IBAction func nextSportButtonClicked(_ sender: Any) {
        session.executeTransitionToNextSport()
    }
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        timeAndStatusView.layer.cornerRadius = 5
        workoutNavigationBar.topItem?.title = self.workoutName
        
        self.beginSessiondate = Date().timeIntervalSinceReferenceDate
        
        for i in Workouts.shared.allWorkouts {
            if i.name == workoutName {
                self.session = SportSession(workout:i)
                break
            }
        }
        
        let secondsForEachImage = session.secondsForEachImageCurrentSport()
            
        restEnded()
        
        tick()
        updateViewData()
        
        currentImageDisplayedIndex = 0
        session.currentState = .anouncingWorkout
        anounceSport()
        self.updateButtonStyle()

        
        dataUpdateTimer = Timer.scheduledTimer(withTimeInterval : TimeInterval(secondsForEachImage), repeats: true) { (_) in
            self.tick()
        }
        
        let timerTimeLabel = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.1), repeats: true) { (_) in
            self.updateTimersLabels()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RestReadyToBegin"), object: nil, queue: nil) { (_) in
            self.tick()
            self.anounceAndSetupRest()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RestEnded"), object: nil, queue: nil) { (_) in
            self.updateButtonStyle()
            self.restEnded()
            
            let secondsForEachImage : Float = self.session.secondsForEachImageCurrentSport()
            self.dataUpdateTimer.invalidate()
            self.dataUpdateTimer = Timer.scheduledTimer(withTimeInterval : TimeInterval(secondsForEachImage), repeats: true) { (_) in
                self.tick()
            }
            
            self.tick()
            self.updateViewData()
            self.anounceSport()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { (_) in
            if self.session.currentState == .anouncingWorkout {
                if self.numberOfAnounceWorkoutAudioFileToPlay == self.numberOfAudioFilesPlayed {
                    self.session.currentState = .doingWorkout
                    if self.session.currentSportType == "t" {
                        self.session.sportBeganAt = Date().timeIntervalSince1970
                    }
                } else {
                    self.numberOfAudioFilesPlayed += 1
                }
            } else if self.session.currentState == .rest{
                if self.numberOfAnounceRestAudioFileToPlay == self.numberOfAudioFilesPlayed {
                    self.session.beginRest()
                    self.restView.isHidden = false
                    self.workoutImageView.isHidden = true
                } else {
                    self.numberOfAudioFilesPlayed += 1
                }
            }
        }
        
        self.timers = [dataUpdateTimer, timerTimeLabel]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for i in timers {
            i.invalidate()
        }
    }
    
    /*
     Called when the rest ended. Show or hide buttons depending on the sport.
     */
    private func restEnded() {
        self.restView.isHidden = true
        self.workoutImageView.isHidden = false
        
        if session.currentSportType == "r" {
            self.repsDoneLabel.isHidden = false
            self.repsLabel.isHidden = false
            
            self.endInLabel.isHidden = true
            self.endInTimerLabel.isHidden = true
        } else {
            self.repsDoneLabel.isHidden = true
            self.repsLabel.isHidden = true
            
            self.endInLabel.isHidden = false
            self.endInTimerLabel.isHidden = false
        }
    }
    
    /*
     At the right and the left of the current sport name in the interface there is two buttons which enable to jump to the next or to the previous sport. These function put them into a state which make the user understand they are not available (for exemple when you are at the end or at the begining)
     */
    private func updateButtonStyle() {
        if session.canGoNextSport {
            nextSportButton.isEnabled = true
        } else {
            nextSportButton.isEnabled = false
        }
        if session.canGoPreviousSport {
            previousSportButton.isEnabled = true
        } else {
            previousSportButton.isEnabled = false
        }
    }
    
    //TODO: - Setup sound Anouncment
    /*
     Anounche the workout with audio. Can either be :
     SportWithTimer :
        Now we have [name of the sport]. [X] series, [Y] secondes. Get ready and.
     SportWithReps :
        Now we have [name of the sport]. [X] series, [Y] repetitions. Get ready and.
     
     */
    private func anounceSport() {
        self.numberOfAudioFilesPlayed = 1
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        let item0 = AVPlayerItem.init(url: Bundle.main.url(forResource: "nowWeHave", withExtension: "mp3")!)
        let item1 = AVPlayerItem.init(url: Bundle.main.url(forResource: session.currentSport.nameOfSoundFile, withExtension: "mp3")!)
        let item2 = AVPlayerItem.init(url: Bundle.main.url(forResource: String(session.currentSport.numberOfSets), withExtension: "mp3")!)
        let item3 = AVPlayerItem.init(url: Bundle.main.url(forResource: "series", withExtension: "mp3")!)
        
        /*
         Can either be the number of reps or the number of secondes
         */
        var numberOf : AVPlayerItem!
        if let sport = session.currentSport as? SportWithReps {
            numberOf = AVPlayerItem.init(url: Bundle.main.url(forResource: String(sport.numberOfReps), withExtension: "mp3")!)
        } else if let sport = session.currentSport as? SportWithTimer {
            numberOf = AVPlayerItem.init(url: Bundle.main.url(forResource: String(sport.timeOfTheExercise), withExtension: "mp3")!)
        }
        
        let repetitions = AVPlayerItem.init(url: Bundle.main.url(forResource: "repetitions", withExtension: "mp3")!)
        
        let secondes = AVPlayerItem.init(url: Bundle.main.url(forResource: "secondes", withExtension: "mp3")!)
        
        let item6 = AVPlayerItem.init(url: Bundle.main.url(forResource: "GetReadyAnd", withExtension: "mp3")!)
        
        var itemsToPlay : Array<AVPlayerItem>
        if session.currentSportType == "r" {
            itemsToPlay = [item0, item1, item2, item3, numberOf, repetitions, item6]
        } else {
            itemsToPlay = [item0, item1, item2, item3, numberOf, secondes, item6]
        }
        anounceWorkoutPlayer = AVQueuePlayer(items: itemsToPlay)
        
        anounceWorkoutPlayer.playImmediately(atRate: 1.3)
    }
    
    func anounceAndSetupRest() {
        self.numberOfAudioFilesPlayed = 1
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
        
        var item0 : AVPlayerItem?
        if session.currentSportType == "r" {
            // Saying the last rep.
            item0 = AVPlayerItem.init(url: Bundle.main.url(forResource: String(session.reps), withExtension: "mp3")!)
        }
        let item1 = AVPlayerItem.init(url: Bundle.main.url(forResource: "AwesomeNowRestFor", withExtension: "mp3")!)
        let item2 = AVPlayerItem.init(url: Bundle.main.url(forResource: String(self.session.pauseBetweenSport), withExtension: "mp3")!)
        let item3 = AVPlayerItem.init(url: Bundle.main.url(forResource: "secondes", withExtension: "mp3")!)
        
        if session.currentSportType == "r" {
            numberOfAnounceRestAudioFileToPlay = 4
            anounceRestPlayer = AVQueuePlayer(items: [item0!, item1, item2, item3])
        } else {
            numberOfAnounceRestAudioFileToPlay = 3
            anounceRestPlayer = AVQueuePlayer(items: [item1, item2, item3])
        }
        anounceRestPlayer.playImmediately(atRate: 1.3)
    }
    
    func tick() {
        if session.currentState == .anouncingWorkout || session.currentState == .rest {
            currentImageDisplayedIndex = 1
        } else if currentImageDisplayedIndex == session.currentSport.numberOfImage {
            currentImageDisplayedIndex = 1
            if session.currentSportType == "r" {
                session.rep()
                if session.reps != session.totalReps {
                    playSound(named: String(session.reps))
                }
            }
            updateViewData()
        } else {
            currentImageDisplayedIndex += 1
        }
        
        let specification = session.currentSport.specification
        if specification != "" {
            self.workoutImageView.image = UIImage(named: "\(self.session.currentSport.name) (\(self.session.currentSport.specification)) \(self.currentImageDisplayedIndex)")
        } else {
            self.workoutImageView.image = UIImage(named: "\(self.session.currentSport.name) \(self.currentImageDisplayedIndex)")
        }
    }
    
    private func updateViewData(){
        updateTimersLabels()
        self.setsDoneLabel.text = "\(session.sets)/\(session.totalSets)"
        
        if session.currentSportType == "r" {
            self.repsDoneLabel.text = "\(session.reps)/\(session.totalReps!)"
        }
        
        let specification = session.currentSport.specification
        if specification != "" {
            self.sportDetailLabel.text = "(" + session.currentSport.specification + ")"
        }
        
        if session.nextSport == nil {
            self.nextSportLabel.text = "None"
        } else if specification != ""{
            self.nextSportLabel.text = "\(session.nextSport!.name) (\(session.nextSport!.specification))"
        } else {
            self.nextSportLabel.text = "\(session.nextSport!.name)"

        }
        
        self.sportNameLabel.text = session.currentSport.name
        
        
    }
    
    /*
     Update all the different timer in the app :
        - Timer until rest stop
        - Timer of global time passed since workout began
        - Timer for sport who works with a timer
     */
    private func updateTimersLabels() {
        
        //UPDATE : Global Timer
        let time = Date().timeIntervalSinceReferenceDate - self.beginSessiondate
        let result = Date().getMinutesAndSecondsFormatted(numberOfSeconds: time)
        
        self.workoutTimeLabel.text = "\(result.0):\(result.1)"
        self.workoutProgressView.progress = Float(time) / session.totalSessionTime
        
        
        //UPDATE : Rest Timer
        if session.currentState == .rest {
            let time = session.timeUntilEndOfPause
            let result = Date().getMinutesAndSecondsFormatted(numberOfSeconds: Double(time))
            
            self.timeUntilEndOfPauseLabel.text = "\(result.0):\(result.1)"
        }
        
        //UPDATE : Timer for Sport With Timer
        // This variable is nil if the actual sport is not a sport with timer
        if let time = session.timeUntilSportEnd{
            let result = Date().getMinutesAndSecondsFormatted(numberOfSeconds:time)
            self.endInTimerLabel.text = "\(result.0):\(result.1)"
            
            // Detect if set is finished
            if session.sportWithTimerCompleted! && session.currentState != .rest{
                session.setCompleted()
            }

        }
    }
    
    private func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
