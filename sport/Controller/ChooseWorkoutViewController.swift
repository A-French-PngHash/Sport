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
    @IBOutlet weak var recommandationLabel: UILabel!
    var workoutChosed : String!
    var recommandation : WorkoutType!
    
    var restText : String = "You've been active for the past couple days so today take a break, relax yourself, rest !"
    var armText : String = "We recommend you to do your arm workout today !"
    var absText : String = "Abs is what we recommend you today !"
    var alreadyWorkoutText : String = "Great ! You've already workout today, rest for tomorow !"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        let result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 5)
        recommandation = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: result.0.count, absWorkout: result.1.count, restWorkout: result.2)
        if recommandation == .abs {
            recommandationLabel.text = absText
        } else if recommandation == .arms {
            recommandationLabel.text = armText
        } else if recommandation == .rest {
            recommandationLabel.text = restText
        } else if recommandation == .alreadyWorkout {
            recommandationLabel.text = alreadyWorkoutText
        }
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
}

extension ChooseWorkoutViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WorkoutTableViewCell else {
            return
        }
        self.workoutChosed = cell.workoutNameLabel.text
        self.performSegue(withIdentifier: "SegueToWorkoutVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Workouts.shared.allWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell", for: indexPath) as? WorkoutTableViewCell else {
            return UITableViewCell()
        }
        cell.workoutNameLabel.text = Workouts.shared.allWorkoutsNames[indexPath.row]
        if Workouts.shared.allWorkouts[indexPath.row].type == recommandation {
            cell.isRecommendedImage.isHidden = false
        } else {
            cell.isRecommendedImage.isHidden = true
        }
        return cell
    }
}
