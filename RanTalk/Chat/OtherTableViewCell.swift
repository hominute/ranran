//
//  OtherTableViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/1/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import Kingfisher

class OtherTableViewCell: MessageTableViewCell {

    var userId = Int64()
    
    @IBOutlet var message: UILabel!
    
    
    @IBOutlet var createdDate: UILabel!
    
    
    @IBOutlet var friendImage: UIButton!
    
    @IBAction func friendInfo(_ sender: Any) {
        
        
        self.delegte?.UserinfoCallback(userId: userId)
        
        
    }
    var delegte : UserinfoProtocol?
    
    func imageLoad(url: String) {
        let url = URL(string: url)
        
        let modifier = AnyImageModifier { return $0.withRenderingMode(.alwaysOriginal) }
//        let resource = ImageResource(downloadURL: url!, cacheKey: "my_avatar")
        friendImage?.kf.setImage(with: url, for: .normal,  placeholder: nil, options: [.imageModifier(modifier)], progressBlock: nil, completionHandler: nil)
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
