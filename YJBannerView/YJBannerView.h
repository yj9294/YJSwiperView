//
//  SLBannerView.h
//  Silvers
//
//  Created by nico on 2020/4/10.
//  Copyright © 2020 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SLBannerView;
@protocol SLBannerViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemsInbannerView:(SLBannerView *)bannerView ;
- (UIView *)bannerView:(SLBannerView *)bannerView cellForItemAtIndex:(NSInteger)index ;
@end

@interface SLBannerView : UIView
@property (nonatomic, weak)  id  <SLBannerViewDataSource>  dataSource;
@end

NS_ASSUME_NONNULL_END
