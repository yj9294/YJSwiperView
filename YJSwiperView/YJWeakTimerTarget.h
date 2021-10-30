//
//  YJWeakTimerTarget.h
//  YJSwiperView
//
//  Created by yangjian on 2021/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJWeakTimerTarget : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;
@end

NS_ASSUME_NONNULL_END
