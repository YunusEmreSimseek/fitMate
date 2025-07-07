//
//  ProfileSectionRowViews.swift
//  fitMate
//
//  Created by Emre Simsek on 17.06.2025.
//
import SwiftUI

struct ProfileSectionChevronRow: View {
    let icon: String
    let title: String
    var body: some View {
        HStack {
            Image(systemName: icon).foregroundStyle(.cBlue)
            Text(title).font(.headline).fontWeight(.regular)
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.secondary)
        }
        .contentShape(Rectangle())
    }
}

struct ProfileSectionTextRow: View {
    let icon: String
    let title: String
    let text: String
    var body: some View {
        HStack {
            Image(systemName: icon).foregroundStyle(.cBlue)
            Text(title)
            Spacer()
            Text(text)
                .foregroundColor(.secondary)
                .font(.callout)
        }
        .contentShape(Rectangle())
    }
}

struct ProfileSectionBothRow: View {
    let icon: String
    let title: String
    let text: String
    var body: some View {
        HStack {
            Image(systemName: icon).foregroundStyle(.cBlue)
            Text(title)
            Spacer()
            Text(text)
                .foregroundColor(.secondary)
                .font(.callout)
            Image(systemName: "chevron.right").foregroundColor(.secondary)
        }
        .contentShape(Rectangle())
    }
}
