//
//  RepoCell.swift
//  repopulares
//
//  Created by Daniel Warner on 3/22/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit
import Alamofire

class RepoCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(repo: Repository) {
        repoName.text = repo.name
        Alamofire.request(.GET, repo.avatarUrl).response(completionHandler: {
            request, response, data, err in
            
            if err == nil {
                if let img = UIImage(data: data!) {
                    self.repoImg.image = img
                    self.repoImg.layer.cornerRadius = self.repoImg.frame.size.width / 2
                    self.repoImg.clipsToBounds = true
                    
                }
            }
        })
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
