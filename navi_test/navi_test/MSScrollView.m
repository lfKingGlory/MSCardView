//
//  MSScrollView.m
//  navi_test
//
//  Created by msj on 2017/11/16.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSScrollView.h"

@implementation MSScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.panGestureRecognizer.minimumNumberOfTouches = 1;
        self.panGestureRecognizer.maximumNumberOfTouches = 1;
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    //    NSLog(@"tracking====%d===dragging====%d====decelerating===%d",self.tracking,self.dragging,self.decelerating);
    if (gestureRecognizer == self.panGestureRecognizer) {
        if (self.dragging && self.decelerating) {
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}
@end
