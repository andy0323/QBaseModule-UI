#import <Foundation/Foundation.h>

@interface QBaseLogger : NSObject

+ (NSString *)write:(NSString *)message;
+ (NSString *)write:(NSString *)message logPath:(NSString *)logPath;

@end
