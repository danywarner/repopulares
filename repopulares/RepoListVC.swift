//
//  RepoListVC.swift
//  repopulares
//
//  Created by Daniel Warner on 3/22/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit
import Alamofire

class RepoListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var languageLbl: UILabel!
    private var _language: String!
    private var repositories = [Repository]()
    private var _requestUrl: String?
    
    var language: String {
        get {
            return _language
        }
        set {
            _language = newValue
        }
    }
    
    
    var requestUrl: String {
        get {
            if _requestUrl != nil {
                return _requestUrl!
            } else {
                return ""
            }
        }
        set {
            _requestUrl = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        languageLbl.text = "\(language) repositories"
        downloadReposData()
        tableView.reloadData()
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("RepoCell") as? RepoCell {
            
            let repo = repositories[indexPath.row]
            cell.configureCell(repo)
            return cell
            
        } else {
            return RepoCell()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func downloadReposData() {
        Alamofire.request(.GET, requestUrl)
            .responseJSON { response in
                if let items = response.result.value as? Dictionary<String, AnyObject> {
                    
                    if let itemsArray = items["items"] as? Array<AnyObject> {
                        for item in itemsArray {
                            guard let repo = item as? AnyObject else {return}
                            guard let repoName = repo["name"] as? String else { print("error1"); return}
                            guard let repoDescription = repo["description"] as? String else { print("error2"); return}
                            guard let contributorsUrl = repo["contributors_url"] as? String else { print("error3"); return}
                            guard let commitsUrl = repo["commits_url"] as? String else { print("error4"); return}
                            guard let owner = repo["owner"] as? Dictionary<String, AnyObject> else { print("error5"); return}
                            guard let author = owner["login"] as? String else { print("error6"); return}
                            guard let avatarUrl = owner["avatar_url"] as? String else { print("error7"); return}
                            let repo2 = Repository(name: repoName, avatarUrl: avatarUrl , description: repoDescription, author: author, contributorsUrl: contributorsUrl, commitsUrl: commitsUrl)
                            self.repositories.append(repo2)
                        }
                    }
                }
                self.tableView.reloadData()
        }
    }


    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}