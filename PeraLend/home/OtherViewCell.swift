//
//  OtherViewCell.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/28.
//

import UIKit
import FSPagerView

class OtherViewCell: FSPagerViewCell {
    
    lazy var mlabel: UILabel = {
        let mlabel = UILabel()
        mlabel.textColor = UIColor.white
        mlabel.textAlignment = .left
        mlabel.numberOfLines = 3
        mlabel.font = UIFont.boldSystemFont(ofSize: 12)
        return mlabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mlabel)
        mlabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
