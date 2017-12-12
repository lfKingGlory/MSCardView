//
//  AnimationNumberView.h
//  NumberAnimation
//
//  Created by 吴涛 on 2016/11/24.
//  Copyright © 2016年 吴涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationNumberView : UIView
@property (nonatomic, strong)UIFont *numberFont;
@property (nonatomic, strong)UIColor *numberColor;
@property (nonatomic, copy) NSString *currentNumber;
@end
