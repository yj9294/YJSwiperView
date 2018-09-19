//
//  ViewController.m
//  YJScrollViewController
//
//  Created by 阳剑 on 17/4/4.
//  Copyright © 2017年 阳剑. All rights reserved.
//

#import "ViewController.h"
#import "YJScrollView.h"
@interface ViewController ()  <YJScrollViewDelegate,YJScrollViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addScrollView];
}
- (void)addScrollView
{
    //调用无限滚动view
    YJScrollView *scrollView  = [[YJScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    //滚动间隔时间
    //scrollView.timeInval = 1;
    //事件代理
    scrollView.delegate = self;
    scrollView.dataSource = self;
    [self.view addSubview:scrollView];
}

#pragma mark - YJScrollViewDelegate

- (void)selectedAtIndex:(NSInteger)index
{
    NSLog(@"我按了第%ld个按钮",(long)index);
}
#pragma mark - YJScrollViewDelegate
- (NSArray *)dataSourceForSwiperView:(YJScrollView *)swiperView{
    return @[[UIImage imageNamed:@"1@2x.png"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"]];
//    @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536125392403&di=5909da11721bb7dbfa113ad18773e154&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D1472150169%2C2026190739%26fm%3D214%26gp%3D0.jpg",
      //                              @"http://47.105.111.215:8080/common/show?app=true&filePath=pic/201807101532/%E4%B8%A4%E5%8F%AA%E8%80%81%E8%99%8E.jpg"]
}




















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
