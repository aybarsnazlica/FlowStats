//
// Session.swift
// FlowStats
// https://www.github.com/aybarsnazlica/FlowStats
// See LICENSE for license information.
//

import SwiftUI

struct Session: Identifiable {
    let id = UUID()
    let name: String
    let started: Date
    let completed: Date

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    init?(csv: String) {
        let fields = csv.components(separatedBy: ",")
        guard fields.count == 3,
            let started = Self.formatter.date(from: fields[1]),
            let completed = Self.formatter.date(from: fields[2])
        else { return nil }

        self.name = fields[0]
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .trimmingCharacters(in: CharacterSet(charactersIn: "\""))
        self.started = started
        self.completed = completed
    }
}
