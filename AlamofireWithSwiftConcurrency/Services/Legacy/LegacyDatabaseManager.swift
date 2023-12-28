//
//  LegacyDatabaseManager.swift
//  AlamofireWithSwiftConcurrency
//
//  Created by Robert Ryan on 12/28/23.
//

import Foundation

class LegacyDatabaseManager {
    static let shared = LegacyDatabaseManager()

    func save(_ posts: [Post]) throws {
        // make sure we're not on the main queue
        dispatchPrecondition(condition: .notOnQueue(.main))

        // simulate slow save
        let clock = ContinuousClock().now
        while clock.duration(to: .now) < .milliseconds(200) { }
    }
}
