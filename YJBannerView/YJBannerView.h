//
//  SLBannerView.h
//  Silvers
//
//  Created by nico on 2020/4/10.
//  Copyright © 2020 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YJBannerView;
@protocol YJBannerViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemsInbannerView:(YJBannerView *)bannerView ;
- (UIView *)bannerView:(YJBannerView *)bannerView cellForItemAtIndex:(NSInteger)index ;
@end

@interface YJBannerView : UIView
@property (nonatomic, weak)  id  <YJBannerViewDataSource>  dataSource;
@end

NS_ASSUME_NONNULL_END
