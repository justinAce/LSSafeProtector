//
//  LSSafeProtector.h
// https://github.com/lsmakethebest/LSSafeProtector

//  Created by liusong on 2018/8/9.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSSafeProtectorDefine.h"

@interface LSSafeProtector : NSObject
    
//打开目前所支持的所有安全保护
//isDebug=YES 代表测试环境，当捕获到crash时会利用断言闪退， 同时回调block
//isDebug=NO  代表正式环境，当捕获到crash时不会利用断言闪退，会回调block
+ (void)openSafeProtectorWithIsDebug:(BOOL)isDebug block:(LSSafeProtectorBlock)block;

+ (void)safe_logCrashWithException:(NSException *)exception crashType:(LSSafeProtectorCrashType)crashType;

@end
