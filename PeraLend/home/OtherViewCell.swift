//
//  OtherViewCell.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/28.
//

import UIKit
import FSPagerView

class OtherViewCell: FSPagerViewCell {
    
    lazy var montherLabel: UILabel = {
        let montherLabel = UILabel()
        montherLabel.textColor = UIColor.white
        montherLabel.textAlignment = .left
        montherLabel.numberOfLines = 3
        montherLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return montherLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(montherLabel)
        montherLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
