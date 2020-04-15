/*============================================================================*
 * (C) 2001-2019 G.Ishiwata, All Rights Reserved.
 *
 *	Project		: IP Messenger for macOS
 *	File		: RetryInfo.h
 *	Module		: メッセージ再送情報クラス
 *============================================================================*/

#import <Foundation/Foundation.h>

@class UserInfo;

/*============================================================================*
 * クラス定義
 *============================================================================*/

@interface RetryInfo : NSObject

@property(readonly)		NSInteger	messageID;		// メッセージID
@property(readonly)		UInt32		command;		// 送信コマンド
@property(readonly)		UserInfo*	toUser;			// 送信相手
@property(readonly)		NSString*	message;		// メッセージ文字列
@property(readonly)		NSString*	option;			// 拡張メッセージ文字列
@property(readonly)		NSString*	identifyKey;	// 識別文字列
@property(readwrite)	NSInteger	retryCount;		// リトライ回数

// ファクトリ
+ (instancetype)infoWithMessageID:(NSInteger)msgId
						  command:(UInt32)cmd
							   to:(UserInfo*)to
						  message:(NSString*)msg
						   option:(NSString*)opt;

+ (NSString*)identifyKeyForMessageID:(NSInteger)msgId
								  to:(UserInfo*)to;

// 初期化
- (instancetype)initWithMessageID:(NSInteger)msgId
						  command:(UInt32)cmd
							   to:(UserInfo*)to
						  message:(NSString*)msg
						   option:(NSString*)opt;

@end
