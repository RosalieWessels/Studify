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
    
    //Studify IBActions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        yourHomeworkTableView.delegate = self
        yourHomeworkTableView.dataSource = self
//        
//        yourClassesTableView.delegate = self
//        yourClassesTableView.dataSource = self
        
        yourHomeworkTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureHomeworkTableView()
        retrieveHomework()
        
        yourHomeworkTableView.separatorStyle = .singleLine
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkArray.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeworkCell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        homeworkCell.messageBody.text = homeworkArray[indexPath.row].title
        homeworkCell.senderUsername.text = homeworkArray[indexPath.row].teacher

        if homeworkArray[indexPath.row].done == 0{
            homeworkCell.avatarImageView.image = UIImage(named: "ZeroOfFourDone")
        }
        else if homeworkArray[indexPath.row].done == 1{
            homeworkCell.avatarImageView.image = UIImage(named: "OneOfFourDone")
        }
        else if homeworkArray[indexPath.row].done == 2{
            homeworkCell.avatarImageView.image = UIImage(named: "TwoOfFourDone")
        }
        else if homeworkArray[indexPath.row].done == 3{
            homeworkCell.avatarImageView.image = UIImage(named: "ThreeOfFourDone")
        }
        else if homeworkArray[indexPath.row].done == 4{
            homeworkCell.avatarImageView.image = UIImage(named: "FourOfFourDone")
        }
        
        return homeworkCell
        
    }
    
    func configureHomeworkTableView(){
        yourHomeworkTableView.rowHeight = UITableViewAutomaticDimension
        yourHomeworkTableView.estimatedRowHeight = 120.0
        
        
        
    }
    
    func retrieveHomework(){
        
        let homeworkDB = Database.database().reference().child("Homework")
        
        homeworkDB.observe(.childAdded){ (snapshot) in
            
            if snapshot.exists() {
                print("key ID \(snapshot.key)")
            }
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let title = snapshotValue["Title"]!
            let teacher = snapshotValue["Teacher"]!
            
            let homework = Message()
            homework.title = title
            homework.teacher = teacher
            print("homework Title: \(title)")
            print("homework Teacher: \(teacher)")
            
            self.homeworkArray.append(homework)
            
            self.configureHomeworkTableView()
            self.yourHomeworkTableView.reloadData()
        }
        
        let homeworkDone = Database.database().reference().child("HomeworkDone")
        
        homeworkDone.observe(.childAdded){ (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let student = snapshotValue["Student"]!
            let nameOfHomework = snapshotValue["NameOfHomework"]!
            print(student, nameOfHomework, "is observed as a new piece of done data")
            
            var index = 0
            
            for item in self.homeworkArray{
                if item.title == nameOfHomework {
                    break
                }
                index = index + 1
            }
            if index < self.homeworkArray.count{
                self.homeworkArray[index].done += 1
            }
            self.yourHomeworkTableView.reloadData()
            
        }
        
    }
    
    func homeworkDone(nameOfHomework : String){
        let homeworkDone = Database.database().reference().child("HomeworkDone")
        
        let currentUser = Auth.auth().currentUser?.email as String?
        
        let homeworkDictionary = ["Student" : currentUser, "NameOfHomework" : nameOfHomework, "done" : "true"]
        
        homeworkDone.childByAutoId().setValue(homeworkDictionary){
            (error, reference) in
            
            if error != nil{
                print(error!)
            }
            else{
                print("Homework Marked done!")
            }
        }
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //finding the index of the cell
        print("section: \(indexPath.row)")
        
        homeworkDone(nameOfHomework: homeworkArray[indexPath.row].title)
        
        self.performSegue(withIdentifier: "GoToExpandHomework", sender: self)
        
        //deleting the cell
        self.homeworkArray.remove(at: indexPath.row)
        self.yourHomeworkTableView.deleteRows(at: [indexPath], with: .fade)
        
        deleteItemFromFirebase()
        
    }
    
    func deleteItemFromFirebase(){
        
         let homeworkDB = Database.database().reference().child("Homework")
        
        let autoID = ""
        //homeworkDB.child(autoID).remove
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        
        print("We are trying to logout")
        do{
            try Auth.auth().signOut()
            print("User is signed out")
            navigationController?.popViewController(animated: true)
            print("User is at homescreen")
        }
        catch{
            print("error, there was a problem signing out.")
        }

    }
    
    

    

}
