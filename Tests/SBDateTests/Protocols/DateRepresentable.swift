import XCTest
@testable import SBDate

final class DateRepresentableTests: XCTestCase {
    
    let date = DateInRegion(year: 2018, month: 9, day: 15, hour: 15, minute: 30, second: 12)
    
    var now: Date!
    
    override func setUp() {
        super.setUp()
        now = Date()
    }
    
    override func tearDown() {
        now = nil
        super.tearDown()
    }
    
    func testYear() {
        XCTAssertEqual(date.year, 2018)
    }
    
    func testIsLeapYear() {
        XCTAssertFalse(date.isLeapYear)
    }
    
    func testYearForWeekOfYear() {
        XCTAssertEqual(date.yearForWeekOfYear, 2018)
    }
    
    func testMonth() {
        XCTAssertEqual(date.month, 9)
    }
    
    func testIsLeapMonth() {
        XCTAssertFalse(date.isLeapMonth)
    }
    
    func testWeekOfMonth() {
        XCTAssertEqual(date.weekOfMonth, 3)
    }
    
    func testWeekOfYear() {
        XCTAssertEqual(date.weekOfYear, 37)
    }
    
    func testWeekday() {
        XCTAssertEqual(date.weekday, 7)
    }
    
    func testWeekdayOrdinal() {
        XCTAssertEqual(date.weekdayOrdinal, 3)
    }
    
    func testDay() {
        XCTAssertEqual(date.day, 15)
    }
    
    func testDayOfYear() {
        XCTAssertEqual(date.dayOfYear, 258)
    }
    
    func testOrdinalDay() {
        XCTAssertEqual(date.ordinalDay, "15th")
    }
    
    func testHour() {
        XCTAssertEqual(date.hour, 15)
    }
    
    func testNearestHour() {
        XCTAssertEqual(date.nearestHour, 16)
        XCTAssertEqual(DateInRegion(year: 2019, month: 10, day: 12, hour: 10, minute: 29).nearestHour, 10)
    }
    
    func testMinute() {
        XCTAssertEqual(date.minute, 30)
    }
    
    func testSecond() {
        XCTAssertEqual(date.second, 12)
    }
    
    func testNanosecond() {
        XCTAssertEqual(date.nanosecond, 0)
    }
    
    func testDSTOffset() {
        XCTAssertEqual(date.DSTOffset, 0)
    }
    
    func testEraName() {
        XCTAssertEqual(date.eraName(.default), "Anno Domini")
        XCTAssertEqual(date.eraName(.short), "AD")
    }
    
    func testMonthName() {
        XCTAssertEqual(date.monthName(.default), "September")
        XCTAssertEqual(date.monthName(.defaultStandalone), "September")
        XCTAssertEqual(date.monthName(.short), "Sep")
        XCTAssertEqual(date.monthName(.standaloneShort), "Sep")
        XCTAssertEqual(date.monthName(.veryShort), "S")
        XCTAssertEqual(date.monthName(.standaloneVeryShort), "S")
    }
    
    func testWeekdayName() {
        XCTAssertEqual(date.weekdayName(.default), "Saturday")
        XCTAssertEqual(date.weekdayName(.defaultStandalone), "Saturday")
        XCTAssertEqual(date.weekdayName(.short), "Sat")
        XCTAssertEqual(date.weekdayName(.standaloneShort), "Sat")
        XCTAssertEqual(date.weekdayName(.veryShort), "S")
        XCTAssertEqual(date.weekdayName(.standaloneVeryShort), "S")
    }
    
    func testIsToday() {
        XCTAssertTrue(now.isToday)
        XCTAssertFalse(now.addingTimeInterval(-24 * 3600).isToday)
    }
    
    func testIsYesterday() {
        XCTAssertTrue(now.addingTimeInterval(-24 * 3600).isYesterday)
        XCTAssertFalse(now.isYesterday)
    }
    
    func testIsTomorrow() {
        XCTAssertTrue(now.addingTimeInterval(24 * 3600).isTomorrow)
        XCTAssertFalse(now.isTomorrow)
    }
    
    func testIsInWeekend() {
        XCTAssertFalse(DateInRegion(year: 2019, month: 6, day: 28).isInWeekend)
        XCTAssertTrue(DateInRegion(year: 2019, month: 6, day: 29).isInWeekend)
        XCTAssertTrue(DateInRegion(year: 2019, month: 6, day: 30).isInWeekend)
        XCTAssertFalse(DateInRegion(year: 2019, month: 7, day: 1).isInWeekend)
    }
    
    func testIsInPast() {
        XCTAssertTrue(now.isInPast())
    }
    
    func testIsInFuture() {
        XCTAssertFalse(now.isInFuture())
    }
    
