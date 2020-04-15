/*============================================================================*
 * (C) 2011-2019 G.Ishiwata, All Rights Reserved.
 *
 *	Project		: IP Messenger for macOS
 *	File		: SendHeaderView.m
 *	Module		: 送信ウィンドウヘッダ部View
 *============================================================================*/

#import "SendHeaderView.h"

@implementation SendHeaderView

- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
	}
	return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSRect rect = [self bounds];

	// 下線描画
	NSBezierPath*	path;
	NSPoint			point1;
	NSPoint			point2;
	path		= [NSBezierPath bezierPath];
	point1		= NSMakePoint(rect.origin.x, rect.origin.y + 0.5);
	point2		= point1;
	point2.x	+= rect.size.width;

	[[NSColor gridColor] set];
	[path setLineWidth:1.0];
	[path moveToPoint:point1];
	[path lineToPoint:point2];
	[path stroke];
}

@end
