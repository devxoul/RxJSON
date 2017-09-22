import XCTest
import RxSwift
import RxBlocking
import RxJSON

class ArrayTests: XCTestCase {

  // MARK: mapJSON(key:)

  func testMapJSONWithIndex_throws_whenJSONIsNotArray() {
    let json: [String: Any] = ["name": "devxoul"]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON(at: 0)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON(at: 0)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Maybe<Any>.just(json)
        .mapJSON(at: 0)
        .toBlocking()
        .first()!
    )
  }

  func testMapJSONWithIndex_throws_whenIndexNotExists() {
    let json: [Any] = ["Swift", "Python", "JavaScript"]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON(at: 3)
        .toBlocking()
        .first()
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON(at: 3)
        .toBlocking()
        .first()
    )
    XCTAssertThrowsError(
      try Maybe<Any>.just(json)
        .mapJSON(at: 3)
        .toBlocking()
        .first()
    )
  }

  func testMapJSONWithIndex_succeeds() {
    let json: [Any] = ["Swift", "Python", "JavaScript"]
    XCTAssertEqual(
      try Observable<Any>.just(json)
        .mapJSON(at: 1)
        .toBlocking()
        .first() as! String,
      "Python"
    )
    XCTAssertEqual(
      try Single<Any>.just(json)
        .mapJSON(at: 1)
        .toBlocking()
        .first() as! String,
      "Python"
    )
    XCTAssertEqual(
      try Maybe<Any>.just(json)
        .mapJSON(at: 1)
        .toBlocking()
        .first() as! String,
      "Python"
    )
  }


  // MARK: mapJSON(key:type:)

  func testMapJSONWithIndexAndType_throws_whenJSONIsNotArray() {
    let json: [String: Any] = ["name": 123]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON(at: 0, Int.self)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON(at: 0, Int.self)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Maybe<Any>.just(json)
        .mapJSON(at: 0, Int.self)
        .toBlocking()
        .first()!
    )
  }

  func testMapJSONWithIndexAndType_throws_whenIndexNotExists() {
    let json: [Any] = ["Swift", "Python", "JavaScript"]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON(at: 3, String.self)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON(at: 3, String.self)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Maybe<Any>.just(json)
        .mapJSON(at: 3, String.self)
        .toBlocking()
        .first()!
    )
  }

  func testMapJSONWithIndexAndType_throws_whenFailedToCast() {
    let json: [Any] = ["Swift", "Python", "JavaScript"]
    XCTAssertThrowsError(
      try Observable<Any>.just(json)
        .mapJSON(at: 2, Int.self)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Single<Any>.just(json)
        .mapJSON(at: 2, Int.self)
        .toBlocking()
        .first()!
    )
    XCTAssertThrowsError(
      try Maybe<Any>.just(json)
        .mapJSON(at: 2, Int.self)
        .toBlocking()
        .first()!
    )
  }

  func testMapJSONWithIndexAndType_succeeds() {
    let json: [Any] = ["Swift", "Python", "JavaScript"]
    XCTAssertEqual(
      try Observable<Any>.just(json)
        .mapJSON(at: 0, String.self)
        .toBlocking()
        .first()!,
      "Swift"
    )
    XCTAssertEqual(
      try Single<Any>.just(json)
        .mapJSON(at: 0, String.self)
        .toBlocking()
        .first()!,
      "Swift"
    )
    XCTAssertEqual(
      try Maybe<Any>.just(json)
        .mapJSON(at: 0, String.self)
        .toBlocking()
        .first()!,
      "Swift"
    )
  }


  // MARK: Nested

  func testMapJSON_nested_succeeds() {
    let json: [Any] = [
      ["name": "devxoul"],
      ["name": "helloworld"],
    ]
    XCTAssertEqual(
      try Observable<Any>.just(json)
        .mapJSON(at: 0)
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!,
      "devxoul"
    )
    XCTAssertEqual(
      try Single<Any>.just(json)
        .mapJSON(at: 0)
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!,
      "devxoul"
    )
    XCTAssertEqual(
      try Maybe<Any>.just(json)
        .mapJSON(at: 0)
        .mapJSON("name", String.self)
        .toBlocking()
        .first()!,
      "devxoul"
    )
  }
}
