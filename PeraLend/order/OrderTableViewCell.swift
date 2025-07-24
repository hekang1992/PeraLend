//
//  OrderTableViewCell.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/24.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    var model: rurModel? {
        didSet {
            guard let model = model else { return }
            let productLogoUrl = model.sesquireallyment?.apertaster ?? ""
            logoImageView.kf.setImage(with: URL(string: productLogoUrl))
            namelabel.text = model.sesquireallyment?.ruptwise ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "applyimage")
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(hexStr: "#FFFAE6")
        namelabel.textAlignment = .left
        namelabel.font = UIFont.boldSystemFont(ofSize: 12)
        return namelabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(namelabel)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 340, height: 174))
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.left.equalToSuperview().offset(144)
            make.size.equalTo(CGSize(width: 31, height: 31))
        }
        namelabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.height.equalTo(15)
            make.left.equalTo(logoImageView.snp.right).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
