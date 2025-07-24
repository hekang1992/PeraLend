//
//  PhoneTableViewCell.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/23.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {

    var oneBlock: ((UITextField) -> Void)?
    var twoBlock: ((UITextField) -> Void)?
    
    var model: rurModel? {
        didSet {
            guard let model = model else { return }
            namelabel.text = model.officesion ?? ""
            phoneTx.placeholder = model.officesion ?? ""
            nameTx.text = model.relationText ?? ""
            let name = model.exactlyent ?? ""
            if name.isEmpty {
                phoneTx.text = ""
            }else {
                phoneTx.text = (model.exactlyent ?? "") + "-" + (model.mollfier ?? "")
            }
        }
    }

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "phocon_ima_list")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(hexStr: "#F2CC42")
        namelabel.textAlignment = .left
        namelabel.font = UIFont.boldSystemFont(ofSize: 12)
        return namelabel
    }()
    
    lazy var nameTx: UITextField = {
        let nameTx = UITextField()
        nameTx.placeholder = "Choose Your Relationship"
        nameTx.font = UIFont.boldSystemFont(ofSize: 12)
        nameTx.textColor = .black
        nameTx.isEnabled = false
        return nameTx
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.placeholder = "Contact Mode"
        phoneTx.font = UIFont.boldSystemFont(ofSize: 12)
        phoneTx.textColor = .black
        phoneTx.isEnabled = false
        return phoneTx
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.addTarget(self, action: #selector(oneBtnClick(_ :)), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.addTarget(self, action: #selector(twoBtnClick(_ :)), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "fda_faf_gsa_fd")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "fad_fad_fa")
        return twoImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(namelabel)
        bgImageView.addSubview(nameTx)
        bgImageView.addSubview(phoneTx)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.addSubview(oneImageView)
        bgImageView.addSubview(twoImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 347, height: 120))
        }
        namelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(14)
        }
        nameTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalTo(nameTx.snp.bottom)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        oneImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(nameTx.snp.centerY)
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
        twoImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-14)
            make.centerY.equalTo(phoneTx.snp.centerY)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        oneBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        twoBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalTo(nameTx.snp.bottom)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func oneBtnClick(_ sender: UIButton) {
        self.oneBlock?(nameTx)
    }
    
    @objc func twoBtnClick(_ sender: UIButton) {
        self.twoBlock?(phoneTx)
    }

}
