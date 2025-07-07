//
//  ProfileUnitsSheetView.swift
//  fitMate
//
//  Created by Emre Simsek on 17.06.2025.
//

import SwiftUI

struct ProfileUnitsSheetView: View {
    @Environment(UnitManager.self) private var unitManager

    var body: some View {
        @Bindable var unitManagerBindable = unitManager
        VStack(spacing: .medium2) {
            Text("Units")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)

            UnitSelectionCard(
                icon: "scalemass",
                title: "Weight",
                selection: $unitManagerBindable.weightUnit,
                options: WeightUnit.allCases
            )

            UnitSelectionCard(
                icon: "ruler",
                title: "Height",
                selection: $unitManagerBindable.heightUnit,
                options: HeightUnit.allCases
            )

            UnitSelectionCard(
                icon: "location",
                title: "Distance",
                selection: $unitManagerBindable.distanceUnit,
                options: DistanceUnit.allCases
            )

            Spacer()
        }
        .padding()
        .background(.cBackground)
    }
}

private struct UnitSelectionCard<T: UnitPreference & CaseIterable & Identifiable & Hashable>: View {
    let icon: String
    let title: String
    @Binding var selection: T
    let options: [T]

    var body: some View {
        VStack(alignment: .leading, spacing: .low) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(.cBlue)
                    .font(.headline)
                Text(title)
                    .font(.headline)
            }

            Picker(title, selection: $selection) {
                ForEach(options) { option in
                    Text(option.title.capitalized).tag(option)
                }
            }
            .pickerStyle(.segmented)
        }
        .card(bgColor: .cGray)
    }
}

#Preview {
    ProfileUnitsSheetView()
        .environment(UnitManager())
}
