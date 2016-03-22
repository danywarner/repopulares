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
    }
    
    func setLabelsTexts() {
        repoTitleLbl.text = repository.name
        descriptionLbl.text = repository.repoDescription
        authorLbl.text = repository.author
        
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
    
    func downloadCommits() {
        Alamofire.request(.GET, repository.commitsUrl).responseJSON { response in
            
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

  

    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   

}