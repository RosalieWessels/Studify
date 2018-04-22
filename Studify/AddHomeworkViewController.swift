//
//  AddHomeworkViewController.swift
//  Studify

//  Created by Mahika Gupta on 3/11/18.
//  Copyright © 2018 Mahika Gupta. All rights reserved.
//

import UIKit

class AddHomeworkViewController: UIViewController {
    
    //Homework Title
    var homeworkName: String = ""
    @IBOutlet weak var homeworkTitle: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    //Class Name
    var className: String = ""
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var classNameLabel: UILabel!
    
    //Teacher
    var teacher: String = ""
    @IBOutlet weak var teacherTextField: UITextField!
    @IBOutlet weak var teacherLabel: UILabel!
    
    //Assigned Date
    var assignedDate: String = ""
    @IBOutlet weak var assignedDateTextField: UITextField!
    @IBOutlet weak var assignedDateLabel: UILabel!
    
    //Due Date
    var dueDate: String = ""
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    //Description
    var descriptiontextbox: String = ""
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //Other
    var other: String = ""
    @IBOutlet weak var otherTextField: UITextField!
    @IBOutlet weak var otherLabel: UILabel!
    
    //DONE
    @IBAction func DoneButton(_ sender: Any) {
        homeworkName = homeworkTitle.text!
        titleLabel.text = "\(homeworkName)"
        
        className = classNameTextField.text!
        classNameLabel.text = "\(className)"
        
        teacher = teacherTextField.text!
        teacherLabel.text = "\(teacher)"
        
        assignedDate = assignedDateTextField.text!
        assignedDateLabel.text = "\(assignedDate)"
        
        dueDate = dueDateTextField.text!
        dueDateLabel.text = "\(dueDate)"
        
        descriptiontextbox = descriptionTextField.text!
        descriptionLabel.text = "\(descriptiontextbox)"
        
        other = otherTextField.text!
        otherLabel.text = "\(other)"
        
    }
    
    
}
