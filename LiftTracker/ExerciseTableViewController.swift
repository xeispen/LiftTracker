//
//  ExerciseTableViewController.swift
//  LiftTracker
//
//  Created by Peisen Xue on 7/29/17.
//  Copyright © 2017 Peisen Xue. All rights reserved.
//

import Foundation
import UIKit
import os.log


class ExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var exerciseTableView: UITableView!

    var exercises = [Exercise]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.exerciseTableView.delegate = self
        self.exerciseTableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        if let savedExercises = loadExercises() {
            exercises += savedExercises
        } else {
            // Load the sample data.
            loadSample()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func reorderTable(_ sender: Any) {
        exerciseTableView.isEditing = !exerciseTableView.isEditing
    }
    
    
    
    @IBAction func unwindToExerciseList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? NewExerciseViewController, let exercise = sourceViewController.exercise {
            
            if let selectedIndexPath = exerciseTableView.indexPathForSelectedRow {
                exercises[selectedIndexPath.row] = exercise
                exerciseTableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // New exercise entered
                let newIndexPath = IndexPath(row: exercises.count, section: 0)
                exercises.append(exercise)
                exerciseTableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
        saveExercises()
    }
    
    private func loadExercises() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Exercise.ArchiveURL.path) as? [Exercise]
    }

    private func loadSample() {
        guard let e1 = Exercise(name: "Deadlift", weight: 135, set: 3, rep: 5) else {
            fatalError("Unable to instantiate meal1")
        }
        guard let e2 = Exercise(name: "Bench Press", weight: 135, set: 3, rep: 5) else {
            fatalError("Unable to instantiate meal1")
        }
       
        
        exercises.append(e1)
        exercises.append(e2)
        
        
        
        
    }
    
    
    
    private func saveExercises() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(exercises, toFile: Exercise.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercises.count
    }

  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = exerciseTableView.dequeueReusableCell(withIdentifier: "exercise", for: indexPath) as? ExerciseCell else {
             fatalError("The dequeued cell is not an instance of Exercise Cell.")
        }
        
        let exercise = exercises[indexPath.row]
        
        cell.exerciseLabel.text = exercise.name
        
        if let weight = exercise.weight {
            cell.weightLabel.text = String(weight)
        } else {
             cell.weightLabel.text = "-"
        }
        
        if let set = exercise.set {
            cell.setLabel.text = String(set)
        } else {
            cell.setLabel.text = "-"
        }
        
        if let rep = exercise.rep {
            cell.repLabel.text = String(rep)
        } else {
            cell.repLabel.text = "-"
        }
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

  
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exercises.remove(at: indexPath.row)
            saveExercises()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   

    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        exercises.insert(exercises.remove(at: fromIndexPath.row), at: to.row)
    }


 
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new exercise.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let exerciseDetailViewController = segue.destination as? NewExerciseViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedExerciseCell = sender as? ExerciseCell else {
                fatalError("Unexpected sender: \(sender!)")
            }
            
            guard let indexPath = exerciseTableView.indexPath(for: selectedExerciseCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedExercise = exercises[indexPath.row]
            exerciseDetailViewController.exercise = selectedExercise
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier!)")
        }
        
        
        
        
    }

}

