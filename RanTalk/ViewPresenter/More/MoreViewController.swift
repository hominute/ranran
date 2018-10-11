//
//  MoreViewController.swift
//  RanTalk
//
//  Created by KIM HO MIN on 9/20/18.
//  Copyright © 2018 HOTOSoft. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    
    
    
    @IBAction func goProfile(_ sender: Any) {
        
         self.performSegue(withIdentifier: "goprofile", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goprofile") {
            
        
            let uvcc = (segue.destination as! ProfileSettingView)
            
            let uds = UserDefaults.standard
            
            let loginuserId = uds.integer(forKey: "userId")
            
            if loginuserId != 0 {
                
                
                
            } else{
                
                return
                
            }
            
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
