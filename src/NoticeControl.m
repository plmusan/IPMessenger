/*============================================================================*
 * (C) 2001-2019 G.Ishiwata, All Rights Reserved.
 *
 *	Project		: IP Messenger for macOS
 *	File		: NoticeControl.m
 *	Module		: 通知ダイアログコントローラ
 *============================================================================*/

#import <Cocoa/Cocoa.h>
#import "NoticeControl.h"

/*============================================================================*
 * クラス実装
 *============================================================================*/

@implementation NoticeControl

/*----------------------------------------------------------------------------*
 * 初期化
 *----------------------------------------------------------------------------*/

// 初期化
- (id)initWithTitle:(NSString*)title message:(NSString*)msg date:(NSDate*)date {
	NSPoint	centerPoint;
	int		sw, sh, ww, wh;

	self = [super init];
	// nibファイルロード
	if (![[NSBundle mainBundle] loadNibNamed:@"NoticeDialog" owner:self topLevelObjects:nil]) {
		[self autorelease];
		return nil;
	}
	[window retain];	// loadNibNamedのAPIが変更になってOnwershipが変わったため

	// 表示文字列設定
	[titleLabel		setStringValue:title];
	[messageLabel	setStringValue:msg];
	[dateLabel		setObjectValue:((date) ? date : [NSDate date])];

	// 画面表示位置計算
	sw	= [[NSScreen mainScreen] visibleFrame].size.width;
	sh	= [[NSScreen mainScreen] visibleFrame].size.height;
	ww	= [window frame].size.width;
	wh	= [window frame].size.height;
	centerPoint.x = (sw - ww) / 2 + (rand() % (sw / 4)) - sw / 8;
	centerPoint.y = (sh - wh) / 2 + (rand() % (sh / 4)) - sh / 8;
	[window setFrameOrigin:centerPoint];

	// ウィンドウメニューから除外
	[window setExcludedFromWindowsMenu:YES];

	// ダイアログ表示
	[window makeKeyAndOrderFront:self];

	return self;
}

/*----------------------------------------------------------------------------*
 * その他
 *----------------------------------------------------------------------------*/

// ウィンドウクローズ時処理
- (void)windowWillClose:(NSNotification*)aNotification {
	[self release];
}

@end
