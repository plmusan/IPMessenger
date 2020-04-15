/*============================================================================*
 * (C) 2001-2019 G.Ishiwata, All Rights Reserved.
 *
 *	Project		: IP Messenger for macOS
 *	File		: RetryInfo.m
 *	Module		: メッセージ再送情報クラス
 *============================================================================*/

#import "RetryInfo.h"
#import "UserInfo.h"

@interface RetryInfo()
@property(assign,readwrite)	NSInteger	messageID;
@property(assign,readwrite)	UInt32		command;
@property(retain,readwrite)	UserInfo*	toUser;
@property(retain,readwrite)	NSString*	message;
@property(retain,readwrite)	NSString*	option;
@end

/*============================================================================*
 * クラス実装
 *============================================================================*/

@implementation RetryInfo

/*----------------------------------------------------------------------------*
 * ファクトリ
 *----------------------------------------------------------------------------*/

+ (instancetype)infoWithMessageID:(NSInteger)msgId
						  command:(UInt32)cmd
							   to:(UserInfo*)to
						  message:(NSString*)msg
						   option:(NSString*)opt
{
	return [[[RetryInfo alloc] initWithMessageID:msgId
										 command:cmd
											  to:to
										 message:msg
										  option:opt] autorelease];
}

+ (NSString*)identifyKeyForMessageID:(NSInteger)msgId to:(UserInfo*)to
{
	return [NSString stringWithFormat:@"%ld/%@", msgId, to.description];
}

/*----------------------------------------------------------------------------*
 * 初期化／解放
 *----------------------------------------------------------------------------*/

// 初期化
- (instancetype)initWithMessageID:(NSInteger)msgId
						  command:(UInt32)cmd
							   to:(UserInfo*)to
						  message:(NSString*)msg
						   option:(NSString*)opt
{
	self = [super init];
	if (self) {
		self.messageID	= msgId;
		self.command	= cmd;
		self.toUser		= to;
		self.message	= msg;
		self.option		= opt;
		self.retryCount	= 0;
	}
	return self;
}

// 解放
- (void)dealloc
{
	self.toUser		= nil;
	self.message	= nil;
	self.option		= nil;
	[super dealloc];
}

- (NSString*)identifyKey {
	return [RetryInfo identifyKeyForMessageID:self.messageID to:self.toUser];
}

@end
