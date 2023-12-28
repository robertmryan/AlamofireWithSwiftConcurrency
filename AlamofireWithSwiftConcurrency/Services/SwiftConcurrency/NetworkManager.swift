//
//  NetworkManager.swift
//  AlamofireWithSwiftConcurrency
//
//  Created by Robert Ryan on 12/28/23.
//

import Foundation
import Alamofire

actor NetworkManager {
    static let shared = NetworkManager()

    private init() { }

    func posts() async throws -> [Post] {
        try await AF.request("https://jsonplaceholder.typicode.com/posts")
            .serializingDecodable([Post].self)
            .value
    }
}
