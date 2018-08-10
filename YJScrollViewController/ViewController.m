//
//  ViewController.m
//  YJScrollViewController
//
//  Created by 阳剑 on 17/4/4.
//  Copyright © 2017年 阳剑. All rights reserved.
//

#import "ViewController.h"
#import "YJScrollView.h"
@interface ViewController ()  <YJScrollViewDelegate>

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
    scrollView.timeInval = 1;
    //事件代理
    scrollView.delegate = self;
    //图片源
    scrollView.imageArray = @[[UIImage imageNamed:@"1@2x.png"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"]];
    [self.view addSubview:scrollView];
}


- (void)selectedAtIndex:(NSInteger)index
{
    NSLog(@"我按了第%ld个按钮",(long)index);
}





















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
