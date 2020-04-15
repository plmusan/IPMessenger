/*============================================================================*
 * (C) 2001-2019 G.Ishiwata, All Rights Reserved.
 *
 *	Project		: IP Messenger for macOS
 *	File		: DebugLog.m
 *	Module		: デバッグログ機能
 *	Description	: デバッグログ出力関数
 *============================================================================*/

#import "DebugLog.h"

/*----------------------------------------------------------------------------*
 * ログ出力
 *----------------------------------------------------------------------------*/
#if defined(IPMSG_DEBUG)

#define LOG_SHOW_DATE	0
#define LOG_TO_CONSOLE	1

void IPMsgLog(NSString* level, const char* file, int line, const char* func, NSString* msg)
{
	static NSLock*			writeLock	= nil;
	static NSDateFormatter* format		= nil;
	NSString*				str;
	const char*				pFile;
	if (!format) {
		format = [[NSDateFormatter alloc] init];
		format.locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];
#if LOG_SHOW_DATE
		format.dateFormat = @"yyyy/MM/dd HH:mm:ss.SSS";
#else
		format.dateFormat = @"HH:mm:ss.SSS";
#endif
	}
	if (!writeLock) {
		writeLock = [[NSLock alloc] init];
	}
	if (!file) {
		file = "<NULL>";
	}
	if (!func) {
		func = "<NULL>";
	}
	str = [format stringForObjectValue:[NSDate date]];
	pFile = strrchr(file, '/');
	if (!pFile) {
		pFile = file;
	} else {
		pFile++;
	}
	[writeLock lock];
	@try {
#if LOG_TO_CONSOLE
		printf("%s%s %s:%4d%s %s\n", [level UTF8String], [str UTF8String], pFile, line, func, [msg UTF8String]);
#else
		NSString*	dir	= [[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent];
		NSString*	log	= [dir stringByAppendingPathComponent:@"DebugLog.txt"];
		FILE*		fp	= fopen([log fileSystemRepresentation], "a");
		if (fp) {
			fprintf(fp, "%s%s %s:%4d%s %s\n", [level UTF8String], [str UTF8String], pFile, line, func, [msg UTF8String]);
			fflush(fp);
			fclose(fp);
		} else {
			printf("%s%s %s:%4d%s %s\n", [level UTF8String], [str UTF8String], pFile, line, func, [msg UTF8String]);
		}
#endif
	}
	@catch (NSException* exception) {
		printf("!!! logging error(%s) !!!(cString convert)\n", [[exception name] UTF8String]);
	}
	[writeLock unlock];
}

#endif
