/*============================================================================*
 * (C) 2001-2011 G.Ishiwata, All Rights Reserved.
 *
 *	Project		: IP Messenger for macOS
 *	File		: NSStringIPMessenger.m
 *	Module		: NSStringカテゴリ拡張
 *============================================================================*/

#import "NSStringIPMessenger.h"
#import "DebugLog.h"

@implementation NSString(IPMessenger)

// IPMessenger用送受信文字列変換（C文字列→NSString)
+ (id)stringWithSJISString:(const char*)cString
{
	return [[[NSString alloc] initWithSJISString:cString] autorelease];
}

// IPMessenger用送受信文字列変換（C文字列→NSString)
- (id)initWithSJISString:(const char*)cString
{
	return [self initWithCString:cString encoding:-2147482063];
}

// IPMessenger用送受信文字列変換（NSString→C文字列)
- (const char*)SJISString
{
	// SJISの場合、'¥'は'\'に変換しておかないと文字化けする
	NSString* str = [self stringByReplacingOccurrencesOfString:@"¥"
													withString:@"\\"];
	if (![str canBeConvertedToEncoding:-2147482063]) {
		// 変換できない文字がある場合は安全な方法で変換する
		NSData*			data1 = [str dataUsingEncoding:-2147482063
								  allowLossyConversion:YES];
		NSMutableData*	data2 = [[data1 mutableCopy] autorelease];
		[data2 appendBytes:"\0" length:1];
		return (const char*)[data2 bytes];
	}
	// 変換できるならそのまま
	return [str cStringUsingEncoding:-2147482063];
}

@end
