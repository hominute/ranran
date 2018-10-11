//
//  MyTableViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class MyTableViewCell: MessageTableViewCell {

    @IBOutlet var message: UILabel!
    
    @IBOutlet var createdDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupCell(message: Message) {
        
        //        self.repoNameLabel.text = repo.title ?? "..."
        //        self.repoDescriptionLabel.text = repo.description ?? "..."
        //        self.ownerLabel.text = "By " + (repo.owner?.username ?? "...")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
