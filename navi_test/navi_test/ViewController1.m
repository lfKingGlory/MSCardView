//
//  ViewController1.m
//  navi_test
//
//  Created by msj on 2017/11/21.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "ViewController1.h"
#import "MSCardView.h"
#import "MSCardView1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    MSCardView1 *c1 = [[MSCardView1 alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 180)];
    c1.datas = @[@1, @2, @3, @4, @5, @6, @7, @8, @9];
    [self.view addSubview:c1];
    
    MSCardView *c = [[MSCardView alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 180)];
    c.count = 8;
    [self.view addSubview:c];

}
@end
