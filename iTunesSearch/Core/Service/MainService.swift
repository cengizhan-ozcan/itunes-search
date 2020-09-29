//
//  MainService.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

protocol ServiceDelegate {
    func send<T: Codable>(api: API, request: T?, completion: @escaping (_ result: Result<T, APIError>) -> Void)
    func send<T: Codable>(api: API, completion: @escaping (_ result: Result<T, APIError>) -> Void)
    func invalidate()
}

class MainService: ServiceDelegate {
    
    static let shared = MainService(codableHelper: CodableHelper(), apiRequest: APIRequest())
    
    private var codableHelper: CodableHelperDelegate!
    private var apiRequest: APIRequestDelegate!
    private var session: URLSession?
    
    init(codableHelper: CodableHelperDelegate, apiRequest: APIRequestDelegate) {
        self.codableHelper = codableHelper
        self.apiRequest = apiRequest
    }
    
    func send<T: Codable>(api: API, request: T? = nil, completion: @escaping (_ result: Result<T, APIError>) -> Void) {
        var http = Http(path: api.endpoint.path, method: api.endpoint.method)
        if let reqObj = request, let body = codableHelper.encode(requestObj: reqObj) {
            http.body = body
        }
        apiRequest.http = http
        session = apiRequest.session
        apiRequest.sendRequest { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let respObj = self?.codableHelper.decode(type: T.self, data: data) else {
                    completion(.failure(.invalidResponseModel))
                    return
                }
                completion(.success(respObj))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func send<T: Codable>(api: API, completion: @escaping (_ result: Result<T, APIError>) -> Void) {
        send(api: api, request: Optional<T>.none, completion: completion)
    }
    
    func invalidate() {
        self.session?.invalidateAndCancel()
    }
}
