//
//  chatViewController.swift
//  ParseChat
//
//  Created by Mo on 2/22/18.
//  Copyright © 2018 Mo. All rights reserved.
//

import UIKit
import Parse

class chatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var message = [PFObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! chatCell

        cell.bubbleView.layer.cornerRadius = 16
        cell.bubbleView.clipsToBounds = true
        
        cell.chatTextLabel.text = message[indexPath.row]["text"] as? String
            print(message[indexPath.row]["text"])
        if let user = message[indexPath.row]["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        return cell
    }
    
    @objc func onTimer() {
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground(block: {(messages:[PFObject]?,error:Error?) in
            if error == nil {
                for mess in messages!{
                    self.message.append(mess)
                }
            }
            else{
                print(error?.localizedDescription)
            }
        
        })
        self.chatTableView.reloadData()
    }

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBAction func chatSend(_ sender: UIButton) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 50
        chatTableView.separatorStyle = .none
        chatTableView.dataSource = self
        chatTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
