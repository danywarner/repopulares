//
//  ConsultadosVC.swift
//  repopulares
//
//  Created by Daniel Warner on 3/23/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit

class ConsultadosVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var repositories: [Repository] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        repositories = Repository.fetchAll(dbQueue)
        print("cuantos repos: \(repositories.count)")
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "consultedRepoDetailVC" {
            
            if let consultedRepoDetailVC = segue.destinationViewController as? CommitsVC {
                
                if let repo = sender as? Repository {
                    
                    consultedRepoDetailVC.repoName = repo.name
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var repo: Repository
        repo = repositories[indexPath.row]
        performSegueWithIdentifier("consultedRepoDetailVC", sender: repo)

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ConsultedRepoCell") as? ConsultedRepoCell {
            let repo = repositories[indexPath.row]
            cell.configureCell(repo.name)
            return cell
            
        } else {
            return ConsultedRepoCell()
        }
    }
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
