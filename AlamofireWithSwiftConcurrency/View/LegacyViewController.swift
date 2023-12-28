//
//  ViewController.swift
//  AlamofireWithSwiftConcurrency
//
//  Created by Robert Ryan on 12/28/23.
//

import UIKit
import os.log

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "LegacyViewController")

class LegacyViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let networkManager = LegacyNetworkManager.shared
    private let databaseManager = LegacyDatabaseManager.shared

    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        fetch()
    }
}

extension LegacyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.configure(for: posts[indexPath.row])
        return cell
    }
}

private extension LegacyViewController {
    func fetch() {
        logger.debug("fetch; but not easily canceled")

        networkManager.fetch { [weak self] results in
            logger.debug("fetched")

            guard let self else { return }

            switch results {
            case .success(let posts):
                self.posts = posts
                tableView.reloadData()
                DispatchQueue.global().async { [weak self] in
                    do {
                        try self?.databaseManager.save(posts)
                    } catch {
                        DispatchQueue.main.async { [weak self] in
                            logger.error("\(error)")
                            self?.show(error.localizedDescription)
                        }
                    }
                }

            case .failure(let error):
                logger.error("\(error)")
                show(error.localizedDescription)
            }
        }
    }
}
