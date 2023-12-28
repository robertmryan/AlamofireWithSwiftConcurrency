//
//  LegacyNetworkManager.swift
//  AlamofireWithSwiftConcurrency
//
//  Created by Robert Ryan on 12/28/23.
//

import Foundation
import Alamofire

class LegacyNetworkManager {
    static let shared = LegacyNetworkManager()

    private init() { }

    func fetch(completion: @escaping (Result<[Post], AFError>) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/posts")
            .response(responseSerializer: .decodable(of: [Post].self)) { response in
                completion(response.result)
            }
    }
}
