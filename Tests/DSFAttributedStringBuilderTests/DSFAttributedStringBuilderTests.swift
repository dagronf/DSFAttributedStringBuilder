import XCTest
@testable import DSFAttributedStringBuilder

final class DSFAttributedStringBuilderTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        // XCTAssertEqual(DSFSecureTextField().text, "Hello, World!")
    }

	func testStringAssign() {

		let basicString = "This is a test"
		let burmeseString = "မြန်မာနိုင်ငံတော်"

		let str = DSFAttributedStringBuilder()
		str.append(basicString)
		str.append(burmeseString)
		let attrstr = str.attributed

		XCTAssertEqual(attrstr.string, basicString + burmeseString)

		// Stream extension to NSAttributedString

		let attrstr2 = NSAttributedString.build { (stream) in
			stream.append(basicString)
			stream.append(burmeseString)
		}
		XCTAssertEqual(attrstr2.string, basicString + burmeseString)
	}

	func testBasicStringStyling() {
		let basicString = "This is a test"
		let middleString = "မြန်မာနိုင်ငံတော် 👩‍👩‍👧‍👦 لوحة المفاتيح العربية"
		let secondString = "اَلْفُصْحَىٰI don't like this"

		let attrstr = NSAttributedString.build { (stream) in
			stream.append(basicString)
				.setUnderline(.double)
				.append(middleString)
				.unsetUnderline()
				.append(secondString)
		}

		var range = NSRange(location: 0, length: -1)
		var attrs = attrstr.attributes(at: 0, effectiveRange: &range)
		XCTAssertEqual(0, attrs.count)

		// Check the last char of the basicString
		attrs = attrstr.attributes(at: basicString.utf16.count - 1, effectiveRange: &range)
		XCTAssertEqual(0, attrs.count)
		XCTAssertNotEqual(attrs[.underlineStyle] as? Int, NSUnderlineStyle.double.rawValue)

		// Check the first char of burmeseString
		attrs = attrstr.attributes(at: basicString.utf16.count, effectiveRange: &range)
		XCTAssertEqual(1, attrs.count)
		XCTAssertEqual(attrs[.underlineStyle] as? Int, NSUnderlineStyle.double.rawValue)

		// Check the last char of burmeseString
		attrs = attrstr.attributes(at: basicString.utf16.count + middleString.utf16.count - 1, effectiveRange: &range)
		XCTAssertEqual(1, attrs.count)
		XCTAssertEqual(attrs[.underlineStyle] as? Int, NSUnderlineStyle.double.rawValue)

		// Check the first char of secondString
		attrs = attrstr.attributes(at: basicString.utf16.count + middleString.utf16.count, effectiveRange: &range)
		XCTAssertEqual(0, attrs.count)
		XCTAssertNotEqual(attrs[.underlineStyle] as? Int, NSUnderlineStyle.double.rawValue)
	}


    static var allTests = [
        ("testExample", testExample),
    ]
}
