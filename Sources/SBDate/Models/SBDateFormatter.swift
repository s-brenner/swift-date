import SBFoundation

/// A lightweight date formatter that is much faster than a traditional DateFormatter.
public struct SBDateFormatter: Sendable {
    
    public enum DayOfWeek: Int {
        case sunday = 0
        case monday = 1
        case tuesday = 2
        case wednesday = 3
        case thursday = 4
        case friday = 5
        case saturday = 6
        
        var description: String {
            switch self {
            case .sunday: return "Sun"
            case .monday: return "Mon"
            case .tuesday: return "Tue"
            case .wednesday: return "Wed"
            case .thursday: return "Thu"
            case .friday: return "Fri"
            case .saturday: return "Sat"
            }
        }
    }
    
    enum Month: Int {
        case january = 1
        case february = 2
        case march = 3
        case april = 4
        case may = 5
        case june = 6
        case july = 7
        case august = 8
        case september = 9
        case october = 10
        case november = 11
        case december = 12
        
        var description: String {
            switch self {
            case .january: return "Jan"
            case .february: return "Feb"
            case .march: return "Mar"
            case .april: return "Apr"
            case .may: return "May"
            case .june: return "Jun"
            case .july: return "Jul"
            case .august: return "Aug"
            case .september: return "Sep"
            case .october: return "Oct"
            case .november: return "Nov"
            case .december: return "Dec"
            }
        }
    }
    
    public static let shared = SBDateFormatter()
    
    public init() { }
    
    /// Return a description of a given year, month and day in the format "Sat 29 Jun".
    /// - Parameter year: Year.
    /// - Parameter month: Month.
    /// - Parameter day: Day.
    public static func description(forYear year: Int, month: Int, day: Int) -> String {
        let dayOfWeek = SBDateFormatter.dayOfWeek(year: year, month: month, day: day)
        let month = Month(rawValue: month)!
        return "\(dayOfWeek.description) \(day) \(month.description)"
    }
    
    /// Determines the day of the week for a given year, month, and day.
    /// - Parameter year: Year.
    /// - Parameter month: Month.
    /// - Parameter day: Day.
    /// ````
    /// // Determine the day of the week for June 29, 2019
    /// dayOfWeek(year: 2019, month: 6, day: 29)
    /// // .saturday
    /// ````
    public static func dayOfWeek(year: Int, month: Int, day: Int) -> DayOfWeek {
        let k = Double(day)
        let m: Double = {
            switch month {
            case 2: return 12
            default: return Double((month + 10) % 12)
            }
        }()
        let c = Double(year / 100)
        let y: Double = {
            switch month {
            case 1, 2: return Double((year % 100) - 1)
            default: return Double(year % 100)
            }
        }()
        let rawValue: Int = {
            let value = k + floor(2.6 * m - 0.2) - (2 * c) + y + floor(y / 4) + floor(c / 4)
            return Int(value).mod(7)
        }()
        return DayOfWeek(rawValue: rawValue)!
    }
    
    /// Determine the number of days in a given year and month.
    /// - Parameter year: Year.
    /// - Parameter month: Month.
    /// ````
    /// // Determine the number of days in June 2019.
    /// numberOfDays(inYear: 2019, month: 6)
    /// // 30
    /// ````
    public static func numberOfDays(inYear year: Int, month: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
            
        case 4, 6, 9, 11:
            return 30
            
        case 2:
            do { return try DateComponents(year: year).isLeapYear() ? 29 : 28 }
            catch { return 0 }
            
        default:
            return 0
        }
    }
}
