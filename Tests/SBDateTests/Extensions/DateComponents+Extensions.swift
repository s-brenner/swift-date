import XCTest
@testable import SBDate

final class DateComponentsExtensionsTests: XCTestCase {
    
    func testAgo() {
        let interval = 10.days
        XCTAssertEqual(interval.ago.day, (Date() - interval).day)
    }
    
    func testFromNow() {
        let interval = 10.days
        XCTAssertEqual(interval.fromNow.day, (Date() + interval).day)
    }
    
    func testBefore() {
        let interval = 10.days
        let now = Date()
        XCTAssertEqual(interval.before(now), (now - interval).date)
    }
    
    func testFrom() {
        let interval = 10.days
        let now = Date()
        XCTAssertEqual(interval.from(now), (now + interval).date)
    }
    
    func testIn() {
        let components = DateComponents(hour: 1, minute: -1)
        XCTAssertEqual(components.in(.minute), 59)
        XCTAssertEqual(components.in([.minute, .second]), [.minute : 59, .second : 0])
    }
    
    func testComponentDictionary() {
        XCTAssertEqual(DateComponents().componentDictionary, [:])
        XCTAssertEqual(
            DateComponents(year: 2019, month: 6, day: 29).componentDictionary,
            [.year : 2019, .month : 6, .day: 29]
        )
    }
    
    func testIsLeapYear() {
        // Test errors
        XCTAssertThrowsError(try DateComponents().isLeapYear())
        XCTAssertThrowsError(try DateComponents(year: -1).isLeapYear())
        
        // Test known leap years from 2000 to 2096
        (0...24).forEach() {
            let year = 2000 + $0 * 4
            XCTAssertTrue(try! DateComponents(year: year).isLeapYear(), "\(year) is not a leap year.")
        }
        
        // Test the beginning of centuries
        XCTAssertFalse(try! DateComponents(year: 2100).isLeapYear())
        XCTAssertFalse(try! DateComponents(year: 2200).isLeapYear())
        XCTAssertFalse(try! DateComponents(year: 2300).isLeapYear())
        XCTAssertTrue(try! DateComponents(year: 2400).isLeapYear())
        
        // Test known non-leap years
        XCTAssertFalse(try! DateComponents(year: 2021).isLeapYear())
        XCTAssertFalse(try! DateComponents(year: 2022).isLeapYear())
        XCTAssertFalse(try! DateComponents(year: 2023).isLeapYear())
    }
    
    func testNegation() {
        let dateComponents1 = DateComponents(year: 2019, month: 6)
        let dateComponents2 = DateComponents(year: -2019, month: -6)
        XCTAssertEqual(-dateComponents1, dateComponents2)
    }
    
    func testAddition() {
        XCTAssertEqual(DateComponents(hour: 4) + DateComponents(minute: 15), DateComponents(hour: 4, minute: 15))
    }
    
    func testSubtraction() {
        XCTAssertEqual(DateComponents(hour: 4) - DateComponents(minute: 15), DateComponents(hour: 4, minute: -15))
    }
}
