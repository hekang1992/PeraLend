//
//  BaseViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        return headView
    }()
    
    lazy var listView: BaseView = {
        let listView = BaseView()
        return listView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension BaseViewController {
    
    func popToSelectController() {
        if let navigationController = self.navigationController {
            for viewController in navigationController.viewControllers {
                if let targetVC = viewController as? AVMuidViewController {
                    navigationController.popToViewController(targetVC, animated: true)
                    break
                }
            }
        }
    }
    
}
