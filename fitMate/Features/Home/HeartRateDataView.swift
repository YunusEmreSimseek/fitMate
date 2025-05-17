//
//  HeartRateDataView.swift
//  fitMate
//
//  Created by Emre Simsek on 15.04.2025.
//

import Charts
import SwiftUI

struct HeartRateData: Identifiable {
    let id = UUID()
    let time: Int
    let bpm: Int
}

struct HeartRateDataView: View {
    let data: [HeartRateData] = [
        .init(time: 0, bpm: 72),
        .init(time: 10, bpm: 84),
        .init(time: 20, bpm: 100),
        .init(time: 30, bpm: 120),
        .init(time: 40, bpm: 106),
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Heart Rate")
                .font(.headline)
                .foregroundColor(.white)
                .hPadding()
                .topPadding()

            Chart(data) {
                LineMark(
                    x: .value("Time", $0.time),
                    y: .value("BPM", $0.bpm)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(.cBlue)
                .lineStyle(StrokeStyle(lineWidth: 3))
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .allPadding()
            .background(.cGray)
            .cornerRadius(12)
            .bottomPadding(.low3)
        }
        .background(
            RoundedRectangle(cornerRadius: .normal)
                .fill(.cGray)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 4)
        )
    }
}

#Preview {
    HeartRateDataView()
}
