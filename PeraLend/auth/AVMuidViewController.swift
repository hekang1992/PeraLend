//
//  AVMuidViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/22.
//

import UIKit
import MJRefresh

class AVMuidViewController: BaseViewController {
    
    var productID: String = ""
    
    var model: phrenlikeModel?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(AVMuidTableViewCell.self, forCellReuseIdentifier: "AVMuidTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "center_hea")
        return headImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.backgroundColor = .black
        logoImageView.layer.cornerRadius = 20
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.white
        namelabel.textAlignment = .left
        namelabel.font = UIFont.boldSystemFont(ofSize: 14)
        return namelabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 50)
        moneyLabel.textAlignment = .center
        moneyLabel.textColor = .white
        return moneyLabel
    }()
    
    lazy var amoLabel: UILabel = {
        let amoLabel = UILabel()
        amoLabel.font = UIFont.boldSystemFont(ofSize: 15)
        amoLabel.textAlignment = .center
        amoLabel.textColor = .white
        amoLabel.layer.cornerRadius = 9
        amoLabel.layer.masksToBounds = true
        amoLabel.backgroundColor = UIColor.init(hexStr: "#E34081")
        return amoLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setBackgroundImage(UIImage(named: "apply_imag_d"), for: .normal)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return applyBtn
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "backimage_cep"), for: .normal)
        return backBtn
    }()
    
    lazy var deImageView: UIImageView = {
        let deImageView = UIImageView()
        deImageView.image = UIImage(named: "lu_de_ad")
        return deImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [self] in
            getProductDetailInfo(with: productID)
        })
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProductDetailInfo(with: productID)
    }
    
}

extension AVMuidViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 368
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = self.model?.formee
        let headView = UIView()
        headView.addSubview(headImageView)
        headImageView.addSubview(logoImageView)
        headImageView.addSubview(namelabel)
        headImageView.addSubview(moneyLabel)
        headImageView.addSubview(amoLabel)
        headImageView.addSubview(applyBtn)
        headView.addSubview(deImageView)
        headImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(308)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.left.equalToSuperview().offset(38)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        namelabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(18)
        }
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(14)
            make.size.equalTo(CGSize(width: 250, height: 57))
        }
        amoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moneyLabel.snp.bottom).offset(10)
            make.height.equalTo(26)
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 235, height: 48))
        }
        deImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 302, height: 65))
        }
        namelabel.text = model?.ruptwise ?? ""
        moneyLabel.text = model?.agcheoy?.tinyaci?.officesion ?? ""
        amoLabel.attributedText = NSMutableAttributedString(string: "  \(model?.agcheoy?.tinyaci?.road ?? "")  ")
        let title = self.model?.monitad?.road ?? ""
        applyBtn.setTitle(title, for: .normal)
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AVMuidTableViewCell", for: indexPath) as! AVMuidTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        if let modelArray = self.model?.soliden,!modelArray.isEmpty {
            cell.model = modelArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.model?.soliden?[indexPath.row]
        let salimiddleette = model?.salimiddleette ?? 0
        if salimiddleette == 0 {
            clickProductDetailInfo(with: productID)
        }
    }
    
}

extension AVMuidViewController {
    
    //产品线抗清 ====跳转
    private func getProductDetailInfo(with productID: String) {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/saxaneous", parameters: ["pinguly": productID]) { result in
                switch result {
                case .success(let success):
                    let verscancerern = success.verscancerern
                    if verscancerern == "0" || verscancerern == "00" {
                        let monitad = success.phrenlike?.monitad
                        let viscer = monitad?.viscer ?? ""
                        if !viscer.isEmpty {
                            self.model = success.phrenlike
                        }
                        self.tableView.reloadData()
                    }
                    ViewHud.hideLoadView()
                    self.tableView.mj_header?.endRefreshing()
                    break
                case .failure(_):
                    ViewHud.hideLoadView()
                    self.tableView.mj_header?.endRefreshing()
                    break
                }
            }
    }
    
    //点击获取产品详情
    private func clickProductDetailInfo(with productID: String) {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .postMultipartFormRequest(url: "/plapiall/saxaneous", parameters: ["pinguly": productID]) { result in
                switch result {
                case .success(let success):
                    let verscancerern = success.verscancerern
                    if verscancerern == "0" || verscancerern == "00" {
                        let monitad = success.phrenlike?.monitad
                        let viscer = monitad?.viscer ?? ""
                        if !viscer.isEmpty {
                            if viscer == "brachiality" {
                                self.getFaceAuthInfo()
                            }
                        }
                    }
                    ViewHud.hideLoadView()
                    break
                case .failure(_):
                    ViewHud.hideLoadView()
                    break
                }
            }
    }
    
    //获取是否有上传umid信息
    private func getFaceAuthInfo() {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .getRequest(url: "/plapiall/wallia", parameters: ["pinguly": productID, "type": "auth"]) { result in
            switch result {
            case .success(let success):
                let verscancerern = success.verscancerern
                if verscancerern == "0" || verscancerern == "00" {
                    let gregcasey = success.phrenlike?.gregcasey ?? 0
                    let salimiddleette = success.phrenlike?.physalidpm?.salimiddleette ?? 0
                    if salimiddleette == 0 {//go umid
                        let listVc = AuthListViewController()
                        listVc.productID = self.productID
                        listVc.lystArray = success.phrenlike?.lyst ?? []
                        self.navigationController?.pushViewController(listVc, animated: true)
                    }else {
                        let faceVc = PhotoFaceViewController()
                        faceVc.productID = self.productID
                        self.navigationController?.pushViewController(faceVc, animated: true)
                    }
                }
                ViewHud.hideLoadView()
                break
            case .failure(_):
                ViewHud.hideLoadView()
                break
            }
        }
    }
    
}
