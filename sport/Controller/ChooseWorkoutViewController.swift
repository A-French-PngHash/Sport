//
//  ViewController.swift
//  sport
//
//  Created by Titouan Blossier on 10/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import UIKit

class ChooseWorkoutViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recomendationLabel: UILabel!
    var workoutChosed : String!
    
    var restText : String = "You've been active for the past couple days so today take a break, relax yourself, rest !"
    var armText : String = "We recommend you to do your arm workout !"
    var absText : String = "Abs is what we recommend you today !"
    var alreadyWorkoutText : String = "Great ! You've already workout today "

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        UIApplication.shared.isIdleTimerDisabled = true
        //testCoreData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SegueToWorkoutVC" else {
            return
        }
        guard let workoutVC = segue.destination as? WorkoutViewController else {
            return
        }
        
        workoutVC.workoutName = self.workoutChosed
    }
    
    //MARK: - Test Function :
    private func testCoreData() {
        //Persistence.shared.saveWorkout(date: Date().addingTimeInterval(TimeInterval(-3600 * 24 * 3)), workoutType: .arms)
        //TrainingCalculator.shared.getTodayRecommendedWorkout()

    }
    
    func setGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = tableView.layer.frame
        tableView.layer.insertSublayer(gradient, at: 0)
    }
}

extension ChooseWorkoutViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.workoutChosed = cell?.textLabel?.text
        self.performSegue(withIdentifier: "SegueToWorkoutVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Workouts.shared.allWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell", for: indexPath)
        cell.textLabel?.text = Workouts.shared.allWorkoutsNames[indexPath.row]
        return cell
    }
}
