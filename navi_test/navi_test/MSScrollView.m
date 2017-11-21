//
//  MSScrollView.m
//  navi_test
//
//  Created by msj on 2017/11/16.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSScrollView.h"
#define DEGREES_TO_RADIANS(x) ((x) / 180.0 * M_PI)

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}

@implementation MSScrollView
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
//    [self transform1];
    [self transform2];
}

- (void)transform1 {
    CGFloat contentOffsetX = self.contentOffset.x;
    for(UIView *view in self.subviews){
        
        CATransform3D t1 = CATransform3DIdentity;
        view.layer.transform = t1;
        //计算每个cell的偏移量
        CGFloat distanceFromCenterX = view.frame.origin.x - contentOffsetX;
        
        CGFloat offsetRatio = distanceFromCenterX / CGRectGetWidth(self.frame);
        CGFloat angle = offsetRatio * 30;
        //前半部分
        if (offsetRatio < 0) {
            //offsetRation 为负
            //沿y轴向右转 沿着y的正方向看是逆时针
            CATransform3D t2 = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-angle), 0, 1,0 );
            //沿x轴向里转 沿着x的正方向看是逆时针
            CATransform3D t3 = CATransform3DRotate(t2, DEGREES_TO_RADIANS(-5 * offsetRatio) , 1, 0, 0);
            //沿y轴向下移动 距离正
            CATransform3D t4 = CATransform3DTranslate(t3, 0, -35 *offsetRatio, 0);
            //实现透视投影 默认是正交投影 以CGPointMake(0, 0)为观察点 3D效果更明显
            view.layer.transform = CATransform3DPerspect(t4, CGPointMake(0, 0), 500);
        }
        else{
            //给个起始位置 在正常位置以下以左的某段距离
            t1 = CATransform3DMakeTranslation(60 * offsetRatio * 1.5, 100 * offsetRatio * 1.5, 0);
            //沿y轴向左转 沿着y的正方向看是顺时针
            CATransform3D t2 = CATransform3DRotate(t1,DEGREES_TO_RADIANS(-angle), 0, 1,0 );
            //沿x轴向里转 沿着x的正方向看是逆时针
            CATransform3D t3 = CATransform3DRotate(t2, DEGREES_TO_RADIANS(5 * offsetRatio), 1, 0, 0);
            //沿y轴向上移动 距离正
            CATransform3D t4 = CATransform3DTranslate(t3, 0, -35 *offsetRatio, 0);
            //实现透视投影 默认是正交投影 以CGPointMake(0, 0)为观察点 3D效果更明显
            view.layer.transform = CATransform3DPerspect(t4, CGPointMake(0, 0), 500);
        }
        
    }
}

- (void)transform2 {

//==================CATransform3D=========================
    CGFloat contentOffsetX = self.contentOffset.x;
    for(UIView *view in self.subviews){

        CATransform3D t1 = CATransform3DIdentity;
        CGFloat distanceFromCenterX = view.frame.origin.x - contentOffsetX;
        CGFloat offsetRatio = distanceFromCenterX / CGRectGetWidth(self.frame);
        CGFloat angle = offsetRatio * 30;
        if (offsetRatio > 0){
            //给个起始位置
            t1 = CATransform3DMakeRotation(DEGREES_TO_RADIANS(1.5*angle), 0, 0, 1);
            //绕Z轴旋转
            CATransform3D t2 = CATransform3DRotate(t1,DEGREES_TO_RADIANS(-angle), 0, 0, 1);
            view.layer.transform = t2;
        }

    }
    
//==================CGAffineTransform=========================
//    CGFloat contentOffsetX = self.contentOffset.x;
//    for(UIView *view in self.subviews){
//
//        CGAffineTransform t1 = CGAffineTransformIdentity;
//        CGFloat distanceFromCenterX = view.frame.origin.x - contentOffsetX;
//        CGFloat offsetRatio = distanceFromCenterX / CGRectGetWidth(self.frame);
//        CGFloat angle = offsetRatio * 30;
//        if (offsetRatio > 0){
//            //给个起始位置
//            t1 = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(1.5*angle));
//            CGAffineTransform t2 = CGAffineTransformRotate(t1, DEGREES_TO_RADIANS(-angle));
//            view.transform = t2;
//
//        }
//
//    }
}
@end
