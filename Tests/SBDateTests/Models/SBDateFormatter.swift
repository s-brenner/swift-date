import XCTest
@testable import SBDate

final class SBDateFormatterTests: XCTestCase {

    func testDayOfWeekEnum() {
        XCTAssertEqual(SBDateFormatter.DayOfWeek(rawValue: 0), .sunday)
        XCTAssertEqual(SBDateFormatter.DayOfWeek(rawValue: 1), .monday)
        XCTAssertEqual(SBDateFormatter.DayOfWeek(rawValue: 2), .tuesday)
        XCTAssertEqual(SBDateFormatter.DayOfWeek(rawValue: 3), .wednesday)
        XCTAssertEqual(SBDateFormatter.DayOfWeek(rawValue: 4), .thursday)
        XCTAssertEqual(SBDateFormatter.DayOfWeek(rawValue: 5), .friday)
        XCTAssertEqual(SBDateFormatter.DayOfWeek(rawValue: 6), .saturday)
        
        XCTAssertEqual(SBDateFormatter.DayOfWeek.sunday.description, "Sun")
        XCTAssertEqual(SBDateFormatter.DayOfWeek.monday.description, "Mon")
        XCTAssertEqual(SBDateFormatter.DayOfWeek.tuesday.description, "Tue")
        XCTAssertEqual(SBDateFormatter.DayOfWeek.wednesday.description, "Wed")
        XCTAssertEqual(SBDateFormatter.DayOfWeek.thursday.description, "Thu")
        XCTAssertEqual(SBDateFormatter.DayOfWeek.friday.description, "Fri")
        XCTAssertEqual(SBDateFormatter.DayOfWeek.saturday.description, "Sat")
    }
    
    func testMonthEnum() {
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 1), .january)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 2), .february)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 3), .march)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 4), .april)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 5), .may)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 6), .june)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 7), .july)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 8), .august)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 9), .september)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 10), .october)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 11), .november)
        XCTAssertEqual(SBDateFormatter.Month(rawValue: 12), .december)
        
        XCTAssertEqual(SBDateFormatter.Month.january.description, "Jan")
        XCTAssertEqual(SBDateFormatter.Month.february.description, "Feb")
        XCTAssertEqual(SBDateFormatter.Month.march.description, "Mar")
        XCTAssertEqual(SBDateFormatter.Month.april.description, "Apr")
        XCTAssertEqual(SBDateFormatter.Month.may.description, "May")
        XCTAssertEqual(SBDateFormatter.Month.june.description, "Jun")
        XCTAssertEqual(SBDateFormatter.Month.july.description, "Jul")
        XCTAssertEqual(SBDateFormatter.Month.august.description, "Aug")
        XCTAssertEqual(SBDateFormatter.Month.september.description, "Sep")
        XCTAssertEqual(SBDateFormatter.Month.october.description, "Oct")
        XCTAssertEqual(SBDateFormatter.Month.november.description, "Nov")
        XCTAssertEqual(SBDateFormatter.Month.december.description, "Dec")
    }
    
    func testInit() {
        XCTAssertNotNil(SBDateFormatter())
    }
    
    func testDescription() {
        XCTAssertEqual(SBDateFormatter.description(forYear: 2019, month: 6, day: 29), "Sat 29 Jun")
    }
    
    func testDayOfWeek() {
        let year = Int.random(in: 1900...2200)
        let message = "Day of week test failed for year \(year)."
        let day0 = SBDateFormatter.dayOfWeek(year: year, month: 4, day: 4)
        let day1 = SBDateFormatter.dayOfWeek(year: year, month: 6, day: 6)
        let day2 = SBDateFormatter.dayOfWeek(year: year, month: 8, day: 8)
        let day3 = SBDateFormatter.dayOfWeek(year: year, month: 10, day: 10)
        let day4 = SBDateFormatter.dayOfWeek(year: year, month: 12, day: 12)
        let day5 = SBDateFormatter.dayOfWeek(year: year, month: 9, day: 5)
        let day6 = SBDateFormatter.dayOfWeek(year: year, month: 5, day: 9)
        let day7 = SBDateFormatter.dayOfWeek(year: year, month: 7, day: 11)
        let day8 = SBDateFormatter.dayOfWeek(year: year, month: 11, day: 7)
        XCTAssertEqual(day0, day1, message)
        XCTAssertEqual(day1, day2, message)
        XCTAssertEqual(day2, day3, message)
        XCTAssertEqual(day3, day4, message)
        XCTAssertEqual(day4, day5, message)
        XCTAssertEqual(day5, day6, message)
        XCTAssertEqual(day6, day7, message)
        XCTAssertEqual(day7, day8, message)
        
        XCTAssertEqual(SBDateFormatter.dayOfWeek(year: 2019, month: 2, day: 2), .saturday)
    }
    
    func testNumberOfDays() {
        
        // Test normal year
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 1), 31)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 2), 28)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 3), 31)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 4), 30)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 5), 31)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 6), 30)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 7), 31)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 8), 31)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 9), 30)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 10), 31)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 11), 30)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 12), 31)
        
        // Test leap year
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2020, month: 2), 29)
        
        // Test bad input
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: -2019, month: 2), 0)
        XCTAssertEqual(SBDateFormatter.numberOfDays(inYear: 2019, month: 13), 0)
    }
}
