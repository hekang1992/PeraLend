//
//  BankWalletView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/23.
//

import UIKit
import BRPickerView

class BankWalletView: BaseView {
    
    var wallBlock: ((UIButton, UIButton) -> Void)?
    var bankBlock: ((UIButton, UIButton) -> Void)?
    
    var cellBlock: ((consumerfierModel) -> Void)?
    
    var consumerfierArray: [consumerfierModel] = []

    lazy var headView: HeadView = {
        let headView = HeadView()
        headView.nameLabel.text = "Payment Binding"
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
        plendImageView.image = UIImage(named: "p_last_image")
        return plendImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setImage(UIImage(named: "wall_sel"), for: .selected)
        oneBtn.setImage(UIImage(named: "wall_nor"), for: .normal)
        oneBtn.isSelected = true
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setImage(UIImage(named: "bank_sel"), for: .selected)
        twoBtn.setImage(UIImage(named: "bank_nor"), for: .normal)
        return twoBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headView)
        addSubview(plendImageView)
        addSubview(oneBtn)
        addSubview(twoBtn)
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
        oneBtn.snp.makeConstraints { make in
            make.top.equalTo(plendImageView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 140, height: 38))
            make.left.equalToSuperview().offset(38)
        }
        twoBtn.snp.makeConstraints { make in
            make.top.equalTo(plendImageView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 140, height: 38))
            make.right.equalToSuperview().offset(-38)
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.size.equalTo(CGSize(width: 235, height: 49))
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(oneBtn.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.wallBlock?(oneBtn, twoBtn)
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.bankBlock?(oneBtn, twoBtn)
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BankWalletView: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.consumerfierArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.consumerfierArray[indexPath.row]
        let cal = model.cal ?? ""
        if cal == "bothage" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NormalCell", for: indexPath) as! NormalCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = model
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnumCell", for: indexPath) as! EnumCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = model
            cell.cellBlock = { [weak self] tx in
                guard let self = self else { return }
                self.endEditing(true)
                let listArray = model.readize ?? []
                let cal = model.cal ?? ""
                if cal == "squamform" {
                    setupPickerView(model: model, textField: tx, array: listArray)
                }else {
                    let modelArray = AdressModelSingle.shared.modelArray ?? []
                    setupadressPickerView(model: model, textField: tx, array: modelArray)
                }
            }
            return cell
        }
        
    }
    
    
}


extension BankWalletView {
    
    func setupPickerView(model: consumerfierModel, textField: UITextField, array: [readizeModel]) {
        let stringPickerView = BRAddressPickerView()
        stringPickerView.pickerMode = .province
        let enumArray = FirstModel.getFirstModelArray(dataSourceArr: array)
        stringPickerView.title = model.road ?? ""
        stringPickerView.dataSourceArr = enumArray
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { province, city, area in
            let provinceName = province?.name ?? ""
            textField.text = provinceName
            model.chlor = provinceName
            model.potamowise = province?.code
        }
        stringPickerView.show()
    }
    
    func setupadressPickerView(model: consumerfierModel, textField: UITextField, array: [BRProvinceModel]) {
        let stringPickerView = BRAddressPickerView()
        stringPickerView.pickerMode = .area
        stringPickerView.title = model.road ?? ""
        stringPickerView.dataSourceArr = array
        stringPickerView.selectIndexs = [0]
        stringPickerView.resultBlock = { province, city, area in
            let provinceName = province?.name ?? ""
            let cityName = city?.name ?? ""
            let areaName = area?.name ?? ""
            let addressString = provinceName + "-" + cityName + "-" + areaName
            textField.text = addressString
            model.chlor = addressString
            model.potamowise = addressString
        }
        stringPickerView.show()
    }
    
}
