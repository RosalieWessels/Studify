//
//  AddHomeworkViewController.swift
//  Studify

//  Created by Mahika Gupta on 3/11/18.
//  Copyright © 2018 Mahika Gupta. All rights reserved.
//

import UIKit
import Firebase

class AddHomeworkViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Homework Title
    var homeworkName: String = ""
    @IBOutlet weak var homeworkTitle: UITextField!

    //ClassPicker
    @IBOutlet var classPicker: UIPickerView!
    var pickerData: [String] = [String]()
    
    
    //Teacher
    var teacher: String = ""
    @IBOutlet weak var teacherTextField: UITextField!


    
    //Due Date
    var dueDate: String = ""
    @IBOutlet weak var dueDateTextField: UITextField!

    
    //Description
    var descriptiontextbox: String = ""
    @IBOutlet weak var descriptionTextField: UITextField!

    
    //Other
    var other: String = ""
    @IBOutlet weak var otherTextField: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.classPicker.delegate = self
        self.classPicker.dataSource = self
        pickerData = ["English", "Math", "Science", "History", "PE", "Chinese", "French", "Computer Science" ]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    
    
    //DONE
    @IBAction func DoneButton(_ sender: Any) {
        homeworkName = homeworkTitle.text!
        
        
        teacher = teacherTextField.text!
    

        
        dueDate = dueDateTextField.text!

        
        descriptiontextbox = descriptionTextField.text!

        
        other = otherTextField.text!

        
        //Send Homework to Firebase and save it in the database.
        
        let homeworkDB = Database.database().reference().child("Homework")
        let homeworkDictionary = ["Title": homeworkName, "Teacher": teacher]
        
        homeworkDB.childByAutoId().setValue(homeworkDictionary){
            (error, reference) in
            
            if error != nil{
                print(error!)
            }
            else{
                print("Homework saved succesfully")
                self.performSegue(withIdentifier: "BackToHomeworkOverView", sender: self)
            }
        }
        
        
        
        
    }
    
    
}
