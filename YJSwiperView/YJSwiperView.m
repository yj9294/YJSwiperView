//
//  YJSwiperView.m
//  Silvers
//
//  Created by nico on 2020/4/10.
//  Copyright © 2020 XX. All rights reserved.
//

#import "YJSwiperView.h"
#import "Masonry.h"

@interface YJSwiperView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger   numberOfItems;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign)  NSInteger   page;
@end

@implementation YJSwiperView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
    }
    [self addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    self.pageControl = [[UIPageControl alloc] init];
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView.mas_centerX);
        make.bottom.equalTo(self.scrollView.mas_bottom).offset(-16);
    }];
}

- (void)setDataSource:(id<YJBannerViewDataSource>)dataSource {
    _dataSource = dataSource;
    if([self.dataSource respondsToSelector:@selector(numberOfItemsInbannerView:)]) {
        self.numberOfItems = [self.dataSource numberOfItemsInbannerView:self];
        self.pageControl.numberOfPages = self.numberOfItems;
        [self addTimer];
        
        UIView *firstView = [self.dataSource bannerView:self cellForItemAtIndex:(self.numberOfItems -1) % self.numberOfItems];
        [self.scrollView addSubview:firstView];
        [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.scrollView);
            make.width.height.equalTo(self.scrollView);
        }];
        UIView *leftView = firstView;
        for (int i = 1 ; i < self.numberOfItems + 1; i++ ) {
            UIView *view = [self.dataSource bannerView:self cellForItemAtIndex:i-1];
            [self.scrollView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftView.mas_right);
                make.top.bottom.equalTo(self.scrollView);
                make.width.height.equalTo(self.scrollView);
            }];
            leftView = view;
        }
        UIView *lastView = [self.dataSource bannerView:self cellForItemAtIndex:0];
        [self.scrollView addSubview:lastView];
        [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.scrollView);
            make.left.equalTo(leftView.mas_right);
            make.width.height.equalTo(self.scrollView);
        }];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.numberOfItems) {
        [self.scrollView setContentSize:CGSizeMake(self.frame.size.width * (self.numberOfItems + 2), self.frame.size.height)];
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (void)scroll {
    [self.scrollView setContentOffset:CGPointMake(UIApplication.sharedApplication.keyWindow.frame.size.width * (self.page + 1), 0) animated:YES];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.page == self.numberOfItems+1) {
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    if (self.page == 0) {
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width * (self.numberOfItems), 0);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / self.frame.size.width - 0.5;
    self.page = scrollView.contentOffset.x / self.frame.size.width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * self.pageControl.numberOfPages, 0);
    } else if (scrollView.contentOffset.x == scrollView.frame.size.width * (self.pageControl.numberOfPages + 1)) {
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

@end
