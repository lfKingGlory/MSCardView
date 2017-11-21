//
//  MSCardView2.m
//  navi_test
//
//  Created by msj on 2017/11/20.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSCardView2.h"
#import "MSScrollView.h"

#define COUNT  5

@interface MSCardView2 ()<UIScrollViewDelegate>
@property (strong, nonatomic) MSScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *datas;
@end

@implementation MSCardView2
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    _datas = [NSMutableArray array];
    _scrollView = [[MSScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * COUNT, 0);
    [self addSubview:_scrollView];
    
    
    CGFloat paddingH = 0;
    CGFloat paddingV = 0;
    CGFloat y = paddingV;
    CGFloat width = self.scrollView.bounds.size.width - 2 * paddingH;
    CGFloat height = self.scrollView.bounds.size.height - 2 * paddingV;
    for (int i = 0; i < COUNT; i++) {
        
        CGFloat x = paddingH + i * (width + 2 * paddingH);
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        v.layer.anchorPoint = CGPointMake(0, 1);
        v.frame = CGRectMake(x, y, width, height);
        [self.scrollView addSubview:v];
        [self.datas addObject:v];
        
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, v.bounds.size.width - 40, v.bounds.size.height - 140)];
        subView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
        subView.layer.cornerRadius = 10;
        [v addSubview:subView];
        
    }
}

@end
