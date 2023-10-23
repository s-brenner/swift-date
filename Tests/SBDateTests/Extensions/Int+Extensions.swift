import XCTest
@testable import SBDate

final class IntExtensionsTests: XCTestCase {
    
    func testNanoseconds() {
        XCTAssertEqual(10.nanoseconds, DateComponents(nanosecond: 10))
    }
    
    func testSeconds() {
        XCTAssertEqual(10.seconds, DateComponents(second: 10))
    }
    
    func testMinutes() {
        XCTAssertEqual(10.minutes, DateComponents(minute: 10))
    }
    
    func testHours() {
        XCTAssertEqual(10.hours, DateComponents(hour: 10))
    }
    
    func testDays() {
        XCTAssertEqual(10.days, DateComponents(day: 10))
    }
    
    func testWeeks() {
        XCTAssertEqual(10.weeks, DateComponents(weekOfYear: 10))
    }
    
    func testMonths() {
        XCTAssertEqual(10.months, DateComponents(month: 10))
    }
    
    func testYears() {
        XCTAssertEqual(10.years, DateComponents(year: 10))
    }
    
    func testQuarters() {
        XCTAssertEqual(10.quarters, DateComponents(quarter: 10))
    }
}
