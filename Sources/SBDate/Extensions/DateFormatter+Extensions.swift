import SBFoundation

extension DateFormatter {
    
    /// - Author: Scott Brenner | SBDate
    public var region: Region {
        get { Region(calendar: calendar, timeZone: timeZone, locale: locale) }
        set {
            calendar = newValue.calendar
            timeZone = newValue.timeZone
            locale = newValue.locale
        }
    }
    
    /// Return the local thread shared date formatter for a given date style and time style configured for the given region.
    /// - Parameter dateStyle: The date style of the returned formatter.
    /// - Parameter timeStyle: The time style of the returned formatter.
    /// - Parameter region: The region of the returned formatter.
    static func shared(
        dateStyle: DateFormatter.Style,
        timeStyle: DateFormatter.Style,
        region: Region = .default
    ) -> DateFormatter {
        let name = "SBDate.\(String(describing: DateFormatter.self)).dateStyle=\(dateStyle.rawValue).timeStyle=\(timeStyle.rawValue)"
        let formatter: DateFormatter = threadSharedObject(key: name) {
            let formatter = DateFormatter()
            formatter.dateStyle = dateStyle
            formatter.timeStyle = timeStyle
            return formatter
        }
        formatter.region = region
        return formatter
    }

    /// Return the local thread shared date formatter for a given date format configured for the given region.
    /// - Author: Scott Brenner | SBDate
    /// - Parameter dateFormat: The date format string of the returned formatter.
    /// - Parameter region: The region of the returned formatter.
    static func shared(dateFormat: String, region: Region = .default) -> DateFormatter {
        let name = "SBDate.\(String(describing: DateFormatter.self)).dateFormat=\(dateFormat)"
        let formatter: DateFormatter = threadSharedObject(key: name) {
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
            return formatter
        }
        formatter.region = region
        return formatter
    }
}
