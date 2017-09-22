public enum Accessor {
  case key(String)
  case index(Int)
}

public enum RxJSONError: Error {
  case castingFailed(json: Any, accessor: Accessor, type: Any.Type)
  case valueNotFound(json: Any, accessor: Accessor)
}
