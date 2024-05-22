import Foundation

/// - Author: Scott Brenner | SBDate
public protocol DateRepresentable: RegionRepresentable {
    
    /// Absolute representation of the date
    /// - Author: Scott Brenner | SBDate
    var date: Date { get }
    
    /// Initialize a new date with time components passed.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter components: date components
    /// - Parameter region: region in which the date is expressed. Ignore to use `.default`, `nil` to use `DateComponents` data.
    init?(components: DateComponents, region: Region?)
    
    /// Initialize a new date with given components.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter year: Year.
    /// - Parameter month: Month.
    /// - Parameter day: Day.
    /// - Parameter hour: Hour. Defaults to 0.
    /// - Parameter minute: Minute. Defaults to 0.
    /// - Parameter second: Second. Defaults to 0.
    /// - Parameter nanosecond: Nanosecond. Defaults to 0.
    /// - Parameter region: Region. Defaults to `.default`.
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, region: Region)
    
    /// Initialize a new date with given components.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter year: Year.
    /// - Parameter dayOfYear: Day of the year. Must be between 1 and 365 for non-leap years and 1 and 366 for leap years.
    /// - Parameter hour: Hour. Defaults to 0.
    /// - Parameter minute: Minute. Defaults to 0.
    /// - Parameter second: Second. Defaults to 0.
    /// - Parameter nanosecond: Nanosecond. Defaults to 0.
    /// - Parameter region: Region. Defaults to `defaultRegion`.
    init?(year: Int, dayOfYear: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, region: Region)
    
    /// A date value representing a date in the distant past.
    ///
    /// The distant past is in terms of centuries.
    /// - Author: Scott Brenner | SBDate
    static func distantPast() -> Self
    
    /// A date value representing a date in the distant future.
    ///
    /// The distant future is in terms of centuries.
    /// - Author: Scott Brenner | SBDate
    static func distantFuture() -> Self
}

extension DateRepresentable {
    
    // MARK: - Date components
    
    /// The components of the date relative to its region.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter components: The calendar components to include.
    public func dateComponents(
        _ components: Set<Calendar.Component> = [
            .era, .year, .month, .day, .hour, .minute, .second, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear, .nanosecond, .calendar, .timeZone
        ]
    ) -> DateComponents {
        region.calendar.dateComponents(components, from: date)
    }
    
    /// An era.
    /// - Author: Scott Brenner | SBDate
    public var era: Int { dateComponents([.era]).era! }
    
    /// A year.
    /// - Author: Scott Brenner | SBDate
    public var year: Int { dateComponents([.year]).year! }
    
    /// Returns `true` if receiver represents a leap year.
    /// - Author: Scott Brenner | SBDate
    public var isLeapYear: Bool { try! dateComponents().isLeapYear() }
    
    /// The ISO 8601 week-numbering year.
    /// - Author: Scott Brenner | SBDate
    public var yearForWeekOfYear: Int { dateComponents([.yearForWeekOfYear]).yearForWeekOfYear! }
    
    /// A month.
    /// - Author: Scott Brenner | SBDate
    public var month: Int { dateComponents([.month]).month! }
    
    /// Set to true if receiver represents a leap month.
    /// - Author: Scott Brenner | SBDate
    public var isLeapMonth: Bool { dateComponents().isLeapMonth! }
    
    /// A week of the month.
    /// - Author: Scott Brenner | SBDate
    public var weekOfMonth: Int { dateComponents([.weekOfMonth]).weekOfMonth! }
    
    /// A week of the year.
    /// - Author: Scott Brenner | SBDate
    public var weekOfYear: Int { dateComponents([.weekOfYear]).weekOfYear! }
    
    /// A weekday.
    /// - Author: Scott Brenner | SBDate
    public var weekday: Int { dateComponents([.weekday]).weekday! }
    
    /// A weekday ordinal.
    /// - Author: Scott Brenner | SBDate
    public var weekdayOrdinal: Int { dateComponents([.weekdayOrdinal]).weekdayOrdinal! }
    
    /// A day.
    /// - Author: Scott Brenner | SBDate
    public var day: Int { dateComponents([.day]).day! }
    
    /// A day of the year.
    /// - Author: Scott Brenner | SBDate
    public var dayOfYear: Int { calendar.ordinality(of: .day, in: .year, for: date)! }
    
    /// The number of day in ordinal style format for the receiver in current locale.
    /// For example, in the en_US locale, the number 3 is represented as 3rd; in the fr_FR locale, the number 3 is represented as 3e.
    /// - Author: Scott Brenner | SBDate
    public var ordinalDay: String {
        NumberFormatter.shared(numberStyle: .ordinal, locale: region.locale).string(from: day)!
    }
    
    /// An hour.
    /// - Author: Scott Brenner | SBDate
    public var hour: Int { dateComponents([.hour]).hour! }
    
