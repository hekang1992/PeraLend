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
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "applyimage")
        return bgImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 340, height: 174))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
