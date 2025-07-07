//
//  ProfileNotificationSheetView.swift
//  fitMate
//
//  Created by Emre Simsek on 17.06.2025.
//

import SwiftUI

struct ProfileNotificationSheetView: View {
    @State private var isNotificationEnabled: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: .medium3) {
            Text("Notification").font(.title3).bold()
            HStack {
                Text("Notification").font(.headline)
                Spacer()
                Toggle("", isOn: $isNotificationEnabled)
                    .toggleStyle(SwitchToggleStyle(tint: .cBlue))
            }
            .allPadding(.low)
            .background(.cGray)
            .clipShape(.rect(cornerRadius: .low))

            VStack(alignment: .leading, spacing: .low3) {
                HStack {
                    Text("Note").font(.headline)
                    Spacer()
                }
                Text("Notification permission is denied for this app. Please enable it in the settings to receive notifications.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .allPadding(.low)
            .background(.cGray)
            .clipShape(.rect(cornerRadius: .low))
            
            Spacer()
        }
        .allPadding()
        .background(.cBackground)
    }
}

#Preview {
    ProfileNotificationSheetView()
}
