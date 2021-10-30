//
//  SLBannerView.h
//  Silvers
//
//  Created by nico on 2020/4/10.
//  Copyright © 2020 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YJSwiperView;
@protocol YJBannerViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemsInbannerView:(YJSwiperView *)bannerView ;
- (UIView *)bannerView:(YJSwiperView *)bannerView cellForItemAtIndex:(NSInteger)index ;
@end

@protocol YJBannerViewDelegate <NSObject>
@required
- (void)bannerView:(YJSwiperView *)bannerView didScrollAtIndex:(NSInteger)index ;
@end

@interface YJSwiperView : UIView
@property (nonatomic, strong) UIColor  *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor  *currentPageIndicatorTintColor;
@property (nonatomic, assign) NSTimeInterval  timeInterval;

@property (nonatomic, weak)  id  <YJBannerViewDataSource>  dataSource;
@property (nonatomic, weak)  id  <YJBannerViewDelegate>  delegate;

- (UIView * _Nullable )cellForItemAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
