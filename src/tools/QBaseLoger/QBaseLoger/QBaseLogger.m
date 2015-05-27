#import "QBaseLogger.h"

// 异常日志
#define BT_EXCEPTION_LOG_PATH \
    ([NSString stringWithFormat:@"%@/Library/logs/crash.log", NSHomeDirectory()])

@implementation QBaseLogger

#pragma mark -
#pragma mark PUBLIC FUNCTION

+ (NSString *)write:(NSString *)message
{
    return [[QBaseLogger shareInstance] write:message];
}
+ (NSString *)write:(NSString *)message logPath:(NSString *)logPath
{
    return [[QBaseLogger shareInstance] write:message logPath:logPath];
}

#pragma mark -
#pragma mark LOG HANDLE FUNCTION

+ (instancetype)shareInstance
{
    static QBaseLogger *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        // 分隔符
        [self write:@"\n\n====================    用户开启设备、分隔符    ====================\n\n"];
        
        // 注册异常
        [self registerExceptionHandler];
    }
    return self;
}

- (void)registerExceptionHandler
{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

void UncaughtExceptionHandler(NSException *exception)
{
    NSString *name = [exception name];
    NSString *reason = [exception reason];
    NSArray *symbols = [exception callStackSymbols];
    NSString *date = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970])];
    
    NSString *des = [NSString stringWithFormat:
     @"======== 异常崩溃详情 ========= \n"
     "崩溃时间:%@\n"
     "崩溃名称:%@\n"
     "崩溃原因:\n"
     "%@\n"
     "崩溃栈信息:\n"
     "%@",
     date,
     name,
     reason,
     [symbols componentsJoinedByString:@"\n"]];
    
    [[QBaseLogger shareInstance] write:des logPath:BT_EXCEPTION_LOG_PATH];
}

- (NSString *)write:(NSString *)message logPath:(NSString *)logPath
{
    // 日志文件夹路径
    NSString *logDir = [logPath stringByDeletingLastPathComponent];
    
    // 文件夹路径不存在、创建文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDir];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:logDir
               withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 写入日志文件
    if (![fileManager fileExistsAtPath:logPath]) {
        [message writeToFile:logPath
                  atomically:YES
                    encoding:NSUTF8StringEncoding
                       error:nil];
    }else {
        // 分隔符
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        formatter.dateFormat = @"HH:mm:ss";
        NSString* timeString = [formatter stringFromDate:[NSDate date]];
        NSString *appendMessage = [NSString stringWithFormat:@"\n\n ----- %@ -------- \n",timeString];
        
        // 添加文件
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logPath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[appendMessage dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:[message dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
    };
    
    return logPath;
}

- (NSString *)write:(NSString *)message
{
    return [self write:message logPath:[self logPath]];
}

/// 打印日志文件路径
- (NSString *)logPath
{
    // com.**.** 2015-05-27.log
    NSString *bundleId = [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString* filename = [formatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@/Library/logs/%@_%@.log", NSHomeDirectory(), bundleId, filename];
}

@end
