import XCTest
import RxSwift
import RxBlocking
import RxJSON

class DictionaryTests: XCTestCase {

  // MARK: mapJSON(key:)

  func testMapJSONWithKey_throws_whenJSONIsNotDictionary() {
    let json: [String] = ["Swift", "Python", "JavaScript"]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON("Swift")
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON("Swift")
        .toBlocking()
        .first()!
    )
  }

  func testMapJSONWithKey_throws_whenKeyNotExists() {
    let json: [String: Any] = ["name": "devxoul"]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON("email")
        .toBlocking()
        .first()
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON("email")
        .toBlocking()
        .first()
    )
  }

  func testMapJSONWithKey_succeeds() {
    let json: [String: Any] = ["name": "devxoul"]
    XCTAssertEqual(
      try Observable<Any>.just(json)
        .mapJSON("name")
        .toBlocking()
        .first() as! String,
      "devxoul"
    )
    XCTAssertEqual(
      try Single<Any>.just(json)
        .mapJSON("name")
        .toBlocking()
        .first() as! String,
      "devxoul"
    )
  }


  // MARK: mapJSON(key:type:)

  func testMapJSONWithKeyAndType_throws_whenJSONIsNotDictionary() {
    let json: [String] = ["Swift", "Python", "JavaScript"]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON("Swift", String.self)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON("Swift", String.self)
        .toBlocking()
        .first()!
    )
  }

  func testMapJSONWithKeyAndType_throws_whenKeyNotExists() {
    let json: [String: Any] = ["name": 123]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON("age", String.self)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON("age", String.self)
        .toBlocking()
        .first()!
    )
  }

  func testMapJSONWithKeyAndType_throws_whenFailedToCast() {
    let json: [String: Any] = ["name": 123]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!
    )
  }

  func testMapJSONWithKeyAndType_succeeds() {
    let json: [String: Any] = ["name": "devxoul"]
    XCTAssertEqual(
      try Observable<Any>.just(json)
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!,
      "devxoul"
    )
    XCTAssertEqual(
      try Single<Any>.just(json)
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!,
      "devxoul"
    )
  }


  // MARK: Nested

  func testMapJSON_nested_succeeds() {
    let json: [String: Any] = ["user": ["name": "devxoul"]]
    XCTAssertEqual(
      try Observable<Any>.just(json)
        .mapJSON("user")
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!,
      "devxoul"
    )
    XCTAssertEqual(
      try Single<Any>.just(json)
        .mapJSON("user")
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!,
      "devxoul"
    )
  }
}
