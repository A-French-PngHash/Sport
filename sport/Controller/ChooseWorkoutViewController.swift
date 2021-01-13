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
    /// Pressed when the user want to register a run today
    @IBOutlet weak var ranButton: UIButton!
    var workoutChosed : String!
    var recommandation : WorkoutType!
    
    var restText : String = "You've been active for the past couple days so today take a break, relax yourself, rest !"
    var armText : String = "We recommend you to do your arm workout today !"
    var absText : String = "Abs is what we recommend you today !"
    var alreadyWorkoutText : String = "Great ! You've already workout today, rest for tomorow !"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true

        /*
         What it does basically is that if there was a run workout in the past 3 days rather than submitting only 2 days to the training calculator, it will submit the past 3 day data. The training calculator can then calculate as if it was 2 days, without taking into account the run. This really make the run an optionnal workout.
         */

        var result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 3)
        print("run : \(result.2)")
        if result.2.count == 0 {
            // No run workout.
            result = TrainingCalculator.shared.getSportArrayForLastXDays(x: 2)
            recommandation = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: result.0.count, absWorkout: result.1.count, restWorkout: result.3)
        } else {
            // Run workout.
            recommandation = TrainingCalculator.shared.getTodayRecommendedWorkout(armsWorkout: result.0.count, absWorkout: result.1.count, restWorkout: result.3)
        }
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

    @IBAction func ranButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Register a run Session", message: "Are you sure you want to register a run session. This action cannot be undone and will affect your recomendations.", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { (_) in
            AppDelegate.app.persistence.insertWorkoutItem(date: Date(), workoutType: .run)
            self.recommandationLabel.text = self.alreadyWorkoutText
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }

        alert.addAction(yes)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
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
