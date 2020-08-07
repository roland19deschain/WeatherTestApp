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
        print(components.url!)
        _ = response(.get, components.url!.absoluteString)
            .subscribe({ response in
                if let error = response.error {
                    completion(nil, error)
                    return
                }
                completion(decodable(.get, urlString), nil)
            })
    }
    
}
