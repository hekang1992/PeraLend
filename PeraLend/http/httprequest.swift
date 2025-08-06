//
//  httprequest.swift
//  PeraLend
//
//  Created by Jennifer Adams on 2025/7/21.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    func getRequest(
        url: String,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        let loginDict = LoginConfig().dictionaryRepresentation
        let apiUrl = URLQueryConfig.appendQueryDict(to: base_url + url, parameters: loginDict) ?? ""
        AF.request(
            apiUrl,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: BaseModel.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }
    
    func postRequest(
        url: String,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        let loginDict = LoginConfig().dictionaryRepresentation
        let apiUrl = URLQueryConfig.appendQueryDict(to: base_url + url, parameters: loginDict) ?? ""
        AF.request(
            apiUrl,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: BaseModel.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }
    
    func postMultipartFormRequest(
        url: String,
        parameters: [String: Any],
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        let loginDict = LoginConfig().dictionaryRepresentation
        let apiUrl = URLQueryConfig.appendQueryDict(to: base_url + url, parameters: loginDict) ?? ""
        
        AF.upload(
            multipartFormData: { multipartFormData in
                
                for (key, value) in parameters {
                    if let stringValue = "\(value)".data(using: .utf8) {
                        multipartFormData.append(stringValue, withName: key)
                    }
                }
                
            },
            to: apiUrl,
            method: .post,
            headers: headers
        )
        .validate()
        .responseDecodable(of: BaseModel.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }
    
    
    func uploadImage(
        url: String,
        image: UIImage,
        imageName: String? = nil,
        parameters: [String: String]? = nil,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        
        guard let imageData = ImageProviderData.compressImage(image) else {
            let error = NSError(domain: "NetworkError", code: -1,
                                userInfo: [NSLocalizedDescriptionKey: "failure_image"])
            completion(.failure(error))
            return
        }
        
        let fileName = imageName ?? "\(Int(Date().timeIntervalSince1970)).jpg"
        
        let loginDict = LoginConfig().dictionaryRepresentation
        let apiUrl = URLQueryConfig.appendQueryDict(to: base_url + url, parameters: loginDict) ?? ""
        
        AF.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(
                    imageData,
                    withName: "metrally",
                    fileName: fileName,
                    mimeType: "image/jpeg"
                )
                
                parameters?.forEach { key, value in
                    if let valueData = value.data(using: .utf8) {
                        multipartFormData.append(valueData, withName: key)
                    }
                }
            },
            to: apiUrl,
            headers: headers
        )
        .validate()
        .uploadProgress { progress in
            
            print("progress======: \(progress.fractionCompleted)")
        }
        .responseDecodable(of: BaseModel.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }
    
    private func handleResponse(
        _ response: DataResponse<BaseModel, AFError>,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        switch response.result {
        case .success(let value):
            let verscancerern = value.verscancerern
            if verscancerern == "-2" {
                LoginBackState.removeLoginInfo()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHANGEROOTPAGE"), object: nil)
                return
            }
            completion(.success(value))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

struct URLQueryConfig {
    static func appendQueryDict(to urlString: String, parameters: [String: String]) -> String? {
        guard var components = URLComponents(string: urlString) else { return nil }
        
        let existingItems = components.queryItems ?? []
        let newItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = existingItems + newItems
        
        return components.url?.absoluteString
    }
    
}

class ImageProviderData {
    
    static func compressImage(_ image: UIImage, maxKB: Int = 500) -> Data? {
        let maxBytes = maxKB * 1024
        var compression: CGFloat = 0.9
        var imageData: Data?
        var currentImage = image
        
        for _ in 0..<6 {
            imageData = currentImage.jpegData(compressionQuality: compression)
            if let data = imageData, data.count <= maxBytes {
                return data
            }
            compression -= 0.15
        }
        
        
        var scale: CGFloat = 0.8
        while scale >= 0.3 {
            let newSize = CGSize(
                width: currentImage.size.width * scale,
                height: currentImage.size.height * scale
            )
            
            UIGraphicsBeginImageContext(newSize)
            currentImage.draw(in: CGRect(origin: .zero, size: newSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            guard let resizedImage = resizedImage else { break }
            currentImage = resizedImage
            
            
            imageData = currentImage.jpegData(compressionQuality: 0.5)
            if let data = imageData, data.count <= maxBytes {
                return data
            }
            
            scale -= 0.1
        }
        
        
        return imageData
    }
}
