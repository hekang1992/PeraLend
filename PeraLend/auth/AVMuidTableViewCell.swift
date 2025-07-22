//
//  AVMuidTableViewCell.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/22.
//

import UIKit
import Kingfisher

class AVMuidTableViewCell: UITableViewCell {
    
    var model: solidenModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.outarian ?? ""
            let salimiddleette = model.salimiddleette
            bgImageView.kf.setImage(with: URL(string: logoUrl))
            tagImagView.image = UIImage(named: "indexpath_\(model.viscer ?? "")")
            if salimiddleette == 0 {
                ceImageView.image = UIImage(named: "Certification_\(model.viscer ?? "")")
            }else {
                ceImageView.image = UIImage(named: "adf_adeld")
            }
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        return bgImageView
    }()
    
    lazy var tagImagView: UIImageView = {
        let tagImagView = UIImageView()
        return tagImagView
    }()
    
    lazy var ceImageView: UIImageView = {
        let ceImageView = UIImageView()
        return ceImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgView.addSubview(tagImagView)
        bgImageView.addSubview(ceImageView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 328, height: 120))
        }
        tagImagView.snp.makeConstraints { make in
            make.right.equalTo(bgImageView.snp.right).offset(5)
            make.top.equalTo(bgImageView.snp.top).offset(-5)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        ceImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.left.equalToSuperview().offset(18)
            make.size.equalTo(CGSize(width: 90, height: 13))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