    /// The nearest hour.
    /// - Author: Scott Brenner | SBDate
    public var nearestHour: Int {
        let minutes = TimeInterval(date.minute >= 30 ? 60 - date.minute : -date.minute) * 60
        let newDate = date.addingTimeInterval(minutes)
        return newDate.in(region: region).hour
    }
    
    /// A minute.
    /// - Author: Scott Brenner | SBDate
    public var minute: Int { dateComponents([.minute]).minute! }
    
    /// A second.
    /// - Author: Scott Brenner | SBDate
    public var second: Int { dateComponents([.second]).second! }
    
    /// A nanosecond.
    /// - Author: Scott Brenner | SBDate
    public var nanosecond: Int { dateComponents([.nanosecond]).nanosecond! }
    
    /// The current daylight saving time offset.
    /// - Author: Scott Brenner | SBDate
    public var DSTOffset: TimeInterval { region.timeZone.daylightSavingTimeOffset(for: date) }
    
    // MARK: - Component names
    
    /// Returns the era name in a given style.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter style: The style in which the name must be formatted.
    /// - Returns: The name of the era.
    public func eraName(_ style: SymbolFormatStyle) -> String {
        let formatter = sharedDateFormatter
        let index = era
        switch style {
        case .default,
                .defaultStandalone: return formatter.longEraSymbols[index]
        case .short,
                .standaloneShort,
                .veryShort,
                .standaloneVeryShort: return formatter.eraSymbols[index]
        }
    }

    /// Returns the month name in a given style.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter style: The style in which the name must be formatted.
    /// - Returns: The name of the month.
    public func monthName(_ style: SymbolFormatStyle) -> String {
        let formatter = sharedDateFormatter
        let index = month - 1
        switch style {
        case .default: return formatter.monthSymbols[index]
        case .defaultStandalone: return formatter.standaloneMonthSymbols[index]
        case .short: return formatter.shortMonthSymbols[index]
        case .standaloneShort: return formatter.shortStandaloneMonthSymbols[index]
        case .veryShort: return formatter.veryShortMonthSymbols[index]
        case .standaloneVeryShort: return formatter.veryShortStandaloneMonthSymbols[index]
        }
    }
    
    /// Returns the weekday name in a given style.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter style: The style in which the name must be formatted.
    /// - Returns: The name of the weekday.
    public func weekdayName(_ style: SymbolFormatStyle) -> String {
        let formatter = sharedDateFormatter
        let index = weekday - 1
        switch style {
        case .default: return formatter.weekdaySymbols[index]
        case .defaultStandalone: return formatter.standaloneWeekdaySymbols[index]
        case .short: return formatter.shortWeekdaySymbols[index]
        case .standaloneShort: return formatter.shortStandaloneWeekdaySymbols[index]
        case .veryShort: return formatter.veryShortWeekdaySymbols[index]
        case .standaloneVeryShort: return formatter.veryShortStandaloneWeekdaySymbols[index]
        }
    }
    
    /// Returns `true` if the receiver is in today.
    /// - Author: Scott Brenner | SBDate
    public var isToday: Bool { calendar.isDateInToday(date) }

    /// Returns `true` if the receiver is in yesterday.
    /// - Author: Scott Brenner | SBDate
    public var isYesterday: Bool { calendar.isDateInYesterday(date) }

    /// Returns `true` if the receiver is in tomorrow.
    /// - Author: Scott Brenner | SBDate
    public var isTomorrow: Bool { calendar.isDateInTomorrow(date) }

    /// Returns `true` if the receiver is in weekend.
    /// - Author: Scott Brenner | SBDate
    public var isInWeekend: Bool { calendar.isDateInWeekend(date) }
    
    /// Returns `true` if the receiver is in future.
    /// - Author: Scott Brenner | SBDate
    public func isInFuture(relativeTo otherDate: Date = Date()) -> Bool { date > otherDate }
    
    /// Returns `true` if the receiver is in past.
    /// - Author: Scott Brenner | SBDate
    public func isInPast(relativeTo otherDate: Date = Date()) -> Bool { date < otherDate }
    
    // MARK: - Conversions
    
    /// Convert date to another region.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter region: Destination region in which the date must be represented.
    /// - Returns: `DateInRegion` instance.
    public func `in`(region: Region) -> DateInRegion {
        DateInRegion(date, region: region)
    }
    
    /// Express given absolute date in the context of the default region.
    /// - Author: Scott Brenner | SBDate
    /// - Returns: `DateInRegion` instance.
    public func inDefaultRegion() -> DateInRegion {
        self.in(region: .default)
    }
    
