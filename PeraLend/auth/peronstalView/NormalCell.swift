//
//  NormalCell.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/23.
//

import UIKit

class NormalCell: UITableViewCell {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "lis_auy_uu")
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
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.placeholder = "Please Enter"
        phoneTx.font = UIFont.boldSystemFont(ofSize: 12)
        phoneTx.textColor = .black
        return phoneTx
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(namelabel)
        bgImageView.addSubview(phoneTx)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 243, height: 76))
        }

        namelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(14)
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
