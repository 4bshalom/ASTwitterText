import XCTest
@testable import ASTwitterText

final class ASTwitterTextTests: XCTestCase {
    
    func testExample() throws {
        let count = ASTwitterText.checkTextCount(text: "hello test")
        XCTAssertEqual(count, 10)
    }
    
    func testEmojiText() throws {
        let count = ASTwitterText.checkTextCount(text: "Hello, world! 😀")
        XCTAssertEqual(count, 16)
    }
    
    func testUrlText() throws {
        let count = ASTwitterText.checkTextCount(text: "Hello, google.com 😀")
        XCTAssertEqual(count, 33)
    }
    
    func testChineeseText() throws {
        let count = ASTwitterText.checkTextCount(text: "儒家")
        XCTAssertEqual(count, 4)
    }
    
    func testArabicText() throws {
        let count = ASTwitterText.checkTextCount(text: "Hello, مرحبا 😀")
        XCTAssertEqual(count, 15)
    }
    
}
