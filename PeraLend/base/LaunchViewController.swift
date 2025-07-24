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
        bgImageView.contentMode = .scaleToFill
        return bgImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(bgImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        NetworkStatusManager.shared.startListening()
        
    }
  

}
