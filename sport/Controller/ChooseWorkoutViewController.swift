//
//  ViewController.swift
//  sport
//
//  Created by Titouan Blossier on 10/07/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import UIKit

class ChooseWorkoutViewController: UIViewController {
    var workoutChosed : String!
    
    override func viewDidLoad() {
        UIApplication.shared.isIdleTimerDisabled = true
        super.viewDidLoad()
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
