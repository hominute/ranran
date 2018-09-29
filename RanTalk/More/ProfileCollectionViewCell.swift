//
//  ProfileCollectionViewCell.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/21/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var photoImage: UIImageView!
    
    
    func imageLoad(url: String) {
        let url = URL(string: url)
        
        photoImage?.kf.setImage(with: url)
        
    }
}
