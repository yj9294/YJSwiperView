//
//  YJScrollView.h
//  YJScrollViewController
//
//  Created by 阳剑 on 17/4/4.
//  Copyright © 2017年 阳剑. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJScrollView;
@protocol YJScrollViewDelegate <NSObject>
@optional
- (void)selectedAtIndex:(NSInteger)index;
@end

@protocol YJScrollViewDataSource <NSObject>
@required
- (NSArray *)dataSourceForSwiperView:(YJScrollView *)swiperView;
@end

@interface YJScrollView : UIView

//轮播的间隔时间,单位秒 默认1秒
@property (nonatomic, assign) NSTimeInterval timeInval;

//是否显示pagecontrol 默认YES
@property (nonatomic, assign)  BOOL     pageControlEnable ;
@property (nonatomic, strong)  UIColor  *pageColor ;
@property (nonatomic, strong)  UIColor  *pageTinColor ;

@property (nonatomic, assign) id <YJScrollViewDelegate> delegate;
@property (nonatomic, assign) id <YJScrollViewDataSource> dataSource ;


//重新加载数据源
- (void)reloadData;
@end
