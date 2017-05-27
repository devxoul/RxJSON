import RxSwift

public enum RxJSONError: Error {
  case failedCasting(json: Any, key: String, type: Any.Type)
  case foundNil(json: [String: Any], key: String)
}

public extension ObservableType where E: Any {
  /// Converts each element to a JSON dictionary and projects each value for given key to a new
  /// observable sequence.
  ///
  /// - parameter key: A key for finding value from each JSON dictionary.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON dictionary or failed to
  ///           find an element with given key.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON(_ key: String) -> Observable<Any> {
    return self.map { any in
      guard let json = any as? [String: Any] else {
        throw RxJSONError.failedCasting(json: any, key: key, type: [String: Any].self)
      }
      guard let value = json[key] else {
        throw RxJSONError.foundNil(json: json, key: key)
      }
      return value
    }
  }

  /// Converts each element to a JSON dictionary and projects each value for given key to a new
  /// observable sequence.
  ///
  /// - parameter key: A key for finding value from each JSON dictionary.
  /// - parameter type: A type reference to cast result.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON dictionary or failed to
  ///           cast an element with given key to a given type.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON<T>(_ key: String, _ type: T.Type) -> Observable<T> {
    return self.map { any in
      guard let json = any as? [String: Any] else {
        throw RxJSONError.failedCasting(json: any, key: key, type: [String: Any].self)
      }
      guard let value = json[key] as? T else {
        throw RxJSONError.failedCasting(json: any, key: key, type: T.self)
      }
      return value
    }
  }
}

public extension ObservableType where E == Dictionary<String, Any> {
  /// Converts each element to a JSON dictionary and projects each value for given key to a new
  /// observable sequence.
  ///
  /// - parameter key: A key for finding value from each JSON dictionary.
  /// - throws: `RxJSONError` when failed to cast an element with given key to a given type.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON(_ key: String) -> Observable<[String: Any]> {
    return self.map { json in
      guard let value = json[key] as? [String: Any] else {
        throw RxJSONError.failedCasting(json: json, key: key, type: [String: Any].self)
      }
      return value
    }
  }
}
