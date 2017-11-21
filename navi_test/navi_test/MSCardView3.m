//
//  MSCardView3.m
//  navi_test
//
//  Created by msj on 2017/11/21.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSCardView3.h"
#define paddingH 30
#define paddingV 15

typedef NS_ENUM(NSInteger, MSCardItem3Position) {
    MSCardItem3PositionLeft,
    MSCardItem3PositionMiddle,
    MSCardItem3PositionRight
};

@interface MSCardItem3 : UIView
@property (assign, nonatomic) MSCardItem3Position position;
@property (assign, nonatomic) CGFloat progress;
@end

@interface MSCardItem3 ()
@property (strong, nonatomic) UIView *contentView;
@end

@implementation MSCardItem3
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    _progress = 0;
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(paddingH, paddingV, self.bounds.size.width - paddingH*2, self.bounds.size.height - paddingV*2)];
    self.contentView.layer.cornerRadius = 8;
    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    [self addSubview:self.contentView];
}

- (void)setPosition:(MSCardItem3Position)position {
    _position = position;
    switch (position) {
        case MSCardItem3PositionLeft:
        {
            self.contentView.frame = CGRectMake(paddingH, paddingV, self.bounds.size.width - paddingH*2, self.bounds.size.height - paddingV*2);
            break;
        }
        case MSCardItem3PositionMiddle:
        {
            self.contentView.frame = CGRectMake(-paddingH * 0.5, paddingV, self.bounds.size.width - paddingH*2, self.bounds.size.height - paddingV*2);
            break;
        }
        case MSCardItem3PositionRight:
        {
            self.contentView.frame = CGRectMake(-paddingH * 2, paddingV, self.bounds.size.width - paddingH*2, self.bounds.size.height - paddingV*2);
            break;
        }
        default:
            break;
    }
}

- (void)setProgress:(CGFloat)progress {
    
    CGRect frame = self.contentView.frame;
    frame.origin.x += paddingH * 1.5 * (progress - _progress);
    self.contentView.frame = frame;
    
    _progress = progress;
}

@end

@interface MSCardView3 ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) MSCardItem3 *itemLeft;
@property (strong, nonatomic) MSCardItem3 *itemMiddle;
@property (strong, nonatomic) MSCardItem3 *itemRight;
@end

@implementation MSCardView3
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * 3, 0);
    [self addSubview:_scrollView];
    
    _scrollView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    
    self.itemLeft = [[MSCardItem3 alloc] initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    self.itemLeft.position = MSCardItem3PositionLeft;
    
    self.itemMiddle = [[MSCardItem3 alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    self.itemMiddle.position = MSCardItem3PositionMiddle;
    
    self.itemRight = [[MSCardItem3 alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width * 2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    self.itemRight.position = MSCardItem3PositionRight;
    
    [_scrollView addSubview:self.itemLeft];
    [_scrollView addSubview:self.itemMiddle];
    [_scrollView addSubview:self.itemRight];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat progress = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.itemLeft.progress = progress;
    self.itemMiddle.progress = progress;
    self.itemRight.progress = progress;
}
@end
