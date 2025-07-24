//
//  OrderViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/24.
//

import UIKit

class OrderViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headView)
        headView.nameLabel.text = "Order List"
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: screenwidth, height: 30))
            make.centerX.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            popToSelectController()
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
