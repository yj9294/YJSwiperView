//
//  YJWeakTimer.m
//  YJSwiperView
//
//  Created by yangjian on 2021/10/30.
//

#import "YJWeakTimer.h"
#import "YJWeakTimerTarget.h"
@interface YJWeakTimer ()
@end

@implementation YJWeakTimer
+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats {
    YJWeakTimerTarget* timerTarget = [[YJWeakTimerTarget alloc] init];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:timerTarget
                                                       selector:@selector(fire:)
                                                       userInfo:userInfo
                                                        repeats:repeats];
    return timerTarget.timer;
}

- (void)fire:(NSTimer *)timer {
}

@end
