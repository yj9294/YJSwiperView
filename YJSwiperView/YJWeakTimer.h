//
//  YJWeakTimer.h
//  YJSwiperView
//
//  Created by yangjian on 2021/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJWeakTimer : NSObject
+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats ;
@end

NS_ASSUME_NONNULL_END
