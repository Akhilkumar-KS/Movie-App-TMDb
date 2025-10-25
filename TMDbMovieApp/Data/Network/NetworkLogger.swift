//
//  NetworkLogger.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation
import Alamofire

class NetworkLogger: EventMonitor {
    func requestDidFinish(_ request: Request) {
        logRequest(request.request!)
    }
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        guard let data = response.data else {
            return
        }
        logResponse(request: request, data: data)
    }
    private func logRequest(_ request: URLRequest) {
        print("\n<----- Request ----->")
        if let method = request.httpMethod {
            print("\nMethod: \(method)")
        }
        if let url = request.url?.absoluteString {
            print("\nURL: \(url)")
        }
        if let headers = request.allHTTPHeaderFields {
            print("\nHeaders: \(headers)")
        }
        if let body = request.httpBody {
            print("\nBody: \(body.prettyPrintFormat())")
        }
        print("<-------------------->")
    }
    private func logResponse(request: Request, data: Data) {
        print("\n<----- Response ----->")
        print("\nStatus Code: \(request.response?.statusCode ?? -1)")
        print("\nHeaders: \(String(describing: request.response?.headers))")
        print("\nResponseBody: \(data.prettyPrintFormat())")
        print("\n<--------------------->")

    }
    private func logResponseError(request: Request, error: AFError) {
        print("\n<----- Response Error ----->")
        print("Status Code: \(request.response?.statusCode ?? -1)")
        print("Error: \(error)")
        print("<-------------------------->")
    }
}
