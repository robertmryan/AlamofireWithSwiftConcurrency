//
//  Post.swift
//  AlamofireWithSwiftConcurrency
//
//  Created by Robert Ryan on 12/28/23.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
