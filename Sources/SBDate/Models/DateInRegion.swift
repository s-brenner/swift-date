import Foundation

/// - Author: Scott Brenner | SBDate
public struct DateInRegion: Codable, Comparable, Hashable, Sendable {
    
    /// Absolute date represented. This date is not associated with any timezone or calendar but represent the absolute number of seconds since Jan 1, 2001 at 00:00:00 UTC.
    /// - Author: Scott Brenner | SBDate
    public internal(set) var date: Date
    
    /// - Author: Scott Brenner | SBDate
    public let region: Region
    
    /// Initialize with an absolute date and represent it in the given geographic region.
    /// - Parameter date: Absolute date to represent.
    /// - Parameter region: The region in which the date is represented.
    public init(_ date: Date = Date(), region: Region = .default) {
        self.date = date
        self.region = region
    }
    
    /// Initialize a new date from a number of seconds since the Unix Epoch.
    /// - Parameter interval: seconds since the Unix Epoch timestamp.
    /// - Parameter region: region in which the date must be expressed. Defaults to the UTC timezone.
    public init(timeIntervalSince1970 interval: TimeInterval, region: Region = .UTC) {
        self.init(Date(timeIntervalSince1970: interval), region: region)
    }
}

extension DateInRegion: DateRepresentable {
    
    public init?(components: DateComponents, region: Region? = .default) {
        let r = region ?? components.region
        guard let date = r.calendar.date(from: components)
        else { return nil }
        self.init(date, region: r)
    }
    
    public init(
        year: Int,
        month: Int,
        day: Int,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0,
        region: Region = .default
    ) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond
        components.timeZone = region.timeZone
        components.calendar = region.calendar
        self.init(region.calendar.date(from: components)!, region: region)
    }
    
    public init?(
        year: Int,
        dayOfYear: Int,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0,
        region: Region = .default
    ) {
        guard dayOfYear >= 1 && dayOfYear <= 366,
            let firstDayOfYear = DateComponents(calendar: region.calendar, year: year, month: 1, day: 1, hour: hour, minute: minute).date,
            !(!firstDayOfYear.isLeapYear && dayOfYear == 366),
            let date = region.calendar.date(byAdding: .day, value: dayOfYear - 1, to: firstDayOfYear)
        else { return nil }
        self.init(date, region: region)
    }
    
    public static func distantPast() -> Self {
        DateInRegion(.distantPast, region: .default)
    }
    
    public static func distantFuture() -> Self {
        DateInRegion(.distantFuture, region: .default)
    }
}
