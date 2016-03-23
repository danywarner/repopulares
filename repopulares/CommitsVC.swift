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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        commits = Commit.fetchAll(dbQueue, "SELECT * FROM commitbyrepo where idRepo='\(repoName)'")
        tableView.reloadData()
        print(repoName)
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
        return commits.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
