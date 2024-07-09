//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation

public class DateTimeUtils {
    public static func timeUntilEpoch(epochTimestamp: TimeInterval) -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let targetDate = Date(timeIntervalSince1970: epochTimestamp)
        let currentDate = Date()

        // Ensure the target date is in the future
        guard targetDate > currentDate else {
            return (0, 0, 0, 0)
        }

        let timeInterval = targetDate.timeIntervalSince(currentDate)

        let days = Int(timeInterval) / (24 * 3600)
        let hours = (Int(timeInterval) % (24 * 3600)) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60

        return (days, hours, minutes, seconds)
    }
}
