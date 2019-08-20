//
//  UIFont+RHFont.h
//  RHBaseModule
//
//  Created by aicai on 2018/7/9.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (RHFont)

/**
 自适应设备系统文字大小
 
 @param fontSize 文字大小
 @return UIFont
 */
+ (UIFont *)rh_fitSystemFontOfSize:(CGFloat)fontSize;

/**
 自适应设备系统加粗文字大小
 
 @param fontSize 文字大小
 @return UIFont
 */
+ (UIFont *)rh_fitBoldSystemFontOfSize:(CGFloat)fontSize;

/**
 自适应设备系统斜体文字大小
 
 @param fontSize 文字大小
 @return UIFont
 */
+ (UIFont *)rh_fitItalicSystemFontOfSize:(CGFloat)fontSize;

/**
 设置UIFont的Size和Weight
 
 @param fontSize CGFloat
 @param weight UIFontWeight
 @return UIFont
 */
+ (UIFont *)rh_fitSystemFontOfSize:(CGFloat)fontSize
                            weight:(UIFontWeight)weight NS_AVAILABLE_IOS(8_2);

/**
 根据指定的Size和Weight返回UIFont
 
 @param fontSize CGFloat
 @param weight UIFontWeight
 @return UIFont
 */
+ (UIFont *)rh_fitMonospacedDigitSystemFontOfSize:(CGFloat)fontSize
                                           weight:(UIFontWeight)weight NS_AVAILABLE_IOS(9_0);

@end
