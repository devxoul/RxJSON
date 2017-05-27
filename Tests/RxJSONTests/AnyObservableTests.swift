import XCTest
import RxSwift
import RxBlocking
import RxJSON

class AnyObservableTests: XCTestCase {

  // MARK: mapJSON(key:)

  func testMapJSON_failure_invalidKey() {
    let json: [String: Any] = ["name": "devxoul"]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON("email")
        .toBlocking()
        .first()
    )
  }

  func testMapJSON_failure_invalidDictionary() {
    let json: [String] = ["Swift", "Python", "JavaScript"]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON("Swift")
        .toBlocking()
        .first()!
    )
  }

  func testMapJSON_success() {
    let json: [String: Any] = ["name": "devxoul"]
    let value = try! Observable<Any>.just(json)
      .mapJSON("name")
      .toBlocking()
      .first() as! String
    XCTAssertEqual(value, "devxoul")
  }


  // MARK: mapJSON(key:type:)

  func testMapJSONWithType_failure_failedCasting() {
    let json: [String: Any] = ["name": 123]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!
    )
  }

  func testMapJSONWithType_success() {
    let json: [String: Any] = ["name": "devxoul"]
    let value = try! Observable<Any>.just(json)
      .mapJSON("name", String.self)
      .toBlocking()
      .first()!
    XCTAssertEqual(value, "devxoul")
  }


  // MARK: Nested

  func testMapJSON_nested_success() {
    let json: [String: Any] = ["user": ["name": "devxoul"]]
    let value = try! Observable<Any>.just(json)
      .mapJSON("user")
      .mapJSON("name", String.self)
      .toBlocking()
      .first()!
    XCTAssertEqual(value, "devxoul")
  }
}
