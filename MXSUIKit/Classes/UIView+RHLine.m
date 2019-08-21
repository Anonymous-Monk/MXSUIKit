//
//  UIView+RHLine.m
//  KongFu
//
//  Created by zero on 2018/2/9.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "UIView+RHLine.h"

static const CGFloat kLineDefault = 0.5f;
//hexString @"dddddd"
#define kLineColor [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]

@implementation UIView (RHLine)

- (UIView *)addTopLine {
    return [self addTopLine:0.0f rightSpace:0.0f];
}
- (UIView *)addTopLine:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace {
    UIView *_topLine         = [UIView new];
    _topLine.backgroundColor = kLineColor;
    [self addSubview:_topLine];
    
    //add constraints
    [_topLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *viewsDictionary = @{@"_topLine":_topLine};
    NSDictionary *metrics         = @{@"kLineDefault":@(kLineDefault),
                                      @"leftSpace":@(leftSpace),
                                      @"rightSpace":@(rightSpace)
                                      };
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_topLine(kLineDefault)]"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:viewsDictionary];
    
    NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftSpace-[_topLine]-rightSpace-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:viewsDictionary];
    
    [self addConstraints:constraintV];
    [self addConstraints:constraintH];
    return _topLine;
}

- (UIView *)addLeftLine {
    return [self addLeftLine:0.0f bottomSpace:0.0f];
}
- (UIView *)addLeftLine:(CGFloat)topSpace bottomSpace:(CGFloat)bottomSpace {
    UIView *_leftLine         = [UIView new];
    _leftLine.backgroundColor = kLineColor;
    [self addSubview:_leftLine];
    
    //add constraints
    [_leftLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *viewsDictionary = @{@"_leftLine":_leftLine};
    NSDictionary *metrics         = @{@"kLineDefault":@(kLineDefault),
                                      @"topSpace":@(topSpace),
                                      @"bottomSpace":@(bottomSpace)
                                      };
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpace-[_leftLine]-bottomSpace-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:viewsDictionary];
    
    NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_leftLine(kLineDefault)]"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:viewsDictionary];
    
    [self addConstraints:constraintV];
    [self addConstraints:constraintH];
    return _leftLine;
}

- (UIView *)addBottomLine {
    return [self addBottomLine:0.0f rightSpace:0.0f];
}

- (UIView *)addBottomLine:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace {
    UIView *_bottomLine         = [UIView new];
    _bottomLine.backgroundColor = kLineColor;
    [self addSubview:_bottomLine];
    
    //add constraints
    [_bottomLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *viewsDictionary = @{@"_bottomLine":_bottomLine};
    NSDictionary *metrics         = @{@"kLineDefault":@(kLineDefault),
                                      @"leftSpace":@(leftSpace),
                                      @"rightSpace":@(rightSpace)
                                      };
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_bottomLine(kLineDefault)]-0-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:viewsDictionary];
    
    NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftSpace-[_bottomLine]-rightSpace-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:viewsDictionary];
    
    [self addConstraints:constraintV];
    [self addConstraints:constraintH];
    return _bottomLine;
}

- (UIView *)addRightLine {
    return [self addRightLine:0.0f bottomSpace:0.0f];
}
- (UIView *)addRightLine:(CGFloat)topSpace bottomSpace:(CGFloat)bottomSpace {
    UIView *_rightLine         = [UIView new];
    _rightLine.backgroundColor = kLineColor;
    [self addSubview:_rightLine];
    
    //add constraints
    [_rightLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *viewsDictionary = @{@"_rightLine":_rightLine};
    NSDictionary *metrics         = @{@"kLineDefault":@(kLineDefault),
                                      @"topSpace":@(topSpace),
                                      @"bottomSpace":@(bottomSpace)
                                      };
    NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpace-[_rightLine]-bottomSpace-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:viewsDictionary];
    
    NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_rightLine(kLineDefault)]-0-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:viewsDictionary];
    
    [self addConstraints:constraintV];
    [self addConstraints:constraintH];
    return _rightLine;
}


@end
