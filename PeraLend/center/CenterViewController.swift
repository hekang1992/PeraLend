//
//  CenterViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit

class CenterViewController: BaseViewController {
    
    lazy var centetrView: CenterView = {
        let centetrView = CenterView()
        return centetrView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(centetrView)
        centetrView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
