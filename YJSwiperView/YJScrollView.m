//
//  YJScrollView.m
//  YJScrollViewController
//
//  Created by 阳剑 on 17/4/4.
//  Copyright © 2017年 阳剑. All rights reserved.
//

#import "YJScrollView.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kWidth        CGRectGetWidth(self.frame)
#define kHeight       CGRectGetHeight(self.frame)
@interface YJScrollView () <UIScrollViewDelegate>

//轮播图片数量
@property (nonatomic, assign) NSInteger content;

//重用队列
@property (nonatomic, strong) NSArray *viewArray;

//图片数据源
@property (nonatomic, strong) NSArray *imageArray;

//定时器,用来自动轮播使用
@property (nonatomic, strong) NSTimer *timer;

//scrollview
@property (nonatomic, strong) UIScrollView *scrollView;

//pageconl
@property  (nonatomic, strong)UIPageControl *page;

@end


@implementation YJScrollView


- (void)timerInit
{
    if(self.imageArray.count){
        _timeInval = _timeInval?:1;
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInval target:self selector:@selector(scan) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}
- (void)dealloc
{
    [_timer invalidate];
    if(_timer)
    {
        _timer = nil;
    }
}

- (void)scan{
    float offestX=_scrollView.contentOffset.x;
    //滚动一个单位
    [self.scrollView setContentOffset:CGPointMake(offestX+ kWidth , 0) animated:YES];
}
- (void)move{
    [_scrollView setContentOffset:CGPointMake((_page.currentPage+1)*kWidth, 0) animated:YES];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.page.frame = CGRectMake(0, kHeight-20, kWidth, 20);
}

#pragma mark UIScrollViewDelegate
//图片轮播或者滑动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float offestX=scrollView.contentOffset.x;
    if(offestX<0){
        scrollView.contentOffset=CGPointMake(_content*kWidth+offestX, 0);
    }
    if(offestX>(_content+1)*kWidth){
        scrollView.contentOffset=CGPointMake(kWidth+(offestX-(_content+1)*kWidth), 0);
    }
//    else
//    {
//        
//    }
////    NSInteger count = (offestX+kWidth/2)/kWidth;
////    scrollView.contentOffset = CGPointMake(count*kWidth, 0);
//
}
//改变pagecol的index
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int num=scrollView.contentOffset.x/kWidth;
    if(num==0){
        num = (int)_content;
    }
    if(num == (int)_content+1){
        num = 1;
    }
    _page.currentPage = num-1;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int num=scrollView.contentOffset.x/kWidth;
    if(num==0){
        num = (int)_content;
    }
    if(num == (int)_content+1){
        num = 1;
    }
    _page.currentPage = num-1;
    CGFloat x = scrollView.contentOffset.x;
    if((int)x%(int)kWidth !=0){
        int scal = x/kWidth;
        [scrollView setContentOffset:CGPointMake(scal*kWidth , 0) animated:YES]; 
    }
}

- (UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        //设置代理
        _scrollView.delegate = self;
        //隐藏滚动条
        _scrollView.showsHorizontalScrollIndicator=NO;
        //初始偏移方向
        _scrollView.contentOffset = CGPointMake(1*kWidth, 0);
    }
    return _scrollView;
}

- (void)setDataSource:(id<YJScrollViewDataSource>)dataSource{
    _dataSource = dataSource;
    NSAssert([self.dataSource respondsToSelector:@selector(dataSourceForSwiperView:)], @"not respondsToSelector dataSourceForSwiperView:");
    self.imageArray = [self.dataSource dataSourceForSwiperView:self];
}

- (void)setImageArray:(NSArray *)imageArray
{
    if(!imageArray.count){
        return;
    }
    _imageArray =imageArray;
    self.content = _imageArray.count;
    //设置srollview的contentsize
    self.scrollView.contentSize = CGSizeMake((_content+2)*kWidth , kHeight);
    //设置pageconl的number
    self.page.numberOfPages = _content;
    //添加contentview(耗内存,以后摒弃)
    for(int i= 0; i<_content+2; i++){
        //摈弃的原因就是在不断alloc新的imageview。
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i* kWidth , 0, kWidth, kHeight)];
        //事件传递响应
        imageView.userInteractionEnabled = YES;
        //内容填充方式
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        //剪切超过边距
        [imageView setClipsToBounds:YES];
        //数据源
        for(UIImage *image1 in _imageArray){
            //判定数据源是UIImage还是url
            if([image1 isKindOfClass:[UIImage class]]){
                imageView.image = _imageArray[(i+2)%_content];
            }
            else if([image1 isKindOfClass:[NSString class]]){
                [imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)_imageArray[(i+2)%_content]]];
            }
            else
                return;
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = self.bounds;
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = (i+2)%_content;
        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        [self.scrollView addSubview:imageView];
    }
    [self addSubview:self.scrollView];
    if(self.pageControlEnable){
        [self addSubview:self.page];
    }
    //开启自动轮播
    [self timerInit];
}
- (UIPageControl *)page
{
    if(!_page)
    {
        _page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, kHeight-20, kWidth, 20)];
        self.pageControlEnable = YES;
        [_page addTarget:self action:@selector(move) forControlEvents:UIControlEventValueChanged];
    }
    return _page;
}
//点击事件代理出去
- (void)touchBtn:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(selectedAtIndex:)]){
        [self.delegate selectedAtIndex:btn.tag];
    }
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    
//}

- (void)setPageColor:(UIColor *)pageColor{
    _pageColor = pageColor;
    [self.page setPageIndicatorTintColor:pageColor];
}

- (void)setPageTinColor:(UIColor *)pageTinColor{
    _pageTinColor = pageTinColor;
    [self.page setCurrentPageIndicatorTintColor:pageTinColor];
}

- (void)reloadData{
    [self setDataSource:_dataSource];
}
@end
