//
//  ApiService.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation
import Alamofire

class ApiService {
    static let shared = ApiService()

    /// Check whether the network is reachable or not
    /// - Returns: Bool
    static func isNetworkReachable() -> Bool {
        if let reachable = NetworkReachabilityManager()?.isReachable {
            return reachable
        }
        return false
    }

    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = ApiServiceConstant.timeoutInterval
        configuration.timeoutIntervalForResource = ApiServiceConstant.timeoutInterval
        configuration.waitsForConnectivity = true

        return Session(
            configuration: configuration,
            eventMonitors: [
                NetworkLogger()
            ]
        )
    }()

    /// Creates async request from request type
    /// - Parameters:
    ///   - type: Request Type
    func requestAsync(type: RequestTypeProtocol) async throws -> Any {

        /// Check for internet connection
        guard ApiService.isNetworkReachable() else {
            let error =  URLError(.notConnectedToInternet)
            throw error
        }

        let requestURL = type.url
        let headers = getRequestHeaders(for: type)
        let encoding: ParameterEncoding = type.method == RequestMethod.get
        ? URLEncoding.default : JSONEncoding.default
//        print(requestURL)
//        print(type.params)
        return try await withCheckedThrowingContinuation({ continuation in
            self.sessionManager.request(requestURL,
                                        method: HTTPMethod(rawValue: type.method.rawValue),
                                        parameters: type.params,
                                        encoding: encoding,
                                        headers: headers)
            .validate()
            .responseData { response in
                do {
                    let data = try ApiService.serializeResponse(response, type)
                    continuation.resume(returning: data)
                } catch {
                    print("async error", error)
                    continuation.resume(throwing: error)
                }
            }
        })
    }

    func uploadFile(fileURl: URL,
                    uploadURl: URL,
                    metaData: [String: String?]? = nil,
                    completeAction: @escaping (Bool) -> Void) {

        var headers: HTTPHeaders = [
            ApiConstants.Header.contentType: "audio/mp4"
        ]
        if let metaData = metaData {
            for (key, value) in metaData {
                headers[key] = value ?? "null"
            }
        }

        self.sessionManager.upload(fileURl, to: uploadURl, method: .put, headers: headers)
            .uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .response { response in
                if response.response?.statusCode == 200 {
                    completeAction(true)
                } else {
                    completeAction(false)
                }
            }
    }

    func getRequestHeaders(for type: RequestTypeProtocol) -> HTTPHeaders? {
        var httpheaders: HTTPHeaders = []
        if type.method != .patch {
            httpheaders[ApiConstants.Header.contentType] = ApiConstants.Header.contentTypeValue
        }
        return httpheaders
    }

    /// Convert response data into json object
    /// - Parameters:
    ///   - response: Request response
    ///   - data: Response data
    /// - Throws: Error
    /// - Returns: Serialised json object
    static func serializeResponse(_ request: AFDataResponse<Data>,
                                  _ type: RequestTypeProtocol? = nil) throws -> Any {

        let response = request.response
        let data = request.data
        _ = request.error
        // Validates the server response code
        guard ((200...201)).contains(response?.statusCode ?? 400) else {
            let error = URLError(.badServerResponse)
            throw error
        }
        guard let data = data,
              !data.isEmpty else {
            throw URLError(.zeroByteResource)
        }
        do {
            let responseData = try ApiService.getResponseDictionary(from: data)
            return responseData
        } catch {
            throw error
        }
    }

    private static func getResponseDictionary(from data: Data) throws -> Any {
       let response = try JSONSerialization
           .jsonObject(with: data, options: [])
       if let responseDic = response as? [String: Any] {
           var returnData: Any = responseDic
           if let dataResponse = responseDic["data"] {
               returnData = dataResponse
           }
           return returnData
       } else {
           throw URLError(.badServerResponse)
       }
   }

    private static func getResponseArray(from data: Data) throws -> Any {
       let response = try JSONSerialization
           .jsonObject(with: data, options: [])
       if let responseDic = response as? [String: Any] {
           var returnData: Any = responseDic
           if let dataResponse = responseDic["data"] {
               returnData = dataResponse
           }
           return returnData
       } else {
           throw URLError(.badServerResponse)
       }
   }

}
