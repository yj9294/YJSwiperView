//
//  YJScrollView.h
//  YJScrollViewController
//
//  Created by 阳剑 on 17/4/4.
//  Copyright © 2017年 阳剑. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YJScrollViewDelegate <NSObject>

@optional
- (void)selectedAtIndex:(NSInteger)index;

@end

@interface YJScrollView : UIView

//图片数据源
@property (nonatomic, strong) NSArray *imageArray;

//轮播的间隔时间,单位秒
@property (nonatomic, assign) NSTimeInterval timeInval;

@property (nonatomic, assign) id <YJScrollViewDelegate> delegate;

@end
