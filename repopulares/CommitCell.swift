//
//  CommitCell.swift
//  repopulares
//
//  Created by Daniel Warner on 3/23/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit

class CommitCell: UITableViewCell {

    
    @IBOutlet weak var commitMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(message: String) {
        commitMessage.text = message
    }

}
