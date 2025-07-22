//
//  HomeViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import RxRelay
import MJRefresh

class HomeViewController: BaseViewController {
    
    lazy var playView: HomeView = {
        let playView = HomeView()
        return playView
    }()
    
    var homeModel = BehaviorRelay<phrenlikeModel?>(value: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(playView)
        playView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.playView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getHomeDataMessage()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeDataMessage()
    }

    
}

extension HomeViewController {
    
    private func getHomeDataMessage() {
        ViewHud.addLoadView()
        NetworkManager.shared.getRequest(url: "/plapiall/phrenlike") { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self, let homeModel = success.phrenlike else { return }
                let verscancerern = success.verscancerern
                if verscancerern == "0" || verscancerern == "00" {
                    self.homeModel.accept(homeModel)
                    let potamowise = homeModel.polysure?.potamowise ?? ""
                    if potamowise == "partpowerfy" {//a
                        self.playView.homeModel = homeModel
                    }else {//b
                        
                    }
                }
                ViewHud.hideLoadView()
                self.playView.scrollView.mj_header?.endRefreshing()
                break
            case .failure(_):
                ViewHud.hideLoadView()
                self?.playView.scrollView.mj_header?.endRefreshing()
                break
            }
        }
    }
    
}
