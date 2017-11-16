//
//  MSCardView1.m
//  navi_test
//
//  Created by msj on 2017/11/15.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSCardView1.h"

@interface MSCardItem : UIView
@property (assign, nonatomic) NSInteger count;
@end

@interface MSCardItem ()
@property (strong, nonatomic) UILabel *lbTips;
@end

@implementation MSCardItem
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        UILabel *lbText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        lbText.font = [UIFont boldSystemFontOfSize:35];
        lbText.textAlignment = NSTextAlignmentCenter;
        lbText.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.lbTips = lbText;
        [self addSubview:self.lbTips];
    }
    return self;
}

- (void)setCount:(NSInteger)count {
    self.lbTips.text = [NSString stringWithFormat:@"%ld",count];
}
@end

@interface MSCardView1 ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray <MSCardItem *>*arrM;
@property (assign, nonatomic) NSInteger indexCurrent;
@end

@implementation MSCardView1
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Public
- (void)setDatas:(NSArray<NSNumber *> *)datas {
    if (!datas || datas.count == 0) {
        return;
    }
    _datas = datas;
    self.indexCurrent = 0;
    [self reset];
}

#pragma mark - UIScrollViewDelegate
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reload];
}

#pragma mark - Private
- (void)addSubviews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 15, self.bounds.size.width - 60, self.bounds.size.height - 30)];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * 5, 0);
    [self addSubview:_scrollView];
    self.arrM = [NSMutableArray array];
    
    CGFloat paddingLeft = 10;
    CGFloat width = self.scrollView.bounds.size.width - 2 * paddingLeft;
    
    for (int i = 0; i < 5; i++) {
        CGFloat x = paddingLeft + i * (width + 2 * paddingLeft);
        CGFloat scaleFactor = [self getScaleFactorWithCenterPadding:((x + width/2.0) - (width/2.0 + paddingLeft)) contentOffsetX:self.scrollView.contentOffset.x];
        
        CGFloat height = self.scrollView.bounds.size.height * scaleFactor;
        CGFloat y = (self.scrollView.bounds.size.height - height)/2.0;
        
        MSCardItem *v = [[MSCardItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        v.backgroundColor = [UIColor purpleColor];
        [_scrollView addSubview:v];
        [self.arrM addObject:v];
    }
    self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width * 2, 0);
}

- (void)reload {
    if (!self.datas || self.datas.count == 0) {
        return;
    }
    
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    NSInteger page = contentOffsetX / self.scrollView.bounds.size.width;
    if (page > 2) {
        self.indexCurrent = (self.indexCurrent + (page - 2)) % self.datas.count;
    }else if(page < 2){
        self.indexCurrent = (self.indexCurrent + self.datas.count - (2 - page)) % self.datas.count;
    }
    [self reset];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width * 2, 0);
}

- (void)reset {
    NSInteger indexLeft1 = (self.indexCurrent + self.datas.count - 1) % self.datas.count;
    NSInteger indexLeft2 = (self.indexCurrent + self.datas.count - 2) % self.datas.count;
    NSInteger indexRight1 = (self.indexCurrent + 1) % self.datas.count;
    NSInteger indexRight2 = (self.indexCurrent + 2) % self.datas.count;
    [self.arrM[2] setCount:[self.datas[self.indexCurrent] integerValue]];
    [self.arrM[1] setCount:[self.datas[indexLeft1] integerValue]];
    [self.arrM[0] setCount:[self.datas[indexLeft2] integerValue]];
    [self.arrM[3] setCount:[self.datas[indexRight1] integerValue]];
    [self.arrM[4] setCount:[self.datas[indexRight2] integerValue]];
}

// 始终计算 每个subView 距离 scrollView 的中心距离（动态）,滚动不会改变subView 的 frame
- (CGFloat)getScaleFactorWithCenterPadding:(CGFloat)centerPadding contentOffsetX:(CGFloat)contentOffsetX {
    CGFloat distanceFromCenterX = centerPadding - contentOffsetX;
    CGFloat offsetRatio = fabs(distanceFromCenterX) / self.scrollView.bounds.size.width;
    return fmin(fabs(1 - offsetRatio * 0.2), 1);
}

#pragma mark - Rewrite
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
