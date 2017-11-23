//
//  ViewController2.m
//  navi_test
//
//  Created by msj on 2017/11/21.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "ViewController2.h"
#import "MSCardView2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    MSCardView2 *c = [[MSCardView2 alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:c];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    [self.view addGestureRecognizer:pan];
}

- (void)panGes:(UIPanGestureRecognizer *)ges {
    NSLog(@"%s",__func__);
}

@end
