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
    
    lazy var clickLabel: UILabel = {
        let clickLabel = UILabel()
        clickLabel.numberOfLines = 0
        clickLabel.textAlignment = .center
        let fullText = "It is important to note that before obtaining a loan, you are required to read and consent to our Privacy Policy and Loan Terms."
        let privacyPolicyRange = (fullText as NSString).range(of: "Privacy Policy")
        let loanTermsRange = (fullText as NSString).range(of: "Loan Terms")
        
        let attributedText = NSMutableAttributedString(string: fullText)
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        attributedText.addAttributes(linkAttributes, range: privacyPolicyRange)
        attributedText.addAttributes(linkAttributes, range: loanTermsRange)
        
        clickLabel.attributedText = attributedText
        
        clickLabel.font = UIFont.systemFont(ofSize: 14)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        clickLabel.addGestureRecognizer(tapGesture)
        clickLabel.isUserInteractionEnabled = true
        
        return clickLabel
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
        addSubview(clickLabel)
        
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
        
        clickLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(36)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let text = clickLabel.attributedText?.string else { return }
        
        let privacyPolicyRange = (text as NSString).range(of: "Privacy Policy")
        let loanTermsRange = (text as NSString).range(of: "Loan Terms")
        
        let tapLocation = gesture.location(in: clickLabel)
        guard let index = characterIndexAtLocation(location: tapLocation, in: clickLabel) else { return }
        
        if NSLocationInRange(index - 8, privacyPolicyRange) {
            print("Tapped on Privacy Policy")
            self.oneBlock?()
        } else if NSLocationInRange(index - 8, loanTermsRange) {
            print("Tapped on Loan Terms")
            self.twoBlock?()
        }
    }
    
    func characterIndexAtLocation(location: CGPoint, in label: UILabel) -> Int? {
        guard let attributedText = label.attributedText else { return nil }
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineBreakMode = label.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let index = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return index
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
    
    static func removeLoginInfo() {
        UserDefaults.standard.set("", forKey: "phone")
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.synchronize()
    }
}
