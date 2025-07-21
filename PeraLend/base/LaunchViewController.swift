//
//  LaunchViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit

class LaunchViewController: UIViewController {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launchimage")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
