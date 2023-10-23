import Foundation

extension TimeZone {
        
    /// The region in the default calendar and locale.
    /// - Author: Scott Brenner | SBDate
    public var region: Region { Region(timeZone: self) }
}
