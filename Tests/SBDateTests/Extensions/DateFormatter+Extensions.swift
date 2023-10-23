import XCTest
@testable import SBDate

final class DateFormatterExtensionsTests: XCTestCase {
     
    func testRegion() {
        let formatter = DateFormatter.shared(dateFormat: "yyyy", region: .default)
        XCTAssertEqual(formatter.region, .default)
    }
}
