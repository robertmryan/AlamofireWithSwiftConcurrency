//
//  SwiftConcurrencyViewController.swift
//  AlamofireWithSwiftConcurrency
//
//  Created by Robert Ryan on 12/28/23.
//

import UIKit
import os.log

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SwiftConcurrencyViewController")

class SwiftConcurrencyViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let networkManager = NetworkManager.shared
    private let databaseManager = DatabaseManager.shared

    private var task: Task<Void, Error>?

    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        logger.debug("launching task")
        task = Task { await fetch() }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        logger.debug("canceling (if not already done)")
        task?.cancel()
    }
}

extension SwiftConcurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.configure(for: posts[indexPath.row])
        return cell
    }
}

private extension SwiftConcurrencyViewController {
    func fetch() async {
        do {
            logger.debug("fetching")
            posts = try await networkManager.posts()
            logger.debug("fetched")
            tableView.reloadData()
            try await databaseManager.save(posts)
        } catch {
            logger.error("\(error)")
            show(error.localizedDescription)
        }
    }
}
