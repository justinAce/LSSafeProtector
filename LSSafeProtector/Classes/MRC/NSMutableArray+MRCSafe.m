

//
//  NSMutableArray+MRCSafe.m
//  LSSafeProtector
// https://github.com/lsmakethebest/LSSafeProtector
//
//  Created by liusong on 2018/9/18.
//

#import "NSMutableArray+MRCSafe.h"
#import "NSObject+SafeSwizzle.h"
#import "LSSafeProtector.h"

@implementation NSMutableArray (MRCSafe)
+(void)openMRCSafeProtector
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //方法交换只要一次就好
        Class dClass=NSClassFromString(@"__NSArrayM");
        //由于低于11.0交换此方法会导致有键盘显示的地方，此时退到后台会crash [UIKeyboardLayoutStar release]: message sent to deallocated instance 0x7fd762cc11f0
            [self safe_exchangeInstanceMethod:dClass originalSel:@selector(objectAtIndex:) newSel:@selector(safe_objectAtIndexM:)];
    });
}

-(id)safe_objectAtIndexM:(NSUInteger)index
{
    @autoreleasepool{
        id object=nil;
        @try {
            object= [self safe_objectAtIndexM:index];
        }
        @catch (NSException *exception) {
            LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSMutableArray);
        }
        @finally {
            return object;
        }
    }
}


@end
