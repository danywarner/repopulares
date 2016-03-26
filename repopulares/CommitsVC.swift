//
//  CommitsVC.swift
//  repopulares
//
//  Created by Daniel Warner on 3/23/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit

class CommitsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var repoName = ""
    var commits: [Commit] = []
    private var settingsParameter: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
        tableView.delegate = self
        tableView.dataSource = self
        commits = Commit.fetchAll(dbQueue, "SELECT * FROM commitbyrepo where idRepo='\(repoName)'")
        tableView.reloadData()
        print(repoName)
    }
    
    
    func loadSettings() {
        let standardUserDefaults = NSUserDefaults.standardUserDefaults()
        if let gg = standardUserDefaults.objectForKey("commitsNumber_preference") as? Double {
            print("parametro: \(Int(gg))")
            settingsParameter = Int(gg)
            
        } else {
            self.registerDefaultsFromSettingsBundle();
        }
    }
    
    func registerDefaultsFromSettingsBundle() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let settingsURL = NSBundle.mainBundle().URLForResource("Root", withExtension: "plist", subdirectory: "Settings.bundle"),
            settings = NSDictionary(contentsOfURL: settingsURL),
            preferences = settings["PreferenceSpecifiers"] as? [NSDictionary] {
            
            var defaultsToRegister = [String: AnyObject]()
            for prefSpecification in preferences {
                if let key = prefSpecification["Key"] as? String,
                    value = prefSpecification["DefaultValue"] {
                    
                    defaultsToRegister[key] = value
                    NSLog("registerDefaultsFromSettingsBundle: (\(key), \(value)) \(value.dynamicType)")
                }
            }
            
            userDefaults.registerDefaults(defaultsToRegister);
        } else {
            NSLog("registerDefaultsFromSettingsBundle: Could not find Settings.bundle");
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("CommitCell") as? CommitCell {
            let commit = commits[indexPath.row]
            cell.configureCell(commit.message)
            return cell
            
        } else {
            return CommitCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if settingsParameter != nil {
            return settingsParameter!
        } else {
            return commits.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
