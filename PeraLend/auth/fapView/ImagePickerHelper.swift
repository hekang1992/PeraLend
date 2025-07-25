//
//  ImagePickerHelper.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/22.
//

import UIKit
import AVFoundation
import Photos

class ImagePickerHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var pickerCallback: ((UIImage?) -> Void)?
    
    // MARK: - 获取相机
    class func presentCamera(from viewController: UIViewController, type: String? = "photo", completion: @escaping (UIImage?) -> Void) {
        let helper = ImagePickerHelper()
        helper.pickerCallback = completion
        
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            helper.presentPicker(sourceType: .camera, from: viewController, type: type)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        helper.presentPicker(sourceType: .camera, from: viewController, type: type)
                    } else {
                        showPermissionAlert(from: viewController, feature: "相机")
                    }
                }
            }
        case .denied, .restricted:
            showPermissionAlert(from: viewController, feature: "相机")
        @unknown default:
            break
        }
    }
    
    // MARK: - 获取相册
    class func presentPhotoLibrary(from viewController: UIViewController, completion: @escaping (UIImage?) -> Void) {
        let helper = ImagePickerHelper()
        helper.pickerCallback = completion
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized, .limited:
            helper.presentPicker(sourceType: .photoLibrary, from: viewController, type: "photo")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized || newStatus == .limited {
                        helper.presentPicker(sourceType: .photoLibrary, from: viewController, type: "photo")
                    } else {
                        showPermissionAlert(from: viewController, feature: "相册")
                    }
                }
            }
        case .denied, .restricted:
            showPermissionAlert(from: viewController, feature: "相册")
        @unknown default:
            break
        }
    }
    
    // MARK: - 展示图片选择器
    private func presentPicker(sourceType: UIImagePickerController.SourceType, from viewController: UIViewController, type: String?) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        DispatchQueue.main.async {
            if sourceType == .camera {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = sourceType
                if type == "Camera" {
                    picker.cameraDevice = .front
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self.hiderefdaButton(in: picker.view)
                    }
                }else {
                    picker.cameraDevice = .rear
                }
                picker.allowsEditing = false
                viewController.present(picker, animated: true, completion: nil)
                objc_setAssociatedObject(picker, &ImagePickerHelper.associatedKey, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }else {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = sourceType
                picker.allowsEditing = false
                viewController.present(picker, animated: true, completion: nil)
                objc_setAssociatedObject(picker, &ImagePickerHelper.associatedKey, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    private func hiderefdaButton(in view: UIView) {
        for subview in view.subviews {
            if let button = subview as? UIButton, String(describing: button).contains("CAMFlipButton") {
                button.isHidden = true
            } else {
                hiderefdaButton(in: subview)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true) {
            self.pickerCallback?(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.pickerCallback?(nil)
        }
    }
    
    private class func showPermissionAlert(from vc: UIViewController, feature: String) {
        let alert = UIAlertController(title: "\(feature)权限未开启",
                                      message: "请前往 设置 > 隐私 > \(feature)，开启权限后重试。",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        vc.present(alert, animated: true)
    }
    
    private static var associatedKey = "ImagePickerHelperAssociatedKey"
}
