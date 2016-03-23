//
//  ConsultedRepoCell.swift
//  repopulares
//
//  Created by Daniel Warner on 3/23/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit

class ConsultedRepoCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configureCell(name: String) {
        repoName.text = name
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
