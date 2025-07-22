//
//  HomeView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/21.
//

import UIKit

let screenwidth = UIScreen.main.bounds.size.width
let screenheight = UIScreen.main.bounds.size.height

class HomeView: BaseView {
    
    var applyBlock: (() -> Void)?
    
    var homeModel: phrenlikeModel? {
        didSet {
            guard let homeModel = homeModel else { return }
            let model = homeModel.polysure?.nema?.first
            applyBtn.setTitle(model?.amongel ?? "", for: .normal)
            moneyLabel.text =  model?.voluntacy ?? ""
            let desc = model?.theyine ?? ""
            amoLabel.attributedText = NSMutableAttributedString(string: "  \(desc)  ")
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "home_one_head")
        headImageView.isUserInteractionEnabled = true
        return headImageView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setBackgroundImage(UIImage(named: "apply_imag_d"), for: .normal)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return applyBtn
    }()
    
    lazy var clickLabel: UILabel = {
        let clickLabel = UILabel()
        clickLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        let fullText = "Take a moment to read the loan terms before applying."
        let attributedString = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: "loan terms") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: nsRange)
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor.init(hexStr: "#5F20B1")!,
                                          range: nsRange)
        }
        clickLabel.attributedText = attributedString
        clickLabel.numberOfLines = 0
        clickLabel.textAlignment = .center
        clickLabel.isUserInteractionEnabled = true
        clickLabel.font = UIFont.systemFont(ofSize: 12)
        return clickLabel
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "desc_iamge_da")
        return oneImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Funding Disbursement"
        descLabel.font = UIFont.boldSystemFont(ofSize: 14)
        descLabel.textColor = UIColor.init(hexStr: "#935500")
        descLabel.textAlignment = .left
        return descLabel
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "gold_iage")
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "foot_imge_da")
        return threeImageView
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 50)
        moneyLabel.textAlignment = .center
        moneyLabel.textColor = .white
        return moneyLabel
    }()
    
    lazy var amoLabel: UILabel = {
        let amoLabel = UILabel()
        amoLabel.font = UIFont.boldSystemFont(ofSize: 15)
        amoLabel.textAlignment = .center
        amoLabel.textColor = .white
        amoLabel.layer.cornerRadius = 9
        amoLabel.layer.masksToBounds = true
        amoLabel.backgroundColor = UIColor.init(hexStr: "#E34081")
        return amoLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(headImageView)
        headImageView.addSubview(moneyLabel)
        headImageView.addSubview(amoLabel)
        headImageView.addSubview(applyBtn)
        scrollView.addSubview(clickLabel)
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(descLabel)
        scrollView.addSubview(twoImageView)
        scrollView.addSubview(threeImageView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(screenwidth)
            make.height.equalTo(443)
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 235, height: 48))
        }
        clickLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(9)
            make.height.equalTo(15)
        }
        oneImageView.snp.makeConstraints { make in
            make.centerX.equalTo(headImageView.snp.centerX)
            make.size.equalTo(CGSize(width: 356, height: 88))
            make.top.equalTo(clickLabel.snp.bottom).offset(15)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(15)
        }
        twoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(headImageView.snp.centerX)
            make.size.equalTo(CGSize(width: 338, height: 148))
            make.top.equalTo(descLabel.snp.bottom)
        }
        threeImageView.snp.makeConstraints { make in
            make.centerX.equalTo(headImageView.snp.centerX)
            make.size.equalTo(CGSize(width: 375, height: 135))
            make.top.equalTo(twoImageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-90)
        }
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(84)
            make.size.equalTo(CGSize(width: 250, height: 57))
        }
        amoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moneyLabel.snp.bottom).offset(10)
            make.height.equalTo(26)
        }
        
        headImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.applyBlock?()
            }).disposed(by: disposeBag)
        
        applyBtn
            .rx
            .tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.applyBlock?()
            }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
