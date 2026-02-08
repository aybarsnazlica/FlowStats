//
// CsvImporterModifier.swift
// FlowStats
// https://www.github.com/aybarsnazlica/FlowStats
// See LICENSE for license information.
//


import SwiftUI
internal import UniformTypeIdentifiers

struct CsvImporterModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var statistics: [Statistic]

    func body(content: Content) -> some View {
        content
            .fileImporter(
                isPresented: $isPresented,
                allowedContentTypes: [.commaSeparatedText]
            ) { result in
                Task {
                    do {
                        let url = try result.get()

                        let didStartAccessing = url.startAccessingSecurityScopedResource()
                        defer {
                            if didStartAccessing {
                                url.stopAccessingSecurityScopedResource()
                            }
                        }

                        let text = try String(contentsOf: url, encoding: .utf8)
                        let parsed = text
                            .split(separator: "\n")
                            .compactMap { Statistic(csv: String($0)) }
                        statistics = parsed
                    } catch {
                        print("CSV import failed:", error)
                    }
                }
            }
    }
}

extension View {
    func csvImporter(isPresented: Binding<Bool>, statistics: Binding<[Statistic]>) -> some View {
        self.modifier(CsvImporterModifier(isPresented: isPresented, statistics: statistics))
    }
}

