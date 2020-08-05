//
//  DSFAttributedStringBuilder.swift
//  DSFAttributedStringBuilder
//
//  Created by Darren Ford on 25/3/19.
//  Copyright © 2019 Darren Ford. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2019 Darren Ford
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#if os(iOS) || os(tvOS)
	import UIKit
#else
	import AppKit
#endif

public extension NSAttributedString {
	static func build(creationBlock: (DSFAttributedStringBuilder) -> Void) -> NSAttributedString {
		let stream = DSFAttributedStringBuilder()
		creationBlock(stream)
		return stream.attributed
	}
}

@objc public class DSFAttributedStringBuilder: NSObject {
	#if os(iOS) || os(tvOS)
		public typealias FontType = UIFont
		public typealias ColorType = UIColor
	#else
		public typealias FontType = NSFont
		public typealias ColorType = NSColor
	#endif

	private struct Attribute {
		let key: NSAttributedString.Key
		let value: Any
		let startPos: Int
		var length: Int = -1
	}

	private var attrs: [Attribute] = []
	private var text = NSMutableAttributedString()

	/// Returns an attributed string style matching the current content
	@objc public var attributed: NSAttributedString {
		let result = self.text.mutableCopy() as! NSMutableAttributedString
		for item in self.attrs {
			let len = (item.length != -1) ? item.length : self.text.length - item.startPos
			result.addAttribute(item.key, value: item.value, range: NSRange(location: item.startPos, length: len))
		}
		return result
	}
}

// MARK: Appending text

public extension DSFAttributedStringBuilder {
	/// Append a string to the stream.  The text will be styled using the currently active styles
	@discardableResult
	@objc func append(_ rhs: String) -> DSFAttributedStringBuilder {
		self.text.append(NSAttributedString(string: rhs))
		return self
	}

	/// Add a end-of-line character to the stream
	@discardableResult
	@objc func endl() -> DSFAttributedStringBuilder {
		self.append("\n")
		return self
	}

	/// Add a tab character to the stream
	@discardableResult
	@objc func tab() -> DSFAttributedStringBuilder {
		self.append("\t")
		return self
	}
}

// MARK: Setting and unsetting styles

public extension DSFAttributedStringBuilder {
	@discardableResult
	@objc(setStyle::) func set(_ key: NSAttributedString.Key, _ value: Any) -> DSFAttributedStringBuilder {
		self.add(key: key, value: value)
		return self
	}

	@discardableResult
	@objc(setStyles:) func set(_ rhs: [NSAttributedString.Key: Any]) -> DSFAttributedStringBuilder {
		return self.add(rhs)
	}

	@discardableResult
	@objc(setShadow:) func set(_ rhs: NSShadow) -> DSFAttributedStringBuilder {
		self.add(key: .shadow, value: rhs)
		return self
	}

	@discardableResult
	@objc(setParagraphStyle:) func set(_ rhs: NSParagraphStyle) -> DSFAttributedStringBuilder {
		self.add(key: NSAttributedString.Key.paragraphStyle, value: rhs)
		return self
	}

	@discardableResult
	@objc(setFont:) func set(_ rhs: FontType) -> DSFAttributedStringBuilder {
		self.add(key: NSAttributedString.Key.font, value: rhs)
		return self
	}

	@discardableResult
	@objc(setColor:) func set(_ rhs: ColorType) -> DSFAttributedStringBuilder {
		self.add(key: NSAttributedString.Key.foregroundColor, value: rhs)
		return self
	}

	/// 'unset' (turn off) the specified attributes from the current location onwards
	@discardableResult
	@objc(unsetStyles:) func unset(_ rhs: [NSAttributedString.Key: Any]) -> DSFAttributedStringBuilder {
		Array(rhs.keys).forEach { self.remove(key: $0) }
		return self
	}

	/// 'unset' (turn off) the specified attributed key from the current location onwards
	@discardableResult
	@objc(unsetStyle:) func unset(_ rhs: NSAttributedString.Key) -> DSFAttributedStringBuilder {
		self.remove(key: rhs)
		return self
	}

	/// 'unset' (turn off) the specified attributed keys from the current location onwards
	@discardableResult
	@objc(unsetStyleArray:) func unset(_ rhs: [NSAttributedString.Key]) -> DSFAttributedStringBuilder {
		rhs.forEach { self.remove(key: $0) }
		return self
	}

	/// 'unset' (turn off) all of the styles currently active from the current location onwards
	@discardableResult
	@objc func unsetAll() -> DSFAttributedStringBuilder {
		self.removeAll()
		return self
	}
}

private extension DSFAttributedStringBuilder {
	func add(key: NSAttributedString.Key, value: Any) {
		self.attrs.append(Attribute(key: key, value: value, startPos: self.text.length))
	}

