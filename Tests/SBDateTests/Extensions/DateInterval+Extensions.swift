import XCTest
@testable import SBDate

final class DateIntervalExtensionsTests: XCTestCase {
    
    private let now = Date().inDefaultRegion()
    
    private lazy var interval = DateInterval(start: now, duration: 3600)
    
    func testRegion() {
        XCTAssertEqual(interval.region, now.region)
    }
    
    func testInit() {
        XCTAssertEqual(interval, DateInterval(start: now, duration: 1.hours))
    }
    
    func testDateComponents() {
        XCTAssertEqual(interval.dateComponents.hour, 1.hours.hour)
    }
}
