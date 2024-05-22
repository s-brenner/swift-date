import Foundation

extension Date: DateRepresentable {
    
    public var date: Date { self }
    
    public var region: Region { .default }
    
    /// Initialize a new date with time components passed.
    /// - Parameter components: Date components
    /// - Parameter region: Region in which the date is expressed. Ignore to use .default, nil to use DateComponents data.
    public init?(components: DateComponents, region: Region? = .default) {
        guard let date = DateInRegion(components: components, region: region)?.date else { return nil }
        self = date
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
        self = region.calendar.date(from: components)!
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
            let date = region.calendar.date(byAdding: .day, value: dayOfYear - 1, to: firstDayOfYear) else {
                return nil
        }
        self = date
    }
    
    public static func distantPast() -> Date { .distantPast }
    
    public static func distantFuture() -> Date { .distantFuture }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Date.FormatStyle {
    
    /// - Author: Scott Brenner | SBDate
    public func region(_ region: Region) -> Self {
        var output = self
        output.calendar = region.calendar
        output.locale = region.locale
        output.timeZone = region.timeZone
        return output
    }
}

extension Date {
    
    /// - Author: Scott Brenner | SBDate
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public struct DateRepresentableFormatStyle: Foundation.FormatStyle {
        
        private enum Style: Codable, Hashable {
            case formatted(String)
        }
        
        private var style: Style
        
        private var region: Region?
        
        /// - Author: Scott Brenner | SBDate
        public static func format(_ dateFormat: String) -> Self {
            Self(style: .formatted(dateFormat))
        }
        
        /// - Author: Scott Brenner | SBDate
        public func region(_ region: Region) -> Self {
            var output = self
            output.region = region
            return output
        }
        
        /// - Author: Scott Brenner | SBDate
        public func format(_ value: any DateRepresentable) -> String {
            switch style {
            case .formatted(let format):
                return DateFormatter
                    .shared(dateFormat: format, region: region ?? value.region)
                    .string(from: value.date)
            }
        }
    }
}

extension DateFormatter.Style: Codable { }
