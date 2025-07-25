//
//  PhoneContView.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/23.
//

import UIKit
import BRPickerView


class PhoneContView: BaseView {
    
    var rurModelArray: [rurModel] = []
    
    var cellBlock: ((UITextField, rurModel, PhoneTableViewCell, Int) -> Void)?
    
    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.nameLabel.text = "Contact Information"
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(PhoneTableViewCell.self, forCellReuseIdentifier: "PhoneTableViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
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
    
    lazy var plendImageView: UIImageView = {
        let plendImageView = UIImageView()
        plendImageView.image = UIImage(named: "p_four_image")
        return plendImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headView)
        addSubview(plendImageView)
        addSubview(tableView)
        addSubview(nextBtn)
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(30)
            make.left.right.equalToSuperview()
        }
        plendImageView.snp.makeConstraints { make in
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
            make.top.equalTo(plendImageView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhoneContView: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rurModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.rurModelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell", for: indexPath) as! PhoneTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.model = model
        cell.oneBlock = { [weak self] nametx in
            let fodlike = model.fodlike ?? []
            self?.setupPickerView(model: model, textField: nametx, array: fodlike)
        }
        cell.twoBlock = { [weak self] phonetx in
            self?.cellBlock?(phonetx, model, cell, indexPath.row)
        }
        return cell
    }
    
}


extension PhoneContView {
    
    func setupPickerView(model: rurModel, textField: UITextField, array: [fodlikeModel]) {
        let stringPickerView = BRAddressPickerView()
        stringPickerView.pickerMode = .province
        let enumArray = FirstModel.getModelArray(dataSourceArr: array)
        stringPickerView.title = model.officesion ?? ""
        stringPickerView.dataSourceArr = enumArray
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { province, city, area in
            let provinceName = province?.name ?? ""
            textField.text = provinceName
            model.relationText = provinceName
            model.sarcolanditious = province?.code
        }
        stringPickerView.show()
    }
    
}
