internal func mapJSONDictionary<T>(_ key: String, _ type: T.Type) -> (_ original: Any) throws -> T {
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

internal func mapJSONArray<T>(_ index: Int, _ type: T.Type) -> (_ original: Any) throws -> T {
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
