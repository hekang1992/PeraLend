//
//  PhotoFaceViewController.swift
//  PeraLend
//
//  Created by 何康 on 2025/7/22.
//

import UIKit
import TYAlertController

class PhotoFaceViewController: BaseViewController {
    
    lazy var scrollVeiw: UIScrollView = {
        let scrollVeiw = UIScrollView()
        scrollVeiw.showsHorizontalScrollIndicator = false
        scrollVeiw.showsVerticalScrollIndicator = false
        scrollVeiw.contentInsetAdjustmentBehavior = .never
        return scrollVeiw
    }()
    
    var productID: String = ""
    var type: String = ""
    
    var model: phrenlikeModel?
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "face_one")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "face_two")
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "face_three")
        return threeImageView
    }()
    
    lazy var fourImageView: UIImageView = {
        let fourImageView = UIImageView()
        fourImageView.image = UIImage(named: "face_four")
        return fourImageView
    }()
    
    lazy var footImageView: UIImageView = {
        let footImageView = UIImageView()
        footImageView.image = UIImage(named: "face_foot")
        return footImageView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setBackgroundImage(UIImage(named: "apply_imag_d"), for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        nextBtn.setTitle("Next Step", for: .normal)
        return nextBtn
    }()
    
    lazy var selectLabel: UILabel = {
        let selectLabel = UILabel()
        selectLabel.textColor = UIColor.init(hexStr: "#666666")
        selectLabel.textAlignment = .left
        selectLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return selectLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.nameLabel.text = "Identification Document"
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(CGSize(width: screenwidth, height: 30))
            make.centerX.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            let salimiddleette = self.model?.physalidpm?.salimiddleette ?? 0
            if salimiddleette == 0 {
                self.navigationController?.popViewController(animated: true)
            }else {
                popToSelectController()
            }
        }
        
        view.addSubview(scrollVeiw)
        scrollVeiw.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.width.equalTo(screenwidth)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
        
        scrollVeiw.addSubview(oneImageView)
        scrollVeiw.addSubview(twoImageView)
        scrollVeiw.addSubview(threeImageView)
        scrollVeiw.addSubview(fourImageView)
        scrollVeiw.addSubview(footImageView)
        view.addSubview(nextBtn)
        
        oneImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 341, height: 78))
            make.top.equalToSuperview()
        }
        twoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 347, height: 76))
            make.top.equalTo(oneImageView.snp.bottom).offset(18)
        }
        threeImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 165, height: 178))
            make.left.equalToSuperview().offset(18)
            make.top.equalTo(twoImageView.snp.bottom).offset(18)
        }
        fourImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 165, height: 178))
            make.left.equalTo(threeImageView.snp.right).offset(screenwidth - 365)
            make.top.equalTo(twoImageView.snp.bottom).offset(18)
        }
        footImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 338, height: 307))
            make.top.equalTo(threeImageView.snp.bottom).offset(9)
            make.bottom.equalToSuperview().offset(-20)
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.size.equalTo(CGSize(width: 235, height: 49))
        }
        
        twoImageView.addSubview(selectLabel)
        selectLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.left.equalToSuperview().offset(26)
            make.bottom.equalToSuperview()
        }
        
        selectLabel.text = type
        
        twoImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let salimiddleette = self.model?.physalidpm?.salimiddleette ?? 0
                if salimiddleette == 1 {
                    ToastConfig.makeToast(form: view, message: "You have already completed the verification and cannot verify again.")
                    return
                }else {
                    self.navigationController?.popViewController(animated: true)
                }
            }).disposed(by: disposeBag)
        
        threeImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let popView = PhotoPopView(frame: CGRectMake(0, 0, screenwidth, screenheight))
                let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)!
                self.present(alertVc, animated: true)
                
                popView.photoblock = {
                    self.dismiss(animated: true) {
                        ImagePickerHelper.presentPhotoLibrary(from: self) { image in
                            if let image = image {
                                // 使用选中的图片
                                self.uploadImage(with: "1",
                                                 pinguly: self.productID,
                                                 potamowise: "11",
                                                 everybodyior: self.type,
                                                 image: image)
                            }
                        }
                    }
                }
                
                popView.camerablock = {
                    self.dismiss(animated: true) {
                        ImagePickerHelper.presentCamera(from: self) { image in
                            if let image = image {
                                // 使用选中的图片
                                self.uploadImage(with: "2",
                                                 pinguly: self.productID,
                                                 potamowise: "11",
                                                 everybodyior: self.type,
                                                 image: image)
                            }
                        }
                    }
                }
                
                popView.dismissblock = {
                    self.dismiss(animated: true)
                }
                
            }).disposed(by: disposeBag)
        
        
        fourImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let salimiddleette = self.model?.physalidpm?.salimiddleette ?? 0
                let gregcasey = self.model?.gregcasey ?? 0
                if salimiddleette == 0 {
                    ToastConfig.makeToast(form: view, message: "Please complete identity verification first.")
                    return
                }
                if salimiddleette == 1 {
                    ToastConfig.makeToast(form: view, message: "You have already completed the verification and cannot verify again.")
                    return
                }
                if gregcasey == 1 {
                    ToastConfig.makeToast(form: view, message: "You have already completed the verification and cannot verify again.")
                    return
                }
                let popView = CameraPopView(frame: CGRectMake(0, 0, screenwidth, screenheight))
                let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)!
                self.present(alertVc, animated: true)
                popView.camerablock = {
                    self.dismiss(animated: true) {
                        ImagePickerHelper.presentCamera(from: self) { image in
                            if let image = image {
                                // 使用选中的图片
                                print("获取了相机图片")
                            }
                        }
                    }
                }
                
                popView.dismissblock = {
                    self.dismiss(animated: true)
                }
            }).disposed(by: disposeBag)
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
        }).disposed(by: disposeBag)
        
    }
    
}

extension PhotoFaceViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFaceAuthInfo()
    }
    
    private func getFaceAuthInfo() {
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .getRequest(url: "/plapiall/wallia", parameters: ["pinguly": productID, "type": "auth"]) { result in
                switch result {
                case .success(let success):
                    let verscancerern = success.verscancerern
                    self.model = success.phrenlike
                    if verscancerern == "0" || verscancerern == "00" {
                        let gregcasey = success.phrenlike?.gregcasey ?? 0
                        let salimiddleette = success.phrenlike?.physalidpm?.salimiddleette ?? 0
                        if salimiddleette == 0 {//go umid
                            self.twoImageView.isUserInteractionEnabled = true
                        }else {
                            self.twoImageView.isUserInteractionEnabled = false
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
    
    private func uploadImage(with outor: String,
                             pinguly: String,
                             potamowise: String,
                             everybodyior: String,
                             image: UIImage) {
        let dict = ["outor": outor, "pinguly": pinguly, "potamowise": potamowise, "everybodyior": everybodyior, "during": "", "caus": "1"]
        ViewHud.addLoadView()
        NetworkManager
            .shared
            .uploadImage(url: "/plapiall/proctacious", image: image, parameters: dict) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                let verscancerern = success.verscancerern
                if verscancerern == "0" || verscancerern == "00" {
                    if let model = success.phrenlike {
                        alertModel(with: model)
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
    
    private func alertModel(with model: phrenlikeModel) {
        let popView = PopImageSuccessView(frame: CGRectMake(0, 0, screenwidth, screenheight))
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)!
        self.present(alertVc, animated: true)
        popView.dismissBlock = {
            self.dismiss(animated: true)
        }
        popView.sureBlock = {
            self.dismiss(animated: true) {
                
            }
        }
    }
    
}

