import RxSwift

public enum Accessor {
  case key(String)
  case index(Int)
}

public enum RxJSONError: Error {
  case castingFailed(json: Any, accessor: Accessor, type: Any.Type)
  case valueNotFound(json: Any, accessor: Accessor)
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
    return self.map(mapJSONDictionary(key, Any.self))
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
    return self.map(mapJSONDictionary(key, type))
  }

  /// Converts each element to a JSON array and projects each value for given index to a new
  /// observable sequence.
  ///
  /// - parameter index: An index for finding value from each JSON array.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON array or failed to
  ///           find an element with given index.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON(at index: Int) -> Observable<Any> {
    return self.map(mapJSONArray(index, Any.self))
  }

  /// Converts each element to a JSON array and projects each value for given index to a new
  /// observable sequence.
  ///
  /// - parameter index: An index for finding value from each JSON array.
  /// - parameter type: A type reference to cast result.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON array or failed to
  ///           find an element with given index.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON<T>(at index: Int, _ type: T.Type) -> Observable<T> {
    return self.map(mapJSONArray(index, T.self))
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
    return self.map(mapJSONDictionary(key, E.self))
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
    return self.map(mapJSONDictionary(key, type))
  }

  /// Converts each element to a JSON array and projects each value for given index to a new
  /// observable sequence.
  ///
  /// - parameter index: An index for finding value from each JSON array.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON array or failed to
  ///           find an element with given index.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON(at index: Int) -> PrimitiveSequence<Trait, Any> {
    return self.map(mapJSONArray(index, Any.self))
  }

  /// Converts each element to a JSON array and projects each value for given index to a new
  /// observable sequence.
  ///
  /// - parameter index: An index for finding value from each JSON array.
  /// - parameter type: A type reference to cast result.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON array or failed to
  ///           find an element with given index.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON<T>(at index: Int, _ type: T.Type) -> PrimitiveSequence<Trait, T> {
    return self.map(mapJSONArray(index, T.self))
  }
}


// MARK: - Functions

private func mapJSONDictionary<T>(_ key: String, _ type: T.Type) -> (_ original: Any) throws -> T {
  return { original -> T in
    guard let json = original as? [String: Any] else {
      throw RxJSONError.castingFailed(json: original, accessor: .key(key), type: [String: Any].self)
    }
    guard let rawValue = json[key] else {
      throw RxJSONError.valueNotFound(json: json, accessor: .key(key))
    }
    guard let value = rawValue as? T else {
      throw RxJSONError.castingFailed(json: original, accessor: .key(key), type: T.self)
    }
    return value
  }
}

private func mapJSONArray<T>(_ index: Int, _ type: T.Type) -> (_ original: Any) throws -> T {
  return { original -> T in
    guard let jsonArray = original as? [Any] else {
      throw RxJSONError.castingFailed(json: original, accessor: .index(index), type: [Any].self)
    }
    guard jsonArray.indices.contains(index) else {
      throw RxJSONError.valueNotFound(json: jsonArray, accessor: .index(index))
    }
    guard let value = jsonArray[index] as? T else {
      throw RxJSONError.castingFailed(json: original, accessor: .index(index), type: T.self)
    }
    return value
  }
}
