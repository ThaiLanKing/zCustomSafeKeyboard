//
//  UtilsMacros.h
//  JamBoHealth
//
//  Created by zyh on 17/6/27.
//  Copyright © 2017年 zyh. All rights reserved.
//

/**
 * 全局工具类宏定义
 * 主要存放一些跟具体App无关、任何App都可以使用的通用性宏定义
 */

#ifndef UtilsMacros_h
#define UtilsMacros_h

#ifdef DEBUG

#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

#else

#define NSLog(format, ...) {}

#endif

#pragma mark - 获取系统对象

#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#pragma mark - 部分界面属性

#define kScreenBounds     ([UIScreen mainScreen].bounds)
#define kScreenBoundsSize (kScreenBounds.size)
#define kScreenWidth      (kScreenBoundsSize.width)
#define kScreenHeight     (kScreenBoundsSize.height)
#define kStatusBarH       ([UIApplication sharedApplication].statusBarFrame.size.height)

#pragma mark - 强弱引用
//RAC的@weakify有个优势：可以同时操作多个对象，如@weakify(obj1, obj2),而如下定义不行
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

#pragma mark - GCD

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
}else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#pragma mark - 发送通知

#define KPostNotification(name, obj) [kNotificationCenter postNotificationName:name object:obj];

#pragma mark - 系统版本号判断

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark -

#define FontWithSize(fontSize) [UIFont systemFontOfSize:(fontSize)]

#define Color(colorStr) UIColorFromHexColor(colorStr)

static inline UIColor * UIColorFromHexColor(NSString *hexColor)
{
    if (hexColor.length < 6) {
        return nil;
    }
    unsigned int red,green,blue,alpha = 255;
    NSRange range;
    range.length = 2;
    
    NSInteger startLocation = 0;
    if ([hexColor hasPrefix:@"#"]) {
        startLocation += 1;
    }
    
    range.location = startLocation;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location += range.length;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location += range.length;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    if (hexColor.length >= 8) {
        range.location += range.length;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&alpha];
    }
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(alpha/255.0f)];
}

#endif /* UtilsMacros_h */