	func add(_ attributes: [NSAttributedString.Key: Any]) -> DSFAttributedStringBuilder {
		for item in attributes {
			self.add(key: item.key, value: item.value)
		}
		return self
	}

	@discardableResult
	func remove(key: NSAttributedString.Key) -> DSFAttributedStringBuilder {
		for i in 0 ..< attrs.count {
			if attrs[i].length == -1, attrs[i].key == key {
				attrs[i].length = self.text.length - attrs[i].startPos
			}
		}
		return self
	}

	@discardableResult
	func removeAll() -> DSFAttributedStringBuilder {
		for i in 0 ..< attrs.count {
			if attrs[i].length == -1 {
				attrs[i].length = self.text.length - attrs[i].startPos
			}
		}
		return self
	}
}

// MARK: - Convenience methods

// MARK: Image conveniences

public extension DSFAttributedStringBuilder {
	#if os(macOS)

		/// Add an image at the current location
		@discardableResult
		@objc(appendImage:) func append(_ rhs: NSImage) -> DSFAttributedStringBuilder {
			self.append(rhs, rhs.size)
			return self
		}

		/// Add an image to the stream, sizing to the specified CGSize
		@discardableResult
		@objc(appendScaledImage::) func append(_ image: NSImage, _ size: CGSize) -> DSFAttributedStringBuilder {
			let attachment = NSTextAttachment()
			let flipped = NSImage(size: size, flipped: false, drawingHandler: { (rect: NSRect) -> Bool in
				NSGraphicsContext.current?.cgContext.translateBy(x: 0, y: size.height)
				NSGraphicsContext.current?.cgContext.scaleBy(x: 1, y: -1)
				image.draw(in: rect)
				return true
			})

			attachment.image = flipped
			self.text.append(NSAttributedString(attachment: attachment))
			return self
		}

	#elseif os(iOS) || os(tvOS)

		/// Add an image at the current location
		@discardableResult
		@objc(appendImage:) func append(_ rhs: UIImage) -> DSFAttributedStringBuilder {
			let attachment = NSTextAttachment()
			attachment.image = rhs
			attachment.bounds = CGRect(x: 0.0, y: 0.0, width: rhs.size.width, height: rhs.size.height)
			self.text.append(NSAttributedString(attachment: attachment))
			return self
		}

	#endif
}

// MARK: Underline conveniences

public extension DSFAttributedStringBuilder {
	@discardableResult
	func setUnderline(_ style: NSUnderlineStyle, color: ColorType? = nil) -> DSFAttributedStringBuilder {
		self.add(key: .underlineStyle, value: style.rawValue)
		if let color = color {
			self.add(key: .underlineColor, value: color)
		}
		return self
	}

	@discardableResult
	func unsetUnderline() -> DSFAttributedStringBuilder {
		self.remove(key: .underlineStyle)
		self.remove(key: .underlineColor)
		return self
	}
}

// MARK: Link conveniences

public extension DSFAttributedStringBuilder {
	/// Append a link to the attibuted string
	/// - Parameters:
	///   - url: The URL to attach to the link
	///   - text: The text to display for the link. If nil, displays the text of the link
	/// - Returns: The builder object
	@discardableResult
	@objc func link(url: URL, text: String? = nil) -> DSFAttributedStringBuilder {
		self.add(key: .link, value: url)
		if let text = text {
			self.append(text)
		} else {
			self.append("\(url)")
		}
		self.remove(key: .link)
		return self
	}
}

// MARK: Shadow conveniences

extension NSShadow {
	static func build(_ configureBlock: (NSShadow) -> Void) -> NSShadow {
		let obj = NSShadow()
		configureBlock(obj)
		return obj
	}
}

public extension DSFAttributedStringBuilder {
	/// Attach a shadow
	/// - Parameters:
	///   - configureBlock: A block where you can configure the parameters of the shadow
	/// - Returns: The shadow object
	@discardableResult
	@objc func shadow(_ configureBlock: (NSShadow) -> Void) -> NSShadow {
		let obj = NSShadow()
		configureBlock(obj)
		self.add(key: .shadow, value: obj)
		return obj
	}

	/// Remove a shadow
	/// - Returns: The shadow object
	@discardableResult
	@objc func unsetShadow() -> DSFAttributedStringBuilder {
		self.remove(key: .shadow)
		return self
	}
}

// MARK: Paragraph conveniences

extension NSParagraphStyle {
	static func build(_ configureBlock: (NSMutableParagraphStyle) -> Void) -> NSParagraphStyle {
		let obj = NSMutableParagraphStyle()
		configureBlock(obj)
		return obj
	}
}
