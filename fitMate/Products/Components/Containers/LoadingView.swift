//
//  LoadingView.swift
//  fitMate
//
//  Created by Emre Simsek on 13.04.2025.
//
import SwiftUI

struct LoadingView: View {
    var isLoading : Bool
    var body: some View {
        if isLoading {
            ProgressView().scaleEffect(1.5)
        }
        else {
            ProgressView().scaleEffect(0)
        }
    }
}

