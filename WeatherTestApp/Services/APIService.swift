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
    static let shared = APIService()
    private init() {}
    
    func rxResponse<T: Codable>(by urlString: String?, parameters: [String: Any],  _ completion: @escaping (Observable<T>?, Error?) -> Void) {
        guard let urlString = urlString, var components = URLComponents(string: urlString) else { return }
        components.queryItems = parameters.map({ URLQueryItem(name: $0, value: "\($1)") })
        _ = response(.get, components.url!.absoluteString)
            .subscribe(onNext: { response in
                
                switch response.statusCode {
                case 300...:
                    let error = NSError(domain: response.headers.description, code: response.statusCode, userInfo: nil)
                    completion(nil, error)
                default: break
                }
                
            }, onError: { error in completion(nil, error) },
               onCompleted: { completion(decodable(.get, components.url!.absoluteString), nil) })
    }
    
}
