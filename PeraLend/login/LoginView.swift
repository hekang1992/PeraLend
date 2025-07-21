//
//  LoginView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit
import Toast_Swift

var islogin: Bool {
    (UserDefaults.standard.object(forKey: "token") as? String)?.isEmpty == false
}

class LoginView: BaseView {
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "loginde")
        return headImageView
    }()
    
    lazy var footImageView: UIImageView = {
        let footImageView = UIImageView()
        footImageView.image = UIImage(named: "loginfoot")
        return footImageView
    }()
    
    lazy var loImageView: UIImageView = {
        let loImageView = UIImageView()
        loImageView.image = UIImage(named: "login_m")
        loImageView.isUserInteractionEnabled = true
        return loImageView
    }()
    
    lazy var goldImageView: UIImageView = {
        let goldImageView = UIImageView()
        goldImageView.image = UIImage(named: "login_godl")
        return goldImageView
    }()
    
    lazy var oneView: PhoneListView = {
        let oneView = PhoneListView()
        oneView.listImageView.image = UIImage(named: "loginphone")
        oneView.sendImageView.isHidden = true
        oneView.sendBtn.isHidden = true
        return oneView
    }()
    
    lazy var twoView: PhoneListView = {
        let twoView = PhoneListView()
        twoView.listImageView.image = UIImage(named: "loginceo")
        return twoView
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setImage(UIImage(named: "logincli"), for: .normal)
        return loginBtn
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headImageView)
        addSubview(footImageView)
        addSubview(loImageView)
        addSubview(goldImageView)
        loImageView.addSubview(oneView)
        loImageView.addSubview(twoView)
        loImageView.addSubview(loginBtn)
        
        headImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 96))
        }
        
        footImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 161))
        }
        
        loImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 340, height: 368))
        }
        goldImageView.snp.makeConstraints { make in
            make.right.equalTo(loImageView.snp.right).offset(-0)
            make.top.equalTo(headImageView.snp.bottom)
            make.size.equalTo(CGSize(width: 78, height: 78))
        }
        
        oneView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 283, height: 70))
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 283, height: 70))
        }
        
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 235, height: 48))
            make.top.equalTo(twoView.snp.bottom).offset(14)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ToastConfig {
    static func makeToast(form view: UIView, message: String) {
        view.makeToast(message, duration: 2.5, position: .center)
    }
}


class LoginBackState {
    static func saveLogin(phone: String, token: String) {
        UserDefaults.standard.set(phone, forKey: "phone")
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.synchronize()
    }
}
