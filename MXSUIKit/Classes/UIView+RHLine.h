//
//  UIView+RHLine.h
//  KongFu
//
//  Created by zero on 2018/2/9.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RHLine)

- (UIView *)addTopLine;
- (UIView *)addTopLine:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;

- (UIView *)addLeftLine;
- (UIView *)addLeftLine:(CGFloat)topSpace bottomSpace:(CGFloat)bottomSpace;

- (UIView *)addBottomLine;
- (UIView *)addBottomLine:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;

- (UIView *)addRightLine;
- (UIView *)addRightLine:(CGFloat)topSpace bottomSpace:(CGFloat)bottomSpace;

@end
