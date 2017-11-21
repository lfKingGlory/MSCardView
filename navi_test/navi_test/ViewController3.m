//
//  ViewController3.m
//  navi_test
//
//  Created by msj on 2017/11/21.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "ViewController3.h"
#import "MSCardView3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    MSCardView3 *c = [[MSCardView3 alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 180)];
    [self.view addSubview:c];
}

@end
