//
//  AppDelegate.m
//  DSFAttributeStringStream Objc Demo
//
//  Created by Darren Ford on 1/4/19.
//  Copyright © 2019 Darren Ford. All rights reserved.
//

#import "AppDelegate.h"

#import "DSFAttributeStringStream_Objc_Demo-Swift.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application

	DSFAttributedStringStream* stream = [[DSFAttributedStringStream alloc] init];

	[stream setFont:[NSFont systemFontOfSize:32]];
	[stream setColor:[NSColor textColor]];
	[stream setStyle:NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)];
	[stream append:@"Heading"];
	[stream unsetStyle:NSUnderlineStyleAttributeName];
	[stream append:@" "];
	[stream appendScaledImage:[NSImage imageNamed:NSImageNameInfo]:CGSizeMake(28, 28)];
	[stream append:@" With "];
	[stream setColor:[NSColor systemBlueColor]];
	[stream setStyle:NSObliquenessAttributeName :@(0.2)];
	[stream append:@"Image"];

	[stream endl];
	[stream endl];

	[stream unsetAll];

	[stream setFont:[NSFont systemFontOfSize:24]];
	[stream setColor:[NSColor textColor]];
	[stream append:@"｡  🎀  𝒯𝒽𝒾𝓈 𝒾𝓈 𝒶 𝓉𝑒𝓈𝓉  🎀  ｡"];
	[stream setStyle:NSObliquenessAttributeName:@(-0.1)];
	[stream append:@"|Fish"];
	[stream unsetStyle:NSObliquenessAttributeName];
	[stream setColor:[NSColor systemPurpleColor]];
	[stream append:@"•"];
	[[[[stream endl] endl] endl] endl];
	[stream setColor:[NSColor systemRedColor]];
	[stream append: @"T̷̻̙͂ȟ̴͓̂̋͘í̷̼̱̱̲͇͙̤̦͎̽͐̃̿̀̚ş̷̙̪̬͔̊̑̅̾ ̸̦̠̬̫͔͕̮̦̤̾ͅį̸̨̡͖̭͉̦̮͐͜ͅŝ̸̱̪̻̹͍̣̺̏̾̓̄͝ ̴̨̦͔̬̭̯̙͑̽̑a̵̩̎̆̑̑́ ̷̳̺̽̐̆͋͌͂̑́t̷͎̠̣͚͈̙̟̓̀̂̌̚͜ͅḛ̵̢̢̡͚̟̳̖̬̼̏̎̿̾̀̓͝͝s̷̡̨̛͍̤͉̩̜̖ͅͅt̷̡̧̢͚̣̳̆"];
	[[[[stream endl] endl] endl] endl];
	[stream setColor:[NSColor systemYellowColor]];
	[stream append: @"This text should be all yellow, with a green full stop"];
	[stream setColor:[NSColor systemGreenColor]];
	[stream append: @"."];
	[[stream endl] endl];
	[stream setColor:[NSColor textColor]];
	[stream append:@"٩(-̮̮̃-̃)۶ ٩(●̮̮̃•̃)۶ ٩(͡๏̯͡๏)۶ ٩(-̮̮̃•̃)."];
	[[stream endl] endl];

	[stream unsetAll];
	NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
	[style setAlignment:NSTextAlignmentRight];
	[stream setStyle:NSParagraphStyleAttributeName:style];
	[stream setColor:[NSColor textColor]];
	[stream append:@"﷽"];
	[[stream endl] endl];
	[stream unsetAll];

	NSAttributedString* data = [stream attributed];
	[[[self textView] textStorage] setAttributedString:data];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}


@end
