//
//  LoginView.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/21.
//

import UIKit
import Toast_Swift

var islogin: Bool {
    (UserDefaults.standard.object(forKey: "token") as? String)?.isEmpty == false
}

class LoginView: BaseView {
    
    var oneBlock: (() -> Void)?
    var twoBlock: (() -> Void)?
    
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
    
    lazy var surePrivacyBtn: UIButton = {
        let surePrivacyBtn = UIButton(type: .custom)
        surePrivacyBtn.isSelected = true
        surePrivacyBtn.setImage(UIImage(named: "logn_sure_noe"), for: .normal)
        surePrivacyBtn.setImage(UIImage(named: "logn_sure_imge"), for: .selected)
        return surePrivacyBtn
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.delegate = self
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = []
        textView.backgroundColor = .clear
        
        let fullText = "It is important to note that before obtaining a loan, you are required to read and consent to our Privacy Policy and Loan Terms."
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let privacyPolicyRange = (fullText as NSString).range(of: "Privacy Policy")
        let loanTermsRange = (fullText as NSString).range(of: "Loan Terms")
        
        attributedString.addAttribute(.link, value: "https://www.google.com", range: privacyPolicyRange)
        attributedString.addAttribute(.link, value: "https://www.apple.com", range: loanTermsRange)
        
        textView.attributedText = attributedString
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        return textView
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
        addSubview(textView)
        addSubview(surePrivacyBtn)
        
        headImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
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
        
        textView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-36)
            make.top.equalTo(loImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(41)
        }
        
        surePrivacyBtn.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.top).offset(10)
            make.right.equalTo(textView.snp.left).offset(-2)
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
        
        surePrivacyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            surePrivacyBtn.isSelected.toggle()
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension LoginView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let pageUrl = URL.absoluteString
        if pageUrl.contains("google") {
            self.oneBlock?()
        }else {
            self.twoBlock?()
        }
        return false
    }
}

class ShowHudConfig {
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
    
    static func removeLoginInfo() {
        UserDefaults.standard.set("", forKey: "phone")
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.synchronize()
    }
}
