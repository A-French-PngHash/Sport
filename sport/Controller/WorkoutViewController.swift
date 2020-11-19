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
    /*
     Contain the images, the timer if needed...
     */
    @IBOutlet weak var sportContentView: UIView!
    
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
    @IBOutlet weak var recommendedRepsLabel: UILabel!
    
    //MARK: - Variables
    var workoutName : String!
    var session : SportSession!
    var beginSessiondate : Double!
    var currentImageDisplayedIndex : Int = 0
    var player : AVAudioPlayer?
    var timers : Array<Timer>! //Used to shutdown/start all timers when app become inactive or rebecome active
    var dataUpdateTimer : Timer = Timer()
    
    // Used to play audio
    var queuePlayer : AVQueuePlayer!
    
    var numberOfAudioFilesPlayed : Int! // Keeping a track of the number of audio file played in order to know when to switch state
    var notificationObserver : NSObjectProtocol?
    
    /*
     Define the number of audio file that need to be played depending on the situation. These allow us to know when we can continue the workout by clling another function when the audio has finished playing.
     */
    var numberOfAudioFileToPlay : Int {
        get {
            return itemsToPlay.count
        }
    }
    
    var itemsToPlay : Array<AVPlayerItem>!
    
    
    var dataUpdateTimerIsValid : Bool {
        get {
            return dataUpdateTimer.isValid
        }
        
        set {
            self.dataUpdateTimer.invalidate()
            if newValue {
                let secondsForEachImage : Float = self.session.secondsForEachImageCurrentSport()
                self.dataUpdateTimer = Timer.scheduledTimer(withTimeInterval : TimeInterval(secondsForEachImage), repeats: true) { (_) in
                    self.tick()
                }
            }
        }
    }
    
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
        
        //workoutNavigationBar.setGradientBackground(colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)])
        //informationView.layer.cornerRadius = 20
        
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
            
        restEnded()
        
        tick()
        updateViewData()
        
        currentImageDisplayedIndex = 0
        session.currentState = .anouncingWorkout
        anounceSport()
        self.updateButtonStyle()

        dataUpdateTimerIsValid = true
        
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
            
            self.dataUpdateTimerIsValid = true
            
            self.tick()
            self.updateViewData()
            self.anounceSport()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("SetEnded"), object: nil, queue:nil)
        { (_) in
            self.dataUpdateTimerIsValid = false
            self.anounceNextSet()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { (_) in
            if self.numberOfAudioFileToPlay == self.numberOfAudioFilesPlayed {
                if self.session.currentState == .anouncingWorkout {
                    self.session.currentState = .doingWorkout
                    if self.session.currentSportType == "t" {
                        self.session.sportBeganAt = Date().timeIntervalSince1970
                    }
                } else if self.session.currentState == .rest {
                    self.session.beginRest()
                    self.restView.isHidden = false
                    self.sportContentView.isHidden = true
                } else if self.session.currentState == .anouncingSet {
                    self.session.startNextSet()
                    self.dataUpdateTimerIsValid = true
                    self.updateViewData()
                }
            } else {
                self.numberOfAudioFilesPlayed += 1
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("WorkoutEnded"), object: nil, queue: nil) {
            (_) in
            self.stopTimers()
            self.anounceEnd()
        }
        
        self.timers = [dataUpdateTimer, timerTimeLabel]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimers()
    }
    
    private func stopTimers() {
        for i in timers {
            i.invalidate()
        }
        dataUpdateTimerIsValid = false
    }
    
    /*
     Called when the rest ended. Show or hide buttons depending on the sport.
     */
    private func restEnded() {
        self.restView.isHidden = true
        self.sportContentView.isHidden = false
        self.recommendedRepsLabel.isHidden = true

        
        if session.currentSportType == "r" {
            self.repsDoneLabel.isHidden = false
            self.repsLabel.isHidden = false
            
            self.endInLabel.isHidden = true
            self.endInTimerLabel.isHidden = true
            
            if session.currentSportIsRecommended {
                self.recommendedRepsLabel.isHidden = false
            }
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
        
        if session.currentSportType == "r" {
            itemsToPlay = [item0, item1, item2, item3, numberOf, repetitions, item6]
        } else {
            itemsToPlay = [item0, item1, item2, item3, numberOf, secondes, item6]
        }
        queuePlayer = AVQueuePlayer(items: itemsToPlay)
        
        queuePlayer.playImmediately(atRate: 1.3)
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
            if !session.currentSportIsRecommended {
                item0 = AVPlayerItem.init(url: Bundle.main.url(forResource: String(session.reps), withExtension: "mp3")!)
            }
        }
        let item1 = AVPlayerItem.init(url: Bundle.main.url(forResource: "AwesomeNowRestFor", withExtension: "mp3")!)
        let item2 = AVPlayerItem.init(url: Bundle.main.url(forResource: String(self.session.pauseBetweenSport), withExtension: "mp3")!)
        let item3 = AVPlayerItem.init(url: Bundle.main.url(forResource: "secondes", withExtension: "mp3")!)
        
        if session.currentSportType == "r"  && !session.currentSportIsRecommended{
            itemsToPlay = [item0!, item1, item2, item3]
        } else {
            itemsToPlay = [item1, item2, item3]
        }
        
        queuePlayer = AVQueuePlayer(items: itemsToPlay)
        queuePlayer.playImmediately(atRate: 1.3)
    }
    
    private func anounceNextSet() {
        self.numberOfAudioFilesPlayed = 1
        
        
        let fantastic = AVPlayerItem.init(url: Bundle.main.url(forResource: "Fantastic", withExtension: "mp3")!)
        let nowPrepare = AVPlayerItem.init(url: Bundle.main.url(forResource: "NowPrepareForTheNextSet", withExtension: "mp3")!)
        let set = AVPlayerItem.init(url: Bundle.main.url(forResource: "Set", withExtension: "mp3")!)
        let actualSetNumber = AVPlayerItem.init(url: Bundle.main.url(forResource: String(session.sets + 1), withExtension: "mp3")!)
        let of = AVPlayerItem.init(url: Bundle.main.url(forResource: "Of", withExtension: "mp3")!)
        let totalSetNumber = AVPlayerItem.init(url: Bundle.main.url(forResource: String(session.currentSport.numberOfSets), withExtension: "mp3")!)
        let getReady = AVPlayerItem.init(url: Bundle.main.url(forResource: "GetReadyAnd", withExtension: "mp3")!)
        
        itemsToPlay = [fantastic, nowPrepare, set, actualSetNumber, of, totalSetNumber, getReady]
        if session.currentSportType == "r"{
            // Saying the last rep.
            itemsToPlay.insert(AVPlayerItem.init(url: Bundle.main.url(forResource: String(session.reps), withExtension: "mp3")!), at: 0)
        }
        queuePlayer = AVQueuePlayer(items: itemsToPlay)
        print("passed one")
        queuePlayer.playImmediately(atRate: 1.3)
    }
    
    
    private func anounceEnd() {
        self.numberOfAudioFilesPlayed = 1
        
        let end = AVPlayerItem.init(url: Bundle.main.url(forResource: "End", withExtension: "mp3")!)
        
        itemsToPlay = [end]
        if session.currentSportType == "r" {
            // Saying the last rep.
            itemsToPlay.insert(AVPlayerItem.init(url: Bundle.main.url(forResource: String(session.reps), withExtension: "mp3")!), at: 0)
        }
        
        queuePlayer = AVQueuePlayer(items: itemsToPlay)
        queuePlayer.playImmediately(atRate: 1)
    }
    
    func tick() {
        if session.currentState == .anouncingWorkout || session.currentState == .rest {
            currentImageDisplayedIndex = 1
        } else if currentImageDisplayedIndex == session.currentSport.numberOfImage {
            currentImageDisplayedIndex = 1
            if session.currentSportType == "r" {
                if !session.currentSportIsRecommended {
                    session.rep()
                    if session.reps != session.totalReps {
                        playSound(named: String(session.reps))
                    }
                    updateViewData()
                }
            }
        } else {
            currentImageDisplayedIndex += 1
        }
        
        let specification = session.currentSport.specification
        if specification != "" {
            if let image = UIImage(named: "\(self.session.currentSport.name) (\(self.session.currentSport.specification)) \(self.currentImageDisplayedIndex)"){
                self.workoutImageView.image = image
            }
        } else {
            if let image = UIImage(named: "\(self.session.currentSport.name) \(self.currentImageDisplayedIndex)") {
                self.workoutImageView.image = image
            }
        }
    }
    
    private func updateViewData(){
        updateTimersLabels()
        self.setsDoneLabel.text = "\(session.sets)/\(session.totalSets)"
        
        if session.currentSportType == "r" {
            if session.currentSportIsRecommended {
                self.repsDoneLabel.text = String(session.totalReps!)
            } else {
                
                self.repsDoneLabel.text = "\(session.reps)/\(session.totalReps!)"
            }
        }
        
        let specification = session.currentSport.specification
        if specification != "" {
            self.sportDetailLabel.text = "(" + session.currentSport.specification + ")"
        } else {
            self.sportDetailLabel.text = ""
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
        let result = Date.getMinutesAndSecondsFormatted(numberOfSeconds: time)
        
        self.workoutTimeLabel.text = "\(result.0):\(result.1)"
        self.workoutProgressView.progress = Float(time) / session.totalSessionTime
        
        
        //UPDATE : Rest Timer
        if session.currentState == .rest {
            let time = session.timeUntilEndOfPause
            let result = Date.getMinutesAndSecondsFormatted(numberOfSeconds: Double(time))
            
            self.timeUntilEndOfPauseLabel.text = "\(result.0):\(result.1)"
        }
        
        //UPDATE : Timer for Sport With Timer
        // This variable is nil if the actual sport is not a sport with timer
        if let time = session.timeUntilSportEnd{
            let result = Date.getMinutesAndSecondsFormatted(numberOfSeconds:time)
            self.endInTimerLabel.text = "\(result.0):\(result.1)"
            
            // Detect if set is finished
            if session.sportWithTimerCompleted! && session.currentState != .rest && session.currentState != .anouncingSet{
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
