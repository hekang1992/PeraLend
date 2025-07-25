//
//  PhotoFaceViewController.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/22.
//

import UIKit
import TYAlertController
import BRPickerView

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
    
    let locationService = LocationService()  // 保留引用
    var time1: String = ""
    var time2: String = ""
    
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
        
        locationService.startLocation { locationInfo in
            LocationModelSingle.shared.locationInfo = locationInfo
        }
        
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
                time1 = String(Int(Date().timeIntervalSince1970 * 1000))
                let salimiddleette = self.model?.physalidpm?.salimiddleette ?? 0
                if salimiddleette == 1 {
                    ToastConfig.makeToast(form: view, message: "You have already completed the verification and cannot verify again.")
                    return
                }
                
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
                time2 = String(Int(Date().timeIntervalSince1970 * 1000))
                let salimiddleette = self.model?.physalidpm?.salimiddleette ?? 0
                let gregcasey = self.model?.gregcasey ?? 0
                if salimiddleette == 0 {
                    ToastConfig.makeToast(form: view, message: "Please complete identity verification first.")
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
                        ImagePickerHelper.presentCamera(from: self, type: "Camera") { image in
                            if let image = image {
                                // 使用选中的图片
                                self.uploadImage(with: "2",
                                                 pinguly: self.productID,
                                                 potamowise: "10",
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
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.model?.physalidpm?.salimiddleette == 0 || self.model?.gregcasey == 0 {
                ToastConfig.makeToast(form: view, message: "Please complete the verification process first.")
            }else {
                bclickProductDetailInfo(with: productID)
            }
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
                        let unStr = success.phrenlike?.physalidpm?.everybodyior ?? ""
                        self.selectLabel.text = unStr.isEmpty ? self.type : unStr
                        if salimiddleette == 0 {
                            self.threeImageView.image = UIImage(named: "face_three")
                        }else {
                            self.threeImageView.image = UIImage(named: "pho_com_s")
                            if gregcasey == 1 {
                                self.fourImageView.image = UIImage(named: "fac_com_sd")
                            }else {
                                self.fourImageView.image = UIImage(named: "face_four")
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
                let microfic = success.microfic ?? ""
                if verscancerern == "0" || verscancerern == "00" {
                    if let model = success.phrenlike {
                        if potamowise == "11" {
                            alertModel(with: model)
                        }else {
                            self.bclickProductDetailInfo(with: pinguly)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                let locationInfo = LocationModelSingle.shared.locationInfo
                                let probar = locationInfo?["probar"] ?? ""
                                let cyston = locationInfo?["cyston"] ?? ""
                                PongCombineManager.goYourPoint(with: self.productID, type: "4", publicfic: self.time2, probar: probar, cyston: cyston)
                            }
                        }
                    }
                }
                ViewHud.hideLoadView()
                ToastConfig.makeToast(form: view, message: microfic)
                break
            case .failure(_):
                ViewHud.hideLoadView()
                break
            }
        }
    }
    
    private func alertModel(with model: phrenlikeModel) {
        let popView = PopImageSuccessView(frame: CGRectMake(0, 0, screenwidth, screenheight))
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        popView.nameView.phoneTx.text = model.exactlyent ?? ""
        popView.numberView.phoneTx.text = model.crevitive ?? ""
        popView.dateView.phoneTx.text = model.applyess ?? ""
        popView.dateView.clickblock = { [weak self] dateTx in
            guard let self = self else { return }
            self.view.endEditing(true)
            let datePicker = BRDatePickerView()
            datePicker.pickerMode = .YMD
            datePicker.title = "Select Your Time"
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "dd-MM-yyyy"
            if let defaultStr = popView.dateView.phoneTx.text,
               let defaultDate = inputFormatter.date(from: defaultStr) {
                datePicker.selectDate = defaultDate
            } else {
                datePicker.selectDate = Date()
            }
            
            datePicker.resultBlock = { selectDate, selectValue in
                if let date = selectDate {
                    let outputFormatter = DateFormatter()
                    outputFormatter.dateFormat = "dd-MM-yyyy"
                    let dateStr = outputFormatter.string(from: date)
                    dateTx.text = dateStr
                } else if let value = selectValue {
                    dateTx.text = value
                }
            }
            datePicker.show()
        }
        popView.dismissBlock = {
            self.dismiss(animated: true)
        }
        popView.sureBlock = {
            self.saveAuthInfo(with: popView)
        }
    }
    
    private func saveAuthInfo(with listView: PopImageSuccessView) {
        ViewHud.addLoadView()
        let applyess = listView.dateView.phoneTx.text ?? ""
        let crevitive = listView.numberView.phoneTx.text ?? ""
        let exactlyent = listView.nameView.phoneTx.text ?? ""
        let dict = ["potamowise": "11",
                    "everybodyior": type,
                    "applyess": applyess,
                    "crevitive": crevitive,
                    "exactlyent": exactlyent]
        NetworkManager.shared.postMultipartFormRequest(url: "/plapiall/like", parameters: dict) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                let verscancerern = success.verscancerern
                let microfic = success.microfic ?? ""
                if verscancerern == "0" || verscancerern == "00" {
                    self.dismiss(animated: true) {
                        self.getFaceAuthInfo()
                    }
                    //point_three
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        let locationInfo = LocationModelSingle.shared.locationInfo
                        let probar = locationInfo?["probar"] ?? ""
                        let cyston = locationInfo?["cyston"] ?? ""
                        PongCombineManager.goYourPoint(with: self.productID, type: "3", publicfic: self.time1, probar: probar, cyston: cyston)
                    }                    
                }
                ViewHud.hideLoadView()
                ToastConfig.makeToast(form: listView, message: microfic)
                break
            case .failure(_):
                ViewHud.hideLoadView()
                break
            }
        }
    }
    
    
    
}

