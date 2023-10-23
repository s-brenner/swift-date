import XCTest
@testable import SBDate

final class CalendarExtensionsTests: XCTestCase {
    
    func testDateComponents() {
        let dateFrom = DateInRegion()
        let components = 10.days
        let dateTo = dateFrom + components
        XCTAssertEqual(Calendar.gregorian.dateComponents([.day], from: dateFrom, to: dateTo), components)
    }
}
