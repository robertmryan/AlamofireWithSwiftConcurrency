//
//  DatabaseManager.swift
//  AlamofireWithSwiftConcurrency
//
//  Created by Robert Ryan on 12/28/23.
//

import Foundation

// because this is actor, we know it is off the main thread/queue/actor

actor DatabaseManager {
    static let shared = DatabaseManager()

    func save(_ posts: [Post]) throws {
        // simulate slow save
        let clock = ContinuousClock().now
        while clock.duration(to: .now) < .milliseconds(200) { }
    }
}
