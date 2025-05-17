//
//  fitMateTests.swift
//  fitMateTests
//
//  Created by Emre Simsek on 27.04.2025.
//

import Testing

struct fitMateTests {
    @Test("test")
    func testA() async throws {
        let result = true
        #expect(result == true)
    }

    @Test("test2")
    func testB() async throws {
        let result = true
        #expect(result == true)
    }
}
