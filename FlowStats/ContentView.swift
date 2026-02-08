//
// ContentView.swift
// FlowStats
// https://www.github.com/aybarsnazlica/FlowStats
// See LICENSE for license information.
//


import SwiftUI

struct ContentView: View {
    @State private var statistics = [Statistic]()
    @State private var showImporter = false

    var body: some View {
        VStack {
            Button("Open CSV") {
                showImporter = true
            }

            List(statistics) { statistic in
                VStack(alignment: .leading) {
                    Text(statistic.session)
                        .font(.headline)
                    Text("Completed: \(statistic.completed.formatted(date: .abbreviated, time: .shortened))")
                        .font(.subheadline)
                }
            }
        }
        .csvImporter(isPresented: $showImporter, statistics: $statistics)
    }
}

#Preview {
    ContentView()
}
