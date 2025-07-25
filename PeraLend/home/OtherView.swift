//
//  OtherView.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/24.
//

import UIKit

class OtherView: BaseView {
    
    var cellBlock: ((nemaModel) -> Void)?

    var homeModel: phrenlikeModel? {
        didSet {
            guard let homeModel = homeModel else { return }
            let nemaArray = homeModel.discussaire?.nema ?? []
            if nemaArray.isEmpty {
                whiteView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(300)
                    make.left.right.bottom.equalToSuperview()
                }
            }else {
                whiteView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(380)
                    make.left.right.bottom.equalToSuperview()
                }
            }
        }
    }
    
    lazy var headView: UIView = {
        let headView = UIView()
        return headView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "reco_image_se")
        return headImageView
    }()
    
    lazy var oveeImageView: UIImageView = {
        let oveeImageView = UIImageView()
        oveeImageView.image = UIImage(named: "de_fa_overview")
        return oveeImageView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setBackgroundImage(UIImage(named: "apply_imag_d"), for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        nextBtn.setTitle("Apply For Funds", for: .normal)
        return nextBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(OtherableViewCell.self, forCellReuseIdentifier: "OtherableViewCell")
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
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 9
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 18
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = .init(hexStr: "#666666")
        descLabel.font = UIFont.boldSystemFont(ofSize: 13)
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 2
        return descLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = .black
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 19)
        moneyLabel.textAlignment = .right
        return moneyLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(whiteView)
        addSubview(tableView)
        whiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(300)
            make.left.right.bottom.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OtherView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let nemaArray = self.homeModel?.discussaire?.nema ?? []
        if nemaArray.isEmpty {
            return 320
        }
        return 400
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nemaArray = self.homeModel?.discussaire?.nema ?? []
        let bigModel = self.homeModel?.polysure?.nema?.first
        headView.addSubview(headImageView)
        headView.addSubview(nextBtn)
        headView.addSubview(oveeImageView)
        
        headImageView.addSubview(logoImageView)
        headImageView.addSubview(nameLabel)
        headImageView.addSubview(descLabel)
        headImageView.addSubview(moneyLabel)
        
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 338, height: 191))
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(headImageView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 235, height: 48))
        }
        oveeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(42)
            make.size.equalTo(CGSize(width: 350, height: 88))
        }
        oveeImageView.isHidden = nemaArray.isEmpty
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 36, height: 36))
            make.top.equalToSuperview().offset(85)
            make.left.equalToSuperview().offset(18)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(11)
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.height.equalTo(16)
        }
        descLabel.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.left.equalTo(logoImageView.snp.right).offset(12)
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(descLabel.snp.centerY)
            make.height.equalTo(16)
            make.left.equalTo(descLabel.snp.right).offset(5)
            make.right.equalToSuperview().offset(-20)
        }
        logoImageView.kf.setImage(with:URL(string: bigModel?.apertaster ?? ""))
        nameLabel.text = bigModel?.ruptwise ?? ""
        descLabel.text = bigModel?.theyine ?? ""
        moneyLabel.text = bigModel?.voluntacy ?? ""
        nextBtn.setTitle(bigModel?.amongel ?? "", for: .normal)
        
        
        
        return self.headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeModel?.cantesque?.nema?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherableViewCell", for: indexPath) as! OtherableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let modelArray = self.homeModel?.cantesque?.nema ?? []
        if modelArray.count > 0 {
            cell.model = modelArray[indexPath.row]
        }
        cell.clickBlock = { [weak self] in
            self?.cellBlock?(modelArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelArray = self.homeModel?.cantesque?.nema ?? []
        let model = modelArray[indexPath.row]
        self.cellBlock?(model)
    }
    
}
