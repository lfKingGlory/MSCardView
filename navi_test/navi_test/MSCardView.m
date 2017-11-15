//
//  MSCardView.m
//  navi_test
//
//  Created by msj on 2017/11/15.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSCardView.h"

@interface MSCardView ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *arrM;
@end

@implementation MSCardView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 15, self.bounds.size.width - 60, self.bounds.size.height - 30)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        self.arrM = [NSMutableArray array];
        _scrollView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    }
    return self;
}

- (void)setCount:(NSInteger)count {
    if (count <= 0) {
        return;
    }
    _count = count;
    [self.arrM makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.arrM removeAllObjects];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * count, 0);
    
    CGFloat paddingLeft = 10;
    CGFloat width = self.scrollView.bounds.size.width - 2 * paddingLeft;
    
    for (int i = 0; i < count; i++) {
        CGFloat x = paddingLeft + i * (width + 2 * paddingLeft);
        CGFloat scaleFactor = [self getScaleFactorWithCenterPadding:((x + width/2.0) - (width/2.0 + paddingLeft)) contentOffsetX:self.scrollView.contentOffset.x];
        
        CGFloat height = self.scrollView.bounds.size.height * scaleFactor;
        CGFloat y = (self.scrollView.bounds.size.height - height)/2.0;
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        v.layer.cornerRadius = 8;
        v.layer.masksToBounds = YES;
        v.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
        [self.scrollView addSubview:v];
        [self.arrM addObject:v];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat paddingLeft = 10;
    CGFloat width = self.scrollView.bounds.size.width - 2 * paddingLeft;
    for (int i = 0;  i < self.arrM.count; i++) {

        UIView *v = self.arrM[i];
        CGFloat scaleFactor = [self getScaleFactorWithCenterPadding:((v.frame.origin.x + width/2.0) - (width/2.0 + paddingLeft)) contentOffsetX:contentOffsetX];
        CGFloat height = self.scrollView.bounds.size.height * scaleFactor;
        CGFloat y = (self.scrollView.bounds.size.height - height)/2.0;
        v.frame = CGRectMake(v.frame.origin.x, y, v.frame.size.width, height);
    }
}

- (CGFloat)getScaleFactorWithCenterPadding:(CGFloat)centerPadding contentOffsetX:(CGFloat)contentOffsetX {
    CGFloat distanceFromCenterX = centerPadding - contentOffsetX;
    CGFloat offsetRatio = fabs(distanceFromCenterX) / self.scrollView.bounds.size.width;
    return fmin(1 - offsetRatio * 0.2, 1);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isEqual:self]) {
        for (UIView *subview in self.arrM) {
            CGPoint offset = [self convertPoint:point toView:subview];
            if ((view = [subview hitTest:offset withEvent:event])) {
                return view;
            }
        }
        return self.scrollView;
    }
    return view;
}

@end
