//
//  CenterViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import RxGesture

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
        
        centetrView.fiveImageView.rx.tapGesture().when(.recognized).subscribe(onNext: {_ in 
            let setVc = SettingViewController()
            self.navigationController?.pushViewController(setVc, animated: true)
        }).disposed(by: disposeBag)
        
        centetrView.oneBlock = { [weak self] in
            guard let self = self else { return }
            let listVc = OrderViewController()
            listVc.orderType = "4"
            self.navigationController?.pushViewController(listVc, animated: true)
        }
        
        centetrView.twoBlock = { [weak self] in
            guard let self = self else { return }
            let webVc = WebViewController()
            webVc.pageUrl = base_web_url
            self.navigationController?.pushViewController(webVc, animated: true)
        }
        
        centetrView.threeBlock = { [weak self] in
            guard let self = self else { return }
            let webVc = WebViewController()
            webVc.pageUrl = base_web_url + "/rainbowHoll"
            self.navigationController?.pushViewController(webVc, animated: true)
        }
        
        centetrView.fourBlock = { [weak self] in
            guard let self = self else { return }
            let listVc = OrderViewController()
            listVc.orderType = "7"
            self.navigationController?.pushViewController(listVc, animated: true)
        }
        
        centetrView.fiveBlock = { [weak self] in
            guard let self = self else { return }
            let listVc = OrderViewController()
            listVc.orderType = "6"
            self.navigationController?.pushViewController(listVc, animated: true)
        }
        
        centetrView.sixBlock = { [weak self] in
            guard let self = self else { return }
            let listVc = OrderViewController()
            listVc.orderType = "5"
            self.navigationController?.pushViewController(listVc, animated: true)
        }
        
        centetrView.sevenBlock = { [weak self] in
            guard let self = self else { return }
            let settingVc = SettingViewController()
            self.navigationController?.pushViewController(settingVc, animated: true)
        }
        
        centetrView.eightBlock = { [weak self] in
            guard let self = self else { return }
            let webVc = WebViewController()
            webVc.pageUrl = base_web_url + "/apricotCaul"
            self.navigationController?.pushViewController(webVc, animated: true)
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