    /// - Author: Scott Brenner | SBDate
    public func toNearest(_ components: DateComponents, rounding rule: FloatingPointRoundingRule) -> DateInRegion {
        let precision = Double((components.in(.second) ?? 1))
        let seconds = (date.timeIntervalSinceReferenceDate / precision).rounded(rule) *  precision
        return .init(Date(timeIntervalSinceReferenceDate: seconds), region: region)
    }
    
    // MARK: - Formatting
    
    /// - Author: Scott Brenner | SBDate
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public func formatted(_ style: Date.DateRepresentableFormatStyle) -> String {
        style.format(self)
    }
    
    /// - Author: Scott Brenner | SBDate
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public func formatted(format: String, region: Region? = nil) -> String {
        formatted(.format(format).region(region ?? self.region))
    }
    
    // MARK: - Extract Time Components
    
    /// Returns the difference between self and an ending date.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter components: Which components to compare.
    /// - Parameter end: The ending date.
    /// - Returns: The result of calculating the difference from self to end.
    public func components(_ components: Set<Calendar.Component>, to end: some DateRepresentable) -> [Calendar.Component: Int] {
        region
            .calendar
            .dateComponents(components, from: date, to: end.date)
            .componentDictionary
    }
    
    /// Returns the difference between self and an ending date.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter component: Which component to compare.
    /// - Parameter end: The ending date.
    /// - Returns: The result of calculating the difference from self to end.
    public func component(_ component: Calendar.Component, to end: some DateRepresentable) -> Int {
        components([component], to: end)[component]!
    }
    
    /// The span of time between the receiver and a specific start date.
    ///
    /// DateInterval represents a closed date interval in the form of [startDate, endDate]. It is possible for the start and end dates to be the same with a duration of 0. DateInterval does not support reverse intervals i.e. intervals where the duration is less than 0 and the end date occurs earlier in time than the start date.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter start: The start date.
    public func dateIntervalSince(_ start: some DateRepresentable) -> DateInterval {
        DateInterval(start: start, end: date)
    }
    
    /// The span of time between the receiver and a specific end date.
    ///
    /// DateInterval represents a closed date interval in the form of [startDate, endDate]. It is possible for the start and end dates to be the same with a duration of 0. DateInterval does not support reverse intervals i.e. intervals where the duration is less than 0 and the end date occurs earlier in time than the start date.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter end: The end date.
    public func dateIntervalBefore(_ end: some DateRepresentable) -> DateInterval {
        DateInterval(start: date, end: end)
    }
    
    /// - Author: Scott Brenner | SBDate
    public var dateIntervalSinceNow: DateInterval {
        dateIntervalSince(Date())
    }
    
    /// - Author: Scott Brenner | SBDate
    public var dateIntervalBeforeNow: DateInterval {
        dateIntervalBefore(Date())
    }
    
    /// - Author: Scott Brenner | SBDate
    public func dateComponentsSince(_ start: some DateRepresentable) -> DateComponents {
        guard start.date <= date
        else { return -DateInterval(start: date, end: start).dateComponents }
        return DateInterval(start: start, end: date).dateComponents
    }
    
    /// - Author: Scott Brenner | SBDate
    public func dateComponentsBefore(_ end: some DateRepresentable) -> DateComponents {
        guard date <= end.date
        else { return -DateInterval(start: end, end: date).dateComponents }
        return DateInterval(start: date, end: end).dateComponents
    }
    
    /// - Author: Scott Brenner | SBDate
    public var dateComponentsSinceNow: DateComponents {
        dateComponentsSince(Date())
    }
    
    /// - Author: Scott Brenner | SBDate
    public var dateComponentsBeforeNow: DateComponents {
        dateComponentsBefore(Date())
    }
}

/// - Author: Scott Brenner | SBDate
public func < (lhs: some DateRepresentable, rhs: some DateRepresentable) -> Bool {
    lhs.date < rhs.date
}

/// - Author: Scott Brenner | SBDate
public func < (lhs: DateInterval, rhs: DateComponents) -> Bool {
    lhs.dateComponents < rhs
}

/// - Author: Scott Brenner | SBDate
public func == (lhs: DateInterval, rhs: DateComponents) -> Bool {
    lhs.dateComponents.duration == rhs.duration
}

/// - Author: Scott Brenner | SBDate
public func - (lhs: some DateRepresentable, rhs: some DateRepresentable) -> DateInterval {
    DateInterval(start: rhs.date, end: lhs.date)
}

/// - Author: Scott Brenner | SBDate
public func + (lhs: some DateRepresentable, rhs: DateComponents) -> DateInRegion {
    let nextDate = lhs.calendar.date(byAdding: rhs, to: lhs.date)
    return DateInRegion(nextDate!, region: lhs.region)
}

/// - Author: Scott Brenner | SBDate
public func - (lhs: some DateRepresentable, rhs: DateComponents) -> DateInRegion {
    lhs + (-rhs)
}