    func testInRegion() {
        let region = TimeZone(identifier: "America/New_York")!.region
        let newDate = date.in(region: region)
        XCTAssertEqual(newDate.region, region)
        XCTAssertEqual(date.date, newDate.date)
    }
    
    func testInDefaultRegion() {
        let newDate = date.inDefaultRegion()
        XCTAssertEqual(newDate.region, .default)
        XCTAssertEqual(date.date, newDate.date)
    }
    
    func testToNearest() {
        
        let date = Date(year: 2019, month: 12, day: 12, hour: 3, minute: 30, second: 1)
        
        XCTAssertEqual(
            date.toNearest(15.minutes, rounding: .up).date,
            Date(year: 2019, month: 12, day: 12, hour: 3, minute: 45)
        )
        
        XCTAssertEqual(
            date.toNearest(15.minutes, rounding: .down).date,
            Date(year: 2019, month: 12, day: 12, hour: 3, minute: 30)
        )
    }
    
    func testFormatted() {
        let denver = TimeZone.americaDenver.region
        XCTAssertEqual(date.formatted(format: "hh"), "15")
        XCTAssertEqual(date.in(region: denver).formatted(format: "hh"), "09")
        XCTAssertEqual(date.formatted(format: "hh", region: denver), "09")
        XCTAssertEqual(date.in(region: denver).formatted(format: "hh", region: .default), "15")
        let format = Date.FormatStyle.dateTime
            .hour()
            .timeZone(.americaDenver)
            .locale(.englishUnitedKingdom)
        XCTAssertEqual(format.format(date.date), "09")
    }
    
    func testComponents() {
        let start = DateInRegion(year: 2018, month: 9, day: 14, hour: 15, region: TimeZone(identifier: "America/New_York")!.region)
        let end = DateInRegion(year: 2018, month: 9, day: 15, hour: 20, region: TimeZone(identifier: "America/New_York")!.region)
        XCTAssertEqual(start.components([.day, .hour], to: end), [.day : 1, .hour : 5])
        XCTAssertEqual(start.in(region: .UTC).components([.hour], to: end), [.hour : 29])
        XCTAssertEqual(start.component(.hour, to: end), 29)
        XCTAssertEqual(end.component(.hour, to: start), -29)
    }
    
    func testDateIntervalSince() {
        let start = DateInRegion(year: 2018, month: 9, day: 14, hour: 15)
        let end = DateInRegion(year: 2018, month: 9, day: 15, hour: 20)
        XCTAssertEqual(end.dateIntervalSince(start), DateInterval(start: start, end: end))
    }
    
    func testDateIntervalBefore() {
        let start = DateInRegion(year: 2018, month: 9, day: 14, hour: 15)
        let end = DateInRegion(year: 2018, month: 9, day: 15, hour: 20)
        XCTAssertEqual(start.dateIntervalBefore(end), DateInterval(start: start, end: end))
        XCTAssertEqual(start.dateIntervalBefore(end), end.dateIntervalSince(start))
    }
    
    func testDateComponentsSince() {
        let date = DateInRegion(year: 2100, month: 2, day: 14)
        XCTAssertTrue(Date().dateComponentsSince(date) < 0.minutes)
        XCTAssertTrue(date.dateComponentsSinceNow > 7.days)
    }

    func testDateComponentsBefore() {
        let date = DateInRegion(year: 2020, month: 2, day: 14)
        XCTAssertTrue(Date().dateComponentsBefore(date) < 0.minutes)
        XCTAssertTrue(date.dateComponentsBeforeNow > 7.days)
    }
    
    func testMath() {
        let start = DateInRegion(year: 2018, month: 9, day: 15, hour: 19)
        let end = Date(year: 2018, month: 9, day: 15, hour: 20)
        
        XCTAssertTrue(start < end)
        XCTAssertTrue(end > start)
        XCTAssertTrue(start <= end)
        XCTAssertTrue(end >= start)
        XCTAssertFalse(start == end)
        
        XCTAssertTrue(end - start < 1.hours + 1.seconds)
        XCTAssertTrue(end - start > 59.minutes + 59.seconds)
        XCTAssertTrue(end - start <= 1.hours)
        XCTAssertTrue(end - start >= 1.hours)
        XCTAssertTrue(end - start == 1.hours)
        XCTAssertTrue(59.minutes + 59.seconds < end - start)
        XCTAssertTrue(1.hours + 1.seconds > end - start)
        XCTAssertTrue(1.hours <= end - start)
        XCTAssertTrue(1.hours >= end - start)
        XCTAssertTrue(1.hours == end - start)

        XCTAssertEqual(end - start, DateInterval(start: start, end: end))
        XCTAssertTrue(start + DateComponents(hour: 1) == end)
        XCTAssertEqual(end - DateComponents(hour: 1), start)
    }
}
