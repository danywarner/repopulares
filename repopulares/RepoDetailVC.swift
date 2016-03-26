//
//  RepoDetailVC.swift
//  repopulares
//
//  Created by Daniel Warner on 3/22/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit
import Alamofire

class RepoDetailVC: UIViewController {

    
    @IBOutlet weak var forksLbl: UILabel!
    @IBOutlet weak var starsLbl: UILabel!
    @IBOutlet weak var repoTitleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var contributor1Lbl: UILabel!
    @IBOutlet weak var contributor2Lbl: UILabel!
    @IBOutlet weak var contributor3Lbl: UILabel!
    @IBOutlet weak var commit1Lbl: UILabel!
    @IBOutlet weak var commit2Lbl: UILabel!
    @IBOutlet weak var commit3Lbl: UILabel!
    
    private var _repository: Repository?
    
    
    
    var repository: Repository {
        get {
            return _repository!
        }
        set {
            _repository = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsTexts()
        downloadContributors()
        downloadCommits()
        let repo = _repository!
        try! repo.save(dbQueue)
    }
    
    
    
    
    
    func setLabelsTexts() {
        repoTitleLbl.text = repository.name
        descriptionLbl.text = repository.repoDescription
        authorLbl.text = repository.author
        starsLbl.text = repository.starsNumber
        forksLbl.text = repository.forksNumber
        
    }
    
    func downloadContributors() {
        Alamofire.request(.GET, repository.contributorsUrl).responseJSON { response in
            
            if let contributors = response.result.value as? Array<AnyObject> {
                guard let contributor1 = contributors[0]["login"] as? String else {return}
                guard let contributor2 = contributors[1]["login"] as? String else {return}
                guard let contributor3 = contributors[2]["login"] as? String else {return}
                self.contributor1Lbl.text = contributor1
                self.contributor2Lbl.text = contributor2
                self.contributor3Lbl.text = contributor3
            }
        }
    }
    
    func downloadCommits()  {
        let g = "{/sha}"
        let issuesUrl = repository.commitsUrl
        let range = issuesUrl.rangeOfString(g)!
        let intIndex: Int = issuesUrl.startIndex.distanceTo(range.startIndex)
        let index1 = issuesUrl.startIndex.advancedBy(intIndex)
        let newString = issuesUrl.substringToIndex(index1)
        
        Alamofire.request(.GET, newString).responseJSON { response in
            
            if let resultsArray = response.result.value as? Array<AnyObject> {
                guard let commit1 = resultsArray[0]["commit"] as? Dictionary<String, AnyObject> else { return }
                guard let message1 = commit1["message"] as? String else{ return }
                self.commit1Lbl.text = message1
                
                guard let commit2 = resultsArray[1]["commit"] as? Dictionary<String, AnyObject> else { return }
                guard let message2 = commit2["message"] as? String else{ return }
                self.commit2Lbl.text = message2
                
                guard let commit3 = resultsArray[2]["commit"] as? Dictionary<String, AnyObject> else { return }
                guard let message3 = commit3["message"] as? String else{ return }
                self.commit3Lbl.text = message3
                
                
                    for x in 0  ..< 30   {
                        guard let commit = resultsArray[x]["commit"] as? Dictionary<String, AnyObject> else { return }
                        guard let message = commit["message"] as? String else{ return }
                        
                        let com = Commit(idRepo: self.repository.name, message: message)
                        try! com.save(dbQueue)
                    }
                }
        }
    }
    
    func persistCommit(repository: String, message: String,counter: Int)  {
        
    }

    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   

}
