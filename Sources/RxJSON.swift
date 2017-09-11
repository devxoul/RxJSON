import RxSwift

public enum RxJSONError: Error {
  case failedCasting(json: Any, key: String, type: Any.Type)
  case foundNil(json: [String: Any], key: String)
}


// MARK: - ObservableType

public extension ObservableType {
  /// Converts each element to a JSON dictionary and projects each value for given key to a new
  /// observable sequence.
  ///
  /// - parameter key: A key for finding value from each JSON dictionary.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON dictionary or failed to
  ///           find an element with given key.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON(_ key: String) -> Observable<Any> {
    return self.map(_mapJSON(key, Any.self))
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
    return self.map(_mapJSON(key, type))
  }
}


// MARK: - PrimitiveSequence

public extension PrimitiveSequence {
  /// Converts each element to a JSON dictionary and projects each value for given key to a new
  /// observable sequence.
  ///
  /// - parameter key: A key for finding value from each JSON dictionary.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON dictionary or failed to
  ///           find an element with given key.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON(_ key: String) -> PrimitiveSequence<Trait, Element> {
    return self.map(_mapJSON(key, E.self))
  }

  /// Converts each element to a JSON dictionary and projects each value for given key to a new
  /// observable sequence.
  ///
  /// - parameter key: A key for finding value from each JSON dictionary.
  /// - parameter type: A type reference to cast result.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON dictionary or failed to
  ///           cast an element with given key to a given type.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON<T>(_ key: String, _ type: T.Type) -> PrimitiveSequence<Trait, T> {
    return self.map(_mapJSON(key, type))
  }
}


// MARK: - Functions

private func _mapJSON<T>(_ key: String, _ type: T.Type) -> (_ original: Any) throws -> T {
  return { original -> T in
    guard let json = original as? [String: Any] else {
      throw RxJSONError.failedCasting(json: original, key: key, type: [String: Any].self)
    }
    guard let rawValue = json[key] else {
      throw RxJSONError.foundNil(json: json, key: key)
    }
    guard let value = rawValue as? T else {
      throw RxJSONError.failedCasting(json: original, key: key, type: T.self)
    }
    return value
  }
}
