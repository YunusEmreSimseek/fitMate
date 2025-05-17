//
//  LogManager.swift
//  fitMate
//
//  Created by Emre Simsek on 26.04.2025.
//

import os

final class LogManager {
    private let logger = Logger(subsystem: "yemresimsekkk.fitMate", category: "fitMate")
    func debug(_ message: String) {
        logger.debug("🐛 \(message, privacy: .public)")
    }

    func info(_ message: String) {
        logger.info("ℹ️ \(message, privacy: .public)")
    }

    func warning(_ message: String) {
        logger.warning("⚠️ \(message, privacy: .public)")
    }

    func error(_ message: String) {
        logger.error("❌ \(message, privacy: .public)")
    }
}
