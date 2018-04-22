//
//  StudifyViewController.swift
//  Studify
//
//  Created by Rosalie Wessels on 13/04/2018.
//

import UIKit
import Firebase
import ChameleonFramework

class yourHomeworkTableView: UIColor{}
class yourClassesTableView: UIColor {}

class StudifyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var homeworkArray : [Message] = [Message]()
    
    //Studify IBOutlets
    @IBOutlet var yourHomeworkTableView: UITableView!
    @IBOutlet var yourClassesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        yourHomeworkTableView.delegate = self
        yourHomeworkTableView.dataSource = self
//        
//        yourClassesTableView.delegate = self
//        yourClassesTableView.dataSource = self
        
        yourHomeworkTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "CustomMessageCell")
        
        configureHomeworkTableView()
        retrieveHomework()
        
        yourHomeworkTableView.separatorStyle = .singleLine
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkArray.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Studifycell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as! CustomMessageCell
        
        return Studifycell
        
    }
    
    func configureHomeworkTableView(){
        yourHomeworkTableView.rowHeight = UITableViewAutomaticDimension
        yourHomeworkTableView.estimatedRowHeight = 120.0
    }
    
    func retrieveHomework(){
        
        let homeworkDB = Database.database().reference().child("Homework")
        
        homeworkDB.observe(.childAdded){ (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let title = snapshotValue["Title"]!
            let teacher = snapshotValue["Teacher"]!
            
            let homework = Message()
            homework.title = title
            homework.teacher = teacher
            
            self.homeworkArray.append(homework)
            
            self.configureHomeworkTableView()
            self.yourHomeworkTableView.reloadData()
        }
        
    }
    

    

}
