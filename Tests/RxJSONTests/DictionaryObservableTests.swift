import XCTest
import RxSwift
import RxBlocking
import RxJSON

class DictionaryObservableTests: XCTestCase {

  // MARK: .mapJSON(key:)

  func testMapJSON_failure_notDictionary() {
    let json: [String: Any] = ["name": "devxoul"]
    XCTAssertThrowsError(
      try Observable.just(json)
        .mapJSON("name")
        .toBlocking()
        .first()!
    )
  }

  func testMapJSON_failure_invalidKey() {
    let json: [String: Any] = ["user": ["name": "devxoul"]]
    XCTAssertThrowsError(
      try Observable.just(json)
        .mapJSON("author")
        .toBlocking()
        .first()!
    )
  }

  func testMapJSON_success() {
    let json: [String: Any] = ["user": ["name": "devxoul"]]
    let value = try! Observable.just(json)
      .mapJSON("user")
      .toBlocking()
      .first()!
    XCTAssertEqual(value.count, 1)
    XCTAssertEqual(value["name"] as? String, "devxoul")
  }

  func testMapJSONWithType_success() {
    let json: [String: Any] = ["user": ["name": "devxoul"]]
    let value = try! Observable.just(json)
      .mapJSON("user")
      .mapJSON("name", String.self)
      .toBlocking()
      .first()!
    XCTAssertEqual(value, "devxoul")
  }
}
