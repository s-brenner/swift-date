import XCTest
@testable import SBDate

final class DateExtensionsTests: XCTestCase {
    
    func testInit() {
        XCTAssertEqual(
            Date(components: DateComponents()),
            DateInRegion(components: DateComponents())?.date
        )
        XCTAssertEqual(Date(year: 2019, month: 1, day: 1), DateInRegion(year: 2019, month: 1, day: 1).date)
        XCTAssertEqual(Date(year: 2019, dayOfYear: 100), DateInRegion(year: 2019, dayOfYear: 100)?.date)
    }
    
    func testDistantPast() {
        XCTAssertEqual(Date.distantPast(), .distantPast)
    }
    
    func testDistantFuture() {
        XCTAssertEqual(Date.distantFuture(), .distantFuture)
    }
}
