//
//  ViewController.swift
//  DSFAttributedStringBuilder iOS Demo
//
//  Created by Darren Ford on 31/3/19.
//  Copyright © 2019 Darren Ford. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var textView: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		self.configure()
		
	}


}

extension ViewController {

	class Styles {
		static var H1: [NSAttributedString.Key : Any] {
			return [.font: UIFont.boldSystemFont(ofSize: 24), .foregroundColor: UIColor.red ]
		}
		static var H2: [NSAttributedString.Key : Any] {
			return [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.purple ]
		}
		static var P: [NSAttributedString.Key : Any] {
			return [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize), .foregroundColor: UIColor.black ]
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
			return [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize), .foregroundColor: UIColor.black ]
		}
	}

	func configure() {

		let firstSegment = NSAttributedString.build {
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
			$0.link(url: URL(string: "https://apple.com")!, text: "This")
			$0.append(" is the ")
			$0.set(Styles.italic).append("text").unset(Styles.italic)
			$0.append(". ")
			$0.set(Styles.PBold())
			$0.set(Styles.underline(.single)).append("This").unset(Styles.underline())
			$0.append(" is not")
			$0.endl().endl()
		}

		let secondSegment = NSAttributedString.build { stream in
			stream.set(Styles.P)
				.set(Styles.underline())
				.append("Simple test using abstract calls")
				.unset(Styles.underline())
				.endl().endl()

				.set(UIColor.green)
				.set(NSParagraphStyle.build { obj in
					obj.alignment = .center
				})

				.set(UIFont.systemFont(ofSize: 24))
				.append("Cat|")
				.set(UIFont.boldSystemFont(ofSize: 36))
				.append("Dog|[eee]")
				.set(UIColor.blue)
				.set([.obliqueness: 0.2])
				.append("Dog[👋🏿👅")
				.set([.underlineStyle: NSUnderlineStyle.single.rawValue])
				.append("- Testing 🧙🏿‍♂️ shifting - ").endl()
				.unset(Styles.underline())
				.append("👣🇿🇼]").endl()
				.unset(.obliqueness)
		}

		let replaceable = "ᎤᎵᎩᏳᏍᎠᏅᏁ"
		let thirdSegment = NSAttributedString.build { stream in
			stream.set(Styles.P)
				.append("｡  🎀  𝒯𝒽𝒾𝓈 𝒾𝓈 𝒶 𝓉𝑒𝓈𝓉  🎀  ｡")
				.set([.obliqueness: -0.1])
				.append("|Fish")
				.unset(.obliqueness)
				.set(UIColor.purple).append("•").endl().endl().endl().endl()
				.set(UIColor.red).append("T̷̻̙͂ȟ̴͓̂̋͘í̷̼̱̱̲͇͙̤̦͎̽͐̃̿̀̚ş̷̙̪̬͔̊̑̅̾ ̸̦̠̬̫͔͕̮̦̤̾ͅį̸̨̡͖̭͉̦̮͐͜ͅŝ̸̱̪̻̹͍̣̺̏̾̓̄͝ ̴̨̦͔̬̭̯̙͑̽̑a̵̩̎̆̑̑́ ̷̳̺̽̐̆͋͌͂̑́t̷͎̠̣͚͈̙̟̓̀̂̌̚͜ͅḛ̵̢̢̡͚̟̳̖̬̼̏̎̿̾̀̓͝͝s̷̡̨̛͍̤͉̩̜̖ͅͅt̷̡̧̢͚̣̳̆").endl().endl().endl().endl()
				.set(UIColor.yellow).append("This text should be all yellow, with a green full stop")
				.set(UIColor.green).append(".").endl().endl()
				.set(UIColor.black)
				.append("٩(-̮̮̃-̃)۶ ٩(●̮̮̃•̃)۶ ٩(͡๏̯͡๏)۶ ٩(-̮̮̃•̃). \(replaceable) ").endl()
		}

		let fourthSegment = NSAttributedString.build { stream in
			stream.set(UIFont.boldSystemFont(ofSize: 55))
				.set(NSShadow.build { (shadow) in
					shadow.shadowColor = UIColor.gray
					shadow.shadowOffset = CGSize(width: 1, height: -1)
					shadow.shadowBlurRadius = 3.0
				})
				.append("台北市立動物園的白手長").endl()
		}

		let fifthSegment = NSAttributedString.build { stream in
			stream.set(NSParagraphStyle.build { obj in
				obj.alignment = .right
			})
				.set(UIColor.black)
				.append("﷽").endl().endl()
		}

		let sixthSegment = NSAttributedString.build {
			$0.set(UIFont.boldSystemFont(ofSize: 36))
				.set(UIColor.black)
				.append("And here is a centered image...").endl()
				.set(NSParagraphStyle.build { obj in
					obj.alignment = .center
				})
				.append(UIImage(named: "lego")!).endl().endl()
				.set(NSParagraphStyle.build { obj in
					obj.alignment = .left
				})
				.set(UIFont.boldSystemFont(ofSize: 24))
				.append("Some text containing non-english characters").endl()
				.set(UIFont.systemFont(ofSize: 16))
				.append("Both names derive from the Bamar people ")
				.set(UIColor.gray)
				.append("(ဗမာလူမျိုး [bəmà lùmjó])")
				.set(UIColor.black)
				.append(", the largest ethnic group in Burma. The full official name of the country is the \"Republic of the Union of Myanmar\" ")
				.set(UIColor.gray)
				.append("(ပြည်ထောင်စုသမ္မတ မြန်မာနိုင်ငံတော် [pjìdàʊɴzṵ θàɴməda̰ mjəmà nàɪɴŋàɴdɔ̀])")
				.set(UIColor.black)
				.append(".").endl().endl()

				.set(UIColor.black).set(UIFont.systemFont(ofSize: 24))
				.append("Last sentence 🧖🏼‍♀️.  The final shriek should be red")
				.set(UIColor.red).set(UIFont.boldSystemFont(ofSize: 64))
				.append("!")
		}

		let full = NSMutableAttributedString()
		full.append(firstSegment)
		full.append(secondSegment)
		full.append(thirdSegment)
		full.append(fourthSegment)
		full.append(fifthSegment)
		full.append(sixthSegment)
		self.textView.textStorage.setAttributedString(full)
	}
}
