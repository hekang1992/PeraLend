//
//  PersonalView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/23.
//

import UIKit

class PersonalView: BaseView {

    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.nameLabel.text = "Information Confirmation"
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(NormalCell.self, forCellReuseIdentifier: "NormalCell")
        tableView.register(EnumCell.self, forCellReuseIdentifier: "EnumCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setBackgroundImage(UIImage(named: "apply_imag_d"), for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        nextBtn.setTitle("Next Step", for: .normal)
        return nextBtn
    }()
    
    lazy var ctImageView: UIImageView = {
        let ctImageView = UIImageView()
        ctImageView.image = UIImage(named: "p_one_image")
        return ctImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headView)
        addSubview(ctImageView)
        addSubview(tableView)
        addSubview(nextBtn)
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(30)
            make.left.right.equalToSuperview()
        }
        ctImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 341, height: 78))
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.size.equalTo(CGSize(width: 235, height: 49))
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(ctImageView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
