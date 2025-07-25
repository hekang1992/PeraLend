//
//  LoginViewViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import RxSwift
import RxCocoa
import FBSDKCoreKit

class LoginViewController: BaseViewController {
    
    private var codeTimer: Timer?
    private var minSeonsds = 60
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.oneBlock = { [weak self] in
            guard let self = self else { return }
            let webVc = WebViewController()
            webVc.pageUrl = base_web_url + "/apricotCaul"
            self.navigationController?.pushViewController(webVc, animated: true)
        }
        
        loginView.twoBlock = { [weak self] in
            guard let self = self else { return }
            let webVc = WebViewController()
            webVc.pageUrl = base_web_url + "/greenbeanCh"
            self.navigationController?.pushViewController(webVc, animated: true)
        }
        
        loginView.twoView.sendBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let phone = self.loginView.oneView.phoneTx.text ?? ""
            if phone.isEmpty {
                ToastConfig.makeToast(form: view, message: "Please enter your phone")
                return
            }
            //login_code
            getCode()
        }).disposed(by: disposeBag)
    
        
        loginView.loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.getLogin(with: self?.loginView.oneView.phoneTx.text ?? "",
                           code: self?.loginView.twoView.phoneTx.text ?? "")
        }).disposed(by: disposeBag)
        
    }
    
    deinit {
        codeTimer?.invalidate()
    }
    
}

extension LoginViewController {
    
    private func getCode() {
        
        //上报
        getFce_kInfo()
        
        ViewHud.addLoadView()
        let dict = ["pachose": "do",
                    "dyistic": self.loginView.oneView.phoneTx.text ?? ""]
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/dyistic", parameters: dict) { [weak self] result in
            switch result {
            case .success(let success):
                let microfic = success.microfic ?? ""
                guard let self = self else { return }
                ToastConfig.makeToast(form: view, message: microfic)
                startCountdown()
                ViewHud.hideLoadView()
                break
            case .failure(_):
                ViewHud.hideLoadView()
                break
            }
        }
    }
    
    private func getLogin(with phone: String, code: String) {
        ViewHud.addLoadView()
        let dict = ["filiatic": phone, "film": code, "saxaneous": "en"]
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/verscancerern", parameters: dict) { [weak self] result in
                switch result {
                case .success(let success):
                    guard let self = self else { return }
                    let verscancerern = success.verscancerern
                    let microfic = success.microfic ?? ""
                    if verscancerern == "0" || verscancerern == "00" {
                        let phone = success.phrenlike?.filiatic ?? ""
                        let token = success.phrenlike?.plebofficeably ?? ""
                        LoginBackState.saveLogin(phone: phone, token: token)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
                        }
                    }
                    ToastConfig.makeToast(form: view, message: microfic)
                    ViewHud.hideLoadView()
                    break
                case .failure(_):
                    ViewHud.hideLoadView()
                    break
                }
        }
    }
    
    private func startCountdown() {
        loginView.twoView.sendBtn.isEnabled = false
        minSeonsds = 60
        codeTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateCountdown),
            userInfo: nil,
            repeats: true
        )
        
    }
    
    @objc private func updateCountdown() {
        minSeonsds -= 1
        if minSeonsds > 0 {
            loginView.twoView.sendBtn.setTitle("\(minSeonsds)s", for: .normal)
        } else {
            endCountdown()
        }
    }
    
    private func endCountdown() {
        codeTimer?.invalidate()
        codeTimer = nil
        loginView.twoView.sendBtn.isEnabled = true
        loginView.twoView.sendBtn.setTitle("Send", for: .normal)
        
    }
    
    private func getFce_kInfo() {
        let dict = ["ennisuddenlytion": DeviceIdfvManager.shared.getDeviceID(),
                    "ornithsexia": DeviceIdfvManager.shared.getIDFA()]
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/voluntacy", parameters: dict) { [weak self] result in
                switch result {
                case .success(let success):
                    guard let self = self else { return }
                    let verscancerern = success.verscancerern
                    if verscancerern == "0" || verscancerern == "00" {
                        if let affectariumModel = success.phrenlike?.affectarium {
                            faceBookUpModel(from: affectariumModel)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
                            }
                        }
                    }
                    break
                case .failure(_):
                    break
                }
            }
    }
    
    private func faceBookUpModel(from model: affectariumModel) {
        Settings.shared.appID = model.buyen ?? ""
        Settings.shared.clientToken = model.clader ?? ""
        Settings.shared.displayName = model.playaneity ?? ""
        Settings.shared.appURLSchemeSuffix = model.hypnoence ?? ""
        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }
    
}
