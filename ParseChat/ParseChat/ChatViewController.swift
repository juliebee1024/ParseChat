//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Julie Bao on 10/7/18.
//  Copyright © 2018 Julie Bao. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var msgs:[PFObject] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return msgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
        cell.msg = (msgs[indexPath.row]["text"] as? String)!
        cell.usr = (msgs[indexPath.row]["user"] as? PFObject)?["username"] as? String ?? "EMPTY"
    
        return cell
    }
    
    @IBAction func OnSend(_ sender: Any) {
        //When the user taps the "Send" button, create a new Message of type PFObject and save it to Parse
        let chatMessage = PFObject(className: "Message")
        
        //Store the text of the text field in a key called text
        chatMessage["text"] = chatMessageField.text ?? ""
        
        //When creating a new message, add a key called user and set it to PFUser.current()
        chatMessage["user"] = PFUser.current()
        
        //Call save in background and print when the message successfully saves or any errors.
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                
                //on successful message save, clear the text from the text chat field
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
            self.updateMessages()
    }
    
//    @objc func onTimer() {
//        //Create a refresh function that is run every second
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
//    }
}

    private func updateMessages()
    {
        // construct query
        let query = PFQuery(className: "Message")
        
        //sort the results in descending order with the createdAt field
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        
        //When querying for messages, add an additional query parameter, includeKey(_:) on the query to instruct Parse to fetch the related user.
        query.includeKey("user")
        
        // fetch data asynchronously
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil
            { //find succeeded, do something with the objects
                if let objects = objects
                {
                    for object in objects
                    {
                        print(object["text"] )
                    }
                }
                self.msgs = objects!
                self.tableView.reloadData()
            }
            else
            {
                print("Problem fetching message: \(error!.localizedDescription)")
            }
        }
    }
}
