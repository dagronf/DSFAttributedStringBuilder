//
//  AppDelegate.swift
//  DSFAttributedStringStream Demo
//
//  Created by Darren Ford on 26/3/19.
//  Copyright © 2019 Darren Ford. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	@IBOutlet var textView: NSTextView!
	

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		self.configure()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

}

extension AppDelegate {

	class Styles {
		static var H1: [NSAttributedString.Key : Any] {
			return [.font: NSFont.boldSystemFont(ofSize: 24), .foregroundColor: NSColor.red ]
		}
		static var H2: [NSAttributedString.Key : Any] {
			return [.font: NSFont.boldSystemFont(ofSize: 18), .foregroundColor: NSColor.systemPink ]
		}
		static var P: [NSAttributedString.Key : Any] {
			return [.font: NSFont.systemFont(ofSize: NSFont.systemFontSize), .foregroundColor: NSColor.textColor ]
		}
		static var italic: [NSAttributedString.Key : Any] {
			return [ .obliqueness: 0.2 ]
		}
		static func underline(_ style: NSUnderlineStyle) -> [NSAttributedString.Key : Any] {
			return [ .underlineStyle: style.rawValue ]
		}
		static func link(_ address: URL) -> [NSAttributedString.Key : Any] {
			return [ .link: address ]
		}
		static func underline() -> [NSAttributedString.Key : Any] {
			return [ .underlineStyle: NSUnderlineStyle.single.rawValue ]
		}
		static func PBold() -> [NSAttributedString.Key : Any] {
			return [.font: NSFont.boldSystemFont(ofSize: NSFont.systemFontSize), .foregroundColor: NSColor.textColor ]
		}
	}

