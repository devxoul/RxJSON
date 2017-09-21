import RxSwift

public extension PrimitiveSequenceType where TraitType == MaybeTrait {
  /// Converts each element to a JSON dictionary and projects each value for given key to a new
  /// observable sequence.
  ///
  /// - parameter key: A key for finding value from each JSON dictionary.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON dictionary or failed to
  ///           find an element with given key.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON(_ key: String) -> PrimitiveSequence<TraitType, ElementType> {
    return self.map(mapJSONDictionary(key, ElementType.self))
  }

  /// Converts each element to a JSON dictionary and projects each value for given key to a new
  /// observable sequence.
  ///
  /// - parameter key: A key for finding value from each JSON dictionary.
  /// - parameter type: A type reference to cast result.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON dictionary or failed to
  ///           cast an element with given key to a given type.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON<T>(_ key: String, _ type: T.Type) -> PrimitiveSequence<TraitType, T> {
    return self.map(mapJSONDictionary(key, type))
  }

  /// Converts each element to a JSON array and projects each value for given index to a new
  /// observable sequence.
  ///
  /// - parameter index: An index for finding value from each JSON array.
  /// - throws: `RxJSONError` when failed to cast each element to a JSON array or failed to
  ///           find an element with given index.
  /// - returns: An observable sequence whose elements are the value of each element of source.
  public func mapJSON(at index: Int) -> PrimitiveSequence<TraitType, Any> {
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
  public func mapJSON<T>(at index: Int, _ type: T.Type) -> PrimitiveSequence<TraitType, T> {
    return self.map(mapJSONArray(index, T.self))
  }
}


