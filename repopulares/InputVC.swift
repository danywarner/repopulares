//
//  ViewController.swift
//  repopulares
//
//  Created by Daniel Warner on 3/22/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit
import Alamofire

class InputVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var input: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.delegate = self
        
    }

    override func viewDidAppear(animated: Bool) {
        errorLbl.text = ""
    }

    
    @IBAction func okButtonPressed(sender: AnyObject) {
        if let language = input.text where language != "" {
        
            var requestUrl=DataService.languageReposSearchUrl
            
            requestUrl.appendContentsOf(language.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        
            Alamofire.request(.GET, requestUrl)
                .responseJSON { response in
                    guard let items = response.result.value as? Dictionary<String, AnyObject> else { return }
                    if  items["items"] as? Array<AnyObject> != nil {
                        self.performSegueWithIdentifier("repoListVC", sender: requestUrl)
                    } else {
                        self.errorLbl.text = "No se encontraron resultados!"
                    }
                    
            }
        
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "repoListVC" {
            
            if let repoListVC = segue.destinationViewController as? RepoListVC {
                
                if let requestUrl = sender as? String {
                    
                    repoListVC.requestUrl = requestUrl
                    repoListVC.language = input.text!
                }
            }
        }
    }

}