	func configure() {

		let firstSegment = NSAttributedString.stream {
			$0.set(Styles.H1)
			$0.link(url: URL(string: "https://apple.com")!, text: "Click here")
			$0.append(" to visit our website").endl().endl()
			$0.link(url: URL(string: "https://swift.org/")!).endl().endl()

			$0.set(Styles.P).set(Styles.underline())
			$0.append("Simple test using basic style sheet")
			$0.unset(Styles.underline()).endl().endl()
			$0.set(Styles.H1).append("Heading").endl()
			$0.set(Styles.H2).append("Subheading").endl()
			$0.set(Styles.P)
			$0.set([.toolTip: "Caterpillar"])
			$0.link(url: URL(string: "https://apple.com")!, text: "This")
			$0.unset(.toolTip)
			$0.append(" is the ")
			$0.set(Styles.italic).append("text").unset(Styles.italic)
			$0.append(". ")
			$0.set(Styles.PBold())
			$0.set(Styles.underline(.single)).append("This").unset(Styles.underline())
			$0.append(" is not")
			$0.endl().endl()

			$0.unsetAll()
			$0.set(NSColor.textColor)
			$0.set(NSFont.systemFont(ofSize: NSFont.systemFontSize))
			$0.append("This could be better performed using a ")
			$0.set([.toolTip: "In functional programming, a monad is a design pattern that allows structuring programs generically while automating away boilerplate code needed by the program logic"])
			$0.append("monad")
			$0.set([.baselineOffset: 5])
			$0.set(NSFont.systemFont(ofSize: NSFont.smallSystemFontSize))
			$0.append("1")
			$0.unset([.baselineOffset, .toolTip])
			$0.set(NSFont.systemFont(ofSize: NSFont.systemFontSize))
			$0.append(". (Hover over the text 'monad' to reveal the tooltip)")
			$0.endl().endl()
		}

		let secondSegment = NSAttributedString.stream { stream in
			stream.set(Styles.P)
				.set(Styles.underline())
				.append("Simple test using abstract calls")
				.unset(Styles.underline())
				.endl().endl()

				.set(NSColor.green)
				.set(NSParagraphStyle.stream { obj in
					obj.alignment = .center
				})

				.set(NSFont.systemFont(ofSize: 24))
				.append("Cat|")
				.set(NSFont.boldSystemFont(ofSize: 36))
				.append("Dog|[eee]")
				.set(NSColor.blue)
				.set([.obliqueness: 0.2])
				.append("Dog[👋🏿👅")
				.set([.underlineStyle: NSUnderlineStyle.single.rawValue])
				.append("- Testing 🧙🏿‍♂️ shifting - ").endl()
				.append(NSImage(named: NSImage.bookmarksTemplateName)!, CGSize(width: 64, height: 64))
				.unset(Styles.underline())
				.append("👣🇿🇼]").endl()
				.unset(.obliqueness)
				.set(NSFont.systemFont(ofSize: 24))
		}

		let replaceable = "ᎤᎵᎩᏳᏍᎠᏅᏁ"
		let thirdSegment = NSAttributedString.stream { stream in
			stream.set(Styles.P)
				.append("｡  🎀  𝒯𝒽𝒾𝓈 𝒾𝓈 𝒶 𝓉𝑒𝓈𝓉  🎀  ｡")
				.set([.obliqueness: -0.1])
				.append("|Fish")
				.unset(.obliqueness)
				.set(NSColor.systemPink).append("•").endl().endl().endl().endl()
				.set(NSColor.systemRed).append("T̷̻̙͂ȟ̴͓̂̋͘í̷̼̱̱̲͇͙̤̦͎̽͐̃̿̀̚ş̷̙̪̬͔̊̑̅̾ ̸̦̠̬̫͔͕̮̦̤̾ͅį̸̨̡͖̭͉̦̮͐͜ͅŝ̸̱̪̻̹͍̣̺̏̾̓̄͝ ̴̨̦͔̬̭̯̙͑̽̑a̵̩̎̆̑̑́ ̷̳̺̽̐̆͋͌͂̑́t̷͎̠̣͚͈̙̟̓̀̂̌̚͜ͅḛ̵̢̢̡͚̟̳̖̬̼̏̎̿̾̀̓͝͝s̷̡̨̛͍̤͉̩̜̖ͅͅt̷̡̧̢͚̣̳̆").endl().endl().endl().endl()
				.set(NSColor.yellow).append("This text should be all yellow, with a green full stop")
				.set(NSColor.green).append(".").endl().endl()
				.set(NSColor.textColor)
				.append("٩(-̮̮̃-̃)۶ ٩(●̮̮̃•̃)۶ ٩(͡๏̯͡๏)۶ ٩(-̮̮̃•̃). \(replaceable) ").endl()
		}

		let fourthSegment = NSAttributedString.stream { stream in
			stream.set(NSFont.boldSystemFont(ofSize: 55))
				.set(NSShadow.stream { (shadow) in
					shadow.shadowColor = NSColor.disabledControlTextColor
					shadow.shadowOffset = NSSize(width: 1, height: -1)
					shadow.shadowBlurRadius = 3.0
				})
				.append("台北市立動物園的白手長").endl()
		}

		let fifthSegment = NSAttributedString.stream { stream in
			stream.set(NSParagraphStyle.stream { obj in
				obj.alignment = .right
			})
				.set(NSColor.textColor)
				.append("﷽").endl().endl()
		}

		let sixthSegment = NSAttributedString.stream {
			$0.set(NSFont.boldSystemFont(ofSize: 36))
			$0.set(NSColor.textColor)
			$0.append("And here is a centered image...").endl()
			$0.set(NSParagraphStyle.stream { obj in
				obj.alignment = .center
			})
			$0.append(NSImage(named: NSImage.bonjourName)!, CGSize(width: 128, height: 128)).endl()
			$0.set(NSParagraphStyle.stream { obj in
				obj.alignment = .left
			})
			$0.set(NSFont.boldSystemFont(ofSize: 24))
			$0.append("Some text containing non-english characters").endl()
			$0.set(NSFont.systemFont(ofSize: 16))
			$0.append("Both names derive from the Bamar people ")
			$0.set(NSColor.disabledControlTextColor)
			$0.append("(ဗမာလူမျိုး [bəmà lùmjó])")
			$0.set(NSColor.textColor)
			$0.append(", the largest ethnic group in Burma. The full official name of the country is the \"Republic of the Union of Myanmar\" ")
			$0.set(NSColor.disabledControlTextColor)
			$0.append("(ပြည်ထောင်စုသမ္မတ မြန်မာနိုင်ငံတော် [pjìdàʊɴzṵ θàɴməda̰ mjəmà nàɪɴŋàɴdɔ̀])")
			$0.set(NSColor.textColor)
			$0.append(".").endl().endl()

			$0.set(NSColor.textColor).set(NSFont.systemFont(ofSize: 24))
			$0.append("Last sentence 🧖🏼‍♀️.  The final shriek should be red")
			$0.set(NSColor.systemRed).set(NSFont.boldSystemFont(ofSize: 64))
			$0.append("!")
		}

		let full = NSMutableAttributedString()
		full.append(firstSegment)
		full.append(secondSegment)
		full.append(thirdSegment)
		full.append(fourthSegment)
		full.append(fifthSegment)
		full.append(sixthSegment)
		self.textView.textStorage!.setAttributedString(full)
	}
}
