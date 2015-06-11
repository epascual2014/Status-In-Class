//
//  ViewController.swift
//  Status In Class
//
//  Created by Edrick Pascual on 6/8/15.
//  Copyright (c) 2015 Edrick Pascual. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate {
    

    
    @IBOutlet weak var tableView: UITableView!
    
    var updates: [Update]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // create a var to set the http site to grab the json file
        var urlString = "https://rawgit.com/jamescmartinez/Status/master/updates.json"
        // Must pass strings into NSURL, since strings are not as basic just using a string
        let url = NSURL(string: urlString)
        
        // Request the data to load to app
        let request = NSURLRequest(URL: url!)
        
        // set connection
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        
        
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // check to see if update is nil
        if let updatesCount = updates?.count {
            return updatesCount
        }
        // return nothing and ends program
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // TODO: Make cell reuseable
        
        
        var cell = NSBundle.mainBundle().loadNibNamed("UpdateTableViewCell", owner: self, options: nil).first as! UpdateTableViewCell        
        
        //var cell = UpdateTableViewCell()
        if let updates = updates {
            var update = updates[indexPath.row]
            cell.updateTextLabel?.text = update.text
            
            if let user = update.user {
                cell.handleNameLabel.text = user.handleName
                cell.userNameLabel.text = user.userName
            }
        }
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
        
    }



}

