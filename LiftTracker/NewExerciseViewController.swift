//
//  ViewController.swift
//  LiftTracker
//
//  Created by Peisen Xue on 6/20/17.
//  Copyright © 2017 Peisen Xue. All rights reserved.
//

import UIKit
import os.log


class NewExerciseViewController: UIViewController {

    @IBOutlet weak var exerciseTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var setTextField: UITextField!
    
    @IBOutlet weak var repTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var exercise:Exercise?
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = exerciseTextField.text ?? ""
        let weight = Int(weightTextField.text!)
        let set = Int(setTextField.text!)
        let rep = Int(repTextField.text!)
        
        
        exercise = Exercise(name: name, weight: weight, set: set, rep: rep)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

