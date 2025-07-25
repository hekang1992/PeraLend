//
//  AuthListEnumView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/22.
//

import UIKit
import RxRelay
import WebKit
import RxSwift
import StoreKit

class WebViewController: BaseViewController {

    lazy var webView: WKWebView = {
        let userContentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        let scriptNames = ["rowanwood",
                           "sunflower",
                           "bisonHali",
                           "dogRutaba",
                           "houseWine",
                           "dinosaurJ"]
        scriptNames.forEach { userContentController.add(self, name: $0) }
        configuration.userContentController = userContentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.scrollViewInfoApple {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.contentInsetAdjustmentBehavior = .never
            $0.bounces = false
            $0.alwaysBounceVertical = false
        }
        webView.navigationDelegate = self
        return webView
    }()
        
    var pageUrl: String?
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor.init(hexStr: "#FB7E09")
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.addSubview(headView)
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: screenwidth, height: 30))
            make.centerX.equalToSuperview()
        }
       
        self.headView.backBlock = { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(15)
        }
        
        webView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(2)
        }
        
        if let pageUrl = pageUrl {
            var urlString = ""
            let loginDict = LoginConfig().dictionaryRepresentation
            let url = URLQueryConfig.appendQueryDict(to: pageUrl, parameters: loginDict)!
            urlString = url.replacingOccurrences(of: " ", with: "%20")
            if let url = URL(string: urlString) {
                webView.load(URLRequest(url: url))
            }
        }
        
        webView.rx.observe(String.self, "title")
            .subscribe(onNext: { [weak self] title in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.headView.nameLabel.text = title
                }
            }).disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .map { Float($0) }
            .bind(to: progressView.rx.progress)
            .disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .filter { $0 == 1.0 }
            .subscribe(onNext: { [weak self] _ in
                self?.progressView.setProgress(0.0, animated: false)
                self?.progressView.isHidden = true
            })
            .disposed(by: disposeBag)
        
    }
    
}

extension WebViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let messageName = message.name
       
        if messageName == "toGrade" {
            requestAppReview()
        }else if messageName == "dogRutaba" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
        }else if messageName == "bisonHali" {
            self.navigationController?.popToRootViewController(animated: true)
        }else if messageName == "sunflower" {//跳h5或者原生
            let body = message.body as? String ?? ""
            if body.contains("teffCocoaMus"){
                LoginBackState.removeLoginInfo()
                self.dismiss(animated: true) {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
                }
            }else if body.contains("unicornBrocc") {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
            }else if body.contains("flamingoCypr") {
                let productID = getQueryParameter(from: body, parameterName: "pinguly") ?? ""
                bclickProductDetailInfo(with: productID)
            }
        }else if messageName == "rowanwood" {//bugpoint
            
        }else if messageName == "houseWine" {//email
            let body = message.body
            goEmail(with: body as? String ?? "")
        }
    }
    
    func getQueryParameter(from urlString: String, parameterName: String) -> String? {
        guard let url = URL(string: urlString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        
        return queryItems.first(where: { $0.name == parameterName })?.value
    }
    
    func requestAppReview() {
        if #available(iOS 14.0, *), let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
    
    func goEmail(with email: String) {
        guard let colonRange = email.range(of: ":"),
              email.contains("email:") else {
            return
        }

        let extractedEmail = String(email[colonRange.upperBound...])
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .whitespacesAndNewlines)
            .first ?? ""

        guard !extractedEmail.isEmpty else {
            return
        }

        let phone = UserDefaults.standard.string(forKey: "phone") ?? ""
        let bodyContent = "PeraLend: \(phone)"

        guard let encodedBody = bodyContent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let mailtoURL = URL(string: "mailto:\(extractedEmail)?body=\(encodedBody)"),
              UIApplication.shared.canOpenURL(mailtoURL) else {
            return
        }

        UIApplication.shared.open(mailtoURL)
    }
    
}

extension UIScrollView {
    func scrollViewInfoApple(_ configuration: (UIScrollView) -> Void) {
        configuration(self)
    }
}
