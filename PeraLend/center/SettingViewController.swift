//
//  SettingViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import TYAlertController

class SettingViewController: BaseViewController {
    
    lazy var settingView: SettingView = {
        let settingView = SettingView()
        return settingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headView)
        headView.nameLabel.text = "Set Up"
        view.addSubview(settingView)
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: screenwidth, height: 30))
            make.centerX.equalToSuperview()
        }
        
        settingView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(20)
        }
        
        headView.backBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        settingView.twoBlock = { [weak self] in
            guard let self = self else { return }
            ToastConfig.makeToast(form: view, message: "1")
        }
        
        settingView.threeBlock = { [weak self] in
            guard let self = self else { return }
            ToastConfig.makeToast(form: view, message: "2")
        }
        
        settingView.fourBlock = { [weak self] in
            guard let self = self else { return }
            let logView = PopLogoutView(frame: CGRectMake(0, 0, screenwidth, screenheight))
            logView.plendImageView.image = UIImage(named: "logout_Iamge")
            let alertVc = TYAlertController(alert: logView, preferredStyle: .alert)!
            self.present(alertVc, animated: true)
            
            logView.dismissblock = {
                self.dismiss(animated: true)
            }
            
            logView.sureblock = {
                self.getLogout(with: logView)
            }
        }
        
        settingView.fiveBlock = { [weak self] in
            guard let self = self else { return }
            let logView = PopLogoutView(frame: CGRectMake(0, 0, screenwidth, screenheight))
            logView.plendImageView.image = UIImage(named: "delete_IMGE")
            let alertVc = TYAlertController(alert: logView, preferredStyle: .alert)!
            self.present(alertVc, animated: true)
            
            logView.dismissblock = {
                self.dismiss(animated: true)
            }
            
            logView.sureblock = {
                self.getDelete(with: logView)
            }
        }
        
    }
    

}


extension SettingViewController {
    
    private func getLogout(with view: PopLogoutView) {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .getRequest(url: "/plapiall/microfic") { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                ViewHud.hideLoadView()
                let verscancerern = success.verscancerern
                let microfic = success.microfic ?? ""
                if verscancerern == "0" || verscancerern == "00" {
                    LoginBackState.removeLoginInfo()
                    self.dismiss(animated: true) {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
                    }
                }
                ToastConfig.makeToast(form: view, message: microfic)
                break
            case .failure(_):
                ViewHud.hideLoadView()
                break
            }
        }
    }
    
    private func getDelete(with view: PopLogoutView) {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .getRequest(url: "/plapiall/goodfold") { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                ViewHud.hideLoadView()
                let verscancerern = success.verscancerern
                let microfic = success.microfic ?? ""
                if verscancerern == "0" || verscancerern == "00" {
                    LoginBackState.removeLoginInfo()
                    self.dismiss(animated: true) {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
                    }
                }
                ToastConfig.makeToast(form: view, message: microfic)
                break
            case .failure(_):
                ViewHud.hideLoadView()
                break
            }
        }
    }
    
}
