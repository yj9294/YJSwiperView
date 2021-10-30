//
//  YJWeakTimerTarget.m
//  YJSwiperView
//
//  Created by yangjian on 2021/10/30.
//

#import "YJWeakTimerTarget.h"

@implementation YJWeakTimerTarget
- (void)fire:(NSTimer *)timer {
    if(self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo];
    } else {
        [self.timer invalidate];
    }
}
@end
