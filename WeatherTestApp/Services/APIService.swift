//
//  APIService.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

final class APIService {
    enum NetworkError: String, Error {
        case redirection = "Redirects occurred"
        case client = "Check whether the input is correct"
        case server = "Server error"
        case other = "Oops, something went wrong"
    }
    
    static let shared = APIService()
    private init() {}
    
    func rxResponse<T: Codable>(by urlString: String?, parameters: [String: Any],  _ completion: @escaping (Observable<T>?, NetworkError?) -> Void) {
        guard let urlString = urlString, var components = URLComponents(string: urlString) else { return }
        components.queryItems = parameters.map({ URLQueryItem(name: $0, value: "\($1)") })
        _ = response(.get, components.url!.absoluteString)
            .subscribe(onNext: { response in
                
                var error: NetworkError?
                switch response.statusCode {
                case 300...399:
                    error = .redirection
                case 400...499:
                    error = .client
                case 500...:
                    error = .server
                default: break
                }
                completion(nil, error)
                
            }, onError: { _ in completion(nil, .other) },
               onCompleted: { completion(decodable(.get, components.url!.absoluteString), nil) })
    }
    
}
