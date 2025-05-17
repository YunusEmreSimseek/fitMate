//
//  KeyboardManager.swift
//  fitMate
//
//  Created by Emre Simsek on 17.04.2025.
//

import Combine
import SwiftUI

@Observable
final class KeyboardManager {
    var currentHeight: CGFloat = 0
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)

        willShow
            .merge(with: willHide)
            .sink { [weak self] notification in
                guard let self else { return }
                if notification.name == UIResponder.keyboardWillShowNotification,
                   let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                {
                    self.currentHeight = value.height
                } else {
                    self.currentHeight = 0
                }
            }
            .store(in: &cancellableSet)
    }
}
