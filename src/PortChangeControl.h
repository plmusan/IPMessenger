/*============================================================================*
 * (C) 2001-2011 G.Ishiwata, All Rights Reserved.
 *
 *	Project		: IP Messenger for macOS
 *	File		: PortChangeControl.h
 *	Module		: ポート変更ダイアログコントローラクラス
 *============================================================================*/

#import <Cocoa/Cocoa.h>

@interface PortChangeControl : NSObject
{
	IBOutlet NSPanel*		panel;
	IBOutlet NSTextField*	portNoField;
	IBOutlet NSButton*		okButton;
}

- (IBAction)buttonPressed:(id)sender;
- (IBAction)textChanged:(id)sender;

@end
