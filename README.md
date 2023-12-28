#  AlamofireWithSwiftConcurrency

In response to https://stackoverflow.com/a/77724607/1271826, this illustrates:

 * How one would use legacy Alamofire API with completion handlers; `LegacyViewController` calling `LegacyNetworkManager` and `LegacyDatabaseManager` with GCD; and
 * How one might adopt Swift concurrency (async-await) with Alamofire to enjoy cancelable API calls; `SwiftConcurrencyViewController` calling `NetworkManager` and `DatabaseManager`.

This is a trivial example, fetching an array of `Post` objects from https://jsonplaceholder.typicode.com/posts. But hopefully it illustrates the difference between legacy GCD API and contemporary Swift concurrency.

- - -

## Build configuration

Built in Xcode 15.1 and Swift 5.9.2.

- - -

## License

28 December 2023

Copyright © 2023 Robert M. Ryan. All Rights Reserved.

See [License](LICENSE.md).
