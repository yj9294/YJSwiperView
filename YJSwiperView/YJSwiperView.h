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
- (UIView *)bannerView:(YJBannerView *)bannerView cellForItemAtIndex:(NSInteger)index ;
@end

@interface YJSwiperView : UIView
@property (nonatomic, weak)  id  <YJBannerViewDataSource>  dataSource;
@end

NS_ASSUME_NONNULL_END
