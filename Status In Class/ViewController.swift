//
//  ViewController.swift
//  Status In Class
//
//  Created by Edrick Pascual on 6/8/15.
//  Copyright (c) 2015 Edrick Pascual. All rights reserved.
//

import CoreData
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate {
    

    
    @IBOutlet weak var tableView: UITableView!
    
    var updates = [Update]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // create a var to set the http site to grab the json file
        var urlString = "https://rawgit.com/jamescmartinez/Status/master/updates.json"
        
        // Must pass strings into NSURL, since strings are not as basic just using a string
        let url = NSURL(string: urlString)
        
        // Request the data to load to app
        let request = NSURLRequest(URL: url!)
        
        // set connection
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        

        
        
    }
        
    
        
        
        // TODO: Remove sample data once real data is created
//        
//        updates = [Update]()
//        
//        var user = User()
//        user.handleName = "Edrick"
//        user.bio = "Male"
//        user.userName = "Ed"
//        user.city = "Alameda"
//        user.link = "aboutme.com"
//        
//        for var i = 1; i < 10; i++ {
//            var update = Update()
//            update.date = NSDate()
//            update.text = "Hello there! \(i) "
//            update.user = user
//        
//            // store data
//            updates?.append(update)
//        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // check to see if update is nil
            return updates.count

            }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // TODO: Make cell reuseable
        
        
        var cell = NSBundle.mainBundle().loadNibNamed("UpdateTableViewCell", owner: self, options: nil).first as! UpdateTableViewCell
        
        //var cell = UpdateTableViewCell()
        var update = updates[indexPath.row]
        cell.updateTextLabel?.text = update.text
        
        
        // if let must be removed since User is permanent (not optional)
        let user = update.user
            cell.handleNameLabel.text = user.handleName
            cell.userNameLabel.text = user.userName
        return cell
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 110
        
    }
    
    // MARK: NSURLConnectionDataDelegate - when requesting data, it responds back that it has received it.
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        // check if data is connecting
        // println(data)
        // println(connection)
        
        // store jsonObject
        let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSArray
        println(jsonObject)
        
        
        
        // loop in the dictionary
        for var i = 0; i < jsonObject.count; i++ {
            // store dictionary from the array
            let updateJSON = jsonObject[i] as! [String: AnyObject]
            
            //
            let text = updateJSON["text"] as! String
            let date = updateJSON["date"] as! Int
            let userJSON = updateJSON["user"] as! [String: AnyObject]
            
            
            let link = userJSON["link"] as! String
            let name = userJSON["name"] as! String
            let username = userJSON["username"] as! String
            let city = userJSON["city"] as! String
            let bio = userJSON["bio"] as! String
            
            
            // use to reference the manageobjectcontext from the AppDelegate class
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            // put saved context into the manageObjectContext box
            let context = appDelegate.managedObjectContext!
            
            //
            let update = NSEntityDescription.insertNewObjectForEntityForName("Update", inManagedObjectContext: context) as! Update
            
            // create a entity name for NSEntityDescription
            let updateEntityDescription = NSEntityDescription()
            updateEntityDescription.name = "Update"
            
            // pass the entity to the var update to recognize the relatioship of the NSEntity
            //var update = Update(entity: updateEntityDescription, insertIntoManagedObjectContext: nil)
            
            update.text = text
            // TODO: Convert date integer to NSDate
            
            //
            let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as! User
            
            
            // update the entity description to match the user file
            let userEntityDescription = NSEntityDescription()
            userEntityDescription.name = "User"
            
            // remove this variable once NSEntityDescription has been added above
            //var user = User(entity: userEntityDescription, insertIntoManagedObjectContext: nil)
            
            
            user.handleName = name
            user.userName = username
            user.city = city
            user.bio = bio
            user.link = link
            
            update.user = user
            
            updates.append(update)
            
            // save the context - all the data is moved from the temporary box into a final saving point
            appDelegate.saveContext()
            
            println(updateJSON)
        }
        tableView.reloadData()
        
    }
}

