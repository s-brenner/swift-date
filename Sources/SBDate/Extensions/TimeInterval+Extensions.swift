import Foundation

extension TimeInterval {
    
    /// - Author: Scott Brenner | SBDate
    public static func toNextNearest(
        _ components: DateComponents,
        since referenceDate: some DateRepresentable = Date()
    ) -> TimeInterval {
        referenceDate
            .toNearest(components, rounding: .up)
            .date
            .timeIntervalSince(referenceDate.date)
    }
}
