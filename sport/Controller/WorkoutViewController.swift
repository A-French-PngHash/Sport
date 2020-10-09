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

    @IBOutlet weak var timeAndStatusView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var workoutImageView: UIImageView!
    @IBOutlet weak var workoutNavigationBar: UINavigationBar!
    @IBOutlet weak var restView: UIView!
    
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
    
    var workoutName : String!
    var session : SportSession!
    var beginSessiondate : Double!
    var currentImageDisplayedIndex : Int = 0
    var player : AVAudioPlayer?
    var timers : Array<Timer>! //Used to shutdown / start timer when app become inactive or rebecome active
    var dataUpdateTimer : Timer!
    var anounceWorkoutPlayer : AVQueuePlayer!
    var anounceRestPlayer : AVQueuePlayer!
    
    var numberOfAudioFilesPlayed : Int! // Keeping a track of the number of audio file played in order to know when to switch state
    let numberOfAnounceWorkoutAudioFileToPlay = 7
    let numberOfAnounceRestAudioFileToPlay = 4
    var notificationObserver : NSObjectProtocol?
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func previousSportButtonClicked(_ sender: Any) {
        session.executeTransitionToPreviousSport()
    }
    @IBAction func nextSportButtonClicked(_ sender: Any) {
        session.executeTransitionToNextSport()
    }
    
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
            
        workoutImageView.isHidden = false
        restView.isHidden = true
        
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
            self.updateTimerLabel()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RestReadyToBegin"), object: nil, queue: nil) { (_) in
            self.tick()
            self.anounceAndSetupRest()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "RestEnded"), object: nil, queue: nil) { (_) in
            self.updateButtonStyle()
            self.restView.isHidden = true
            self.workoutImageView.isHidden = false
            
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
    
    func updateButtonStyle() {
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
    
    func anounceSport() {
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
        
        var numberOfReps : AVPlayerItem?
        if let sport = session.currentSport as? SportWithReps {
            numberOfReps = AVPlayerItem.init(url: Bundle.main.url(forResource: String(sport.numberOfReps), withExtension: "mp3")!)
        }
        
        let item5 = AVPlayerItem.init(url: Bundle.main.url(forResource: "repetitions", withExtension: "mp3")!)
        let item6 = AVPlayerItem.init(url: Bundle.main.url(forResource: "GetReadyAnd", withExtension: "mp3")!)
        
        var itemsToPlay : Array<AVPlayerItem> = []
        if session.currentSportType == "r" {
            itemsToPlay = [item0, item1, item2, item3, numberOfReps!, item5, item6]
        }
        anounceWorkoutPlayer = AVQueuePlayer(items: itemsToPlay)
        
        anounceWorkoutPlayer.play()
    }
    
    func anounceAndSetupRest() {
        self.numberOfAudioFilesPlayed = 1
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let tem0 = AVPlayerItem.init(url: Bundle.main.url(forResource: String(session.reps), withExtension: "mp3")!)
        let tem1 = AVPlayerItem.init(url: Bundle.main.url(forResource: "AwesomeNowRestFor", withExtension: "mp3")!)
        let tem2 = AVPlayerItem.init(url: Bundle.main.url(forResource: String(self.session.pauseBetweenSport), withExtension: "mp3")!)
        let tem3 = AVPlayerItem.init(url: Bundle.main.url(forResource: "secondes", withExtension: "mp3")!)
        anounceRestPlayer = AVQueuePlayer(items: [tem0, tem1, tem2, tem3])
        
        anounceRestPlayer.play()
    }
    
    func tick() {
        if session.currentState == .anouncingWorkout || session.currentState == .rest {
            currentImageDisplayedIndex = 1
        } else if currentImageDisplayedIndex == session.currentSport.numberOfImage {
            currentImageDisplayedIndex = 1
            session.rep()
            updateViewData()
            if session.reps != session.totalReps {
                playSound(named: String(session.reps))
            }
            //TODO : Play song
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
        updateTimerLabel()
        self.setsDoneLabel.text = "\(session.sets)/\(session.totalSets)"
        if session.currentSportType == "r" {
            self.repsDoneLabel.isHidden = false
            self.repsLabel.isHidden = false
            self.repsDoneLabel.text = "\(session.reps)/\(session.totalReps!)"
        } else {
            self.repsDoneLabel.isHidden = true
            self.repsLabel.isHidden = true
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
    
    private func getMinutesAndSecondsFormatted(numberOfSeconds time : Double) -> (String, String) {
        //Returns two string, the number of minutes and the number of seconds calculated from the number of seconds given as argument
        var minutes = String(Int((floor((time.truncatingRemainder(dividingBy: 3600)) / 60))))
        var seconds = String(Int(floor(time - Double(minutes)! * 60)))
        if minutes.count == 1 {
            minutes = "0\(minutes)"
        }
        if seconds.count == 1 {
            seconds = "0\(seconds)"
        }
        return(minutes, seconds)
    }
    
    private func updateTimerLabel() {
        let time = Date().timeIntervalSinceReferenceDate - self.beginSessiondate
        let result = getMinutesAndSecondsFormatted(numberOfSeconds: time)
        
        self.workoutTimeLabel.text = "\(result.0):\(result.1)"
        self.workoutProgressView.progress = Float(time) / session.totalSessionTime
        
        if session.currentState == .rest {
            let time = session.timeUntilEndOfPause
            let result = getMinutesAndSecondsFormatted(numberOfSeconds: Double(time))
            
            self.timeUntilEndOfPauseLabel.text = "\(result.0):\(result.1)"
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
