//
//  UIFont+RHFont.m
//  RHBaseModule
//
//  Created by aicai on 2018/7/9.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import "UIFont+RHFont.h"

@implementation UIFont (RHFont)

+ (CGFloat)rh_fitScreen:(CGFloat)value {
    return ceilf([[UIScreen mainScreen] bounds].size.width / (750.0f / 2)  * (value / 1.0f));
}

+ (UIFont *)rh_fitSystemFontOfSize:(CGFloat)fontSize {
    
    return [UIFont systemFontOfSize:[self rh_fitScreen:fontSize]];
}

+ (UIFont *)rh_fitBoldSystemFontOfSize:(CGFloat)fontSize {
    
    return [UIFont boldSystemFontOfSize:[self rh_fitScreen:fontSize]];
}

+ (UIFont *)rh_fitItalicSystemFontOfSize:(CGFloat)fontSize {
    
    return [UIFont italicSystemFontOfSize:[self rh_fitScreen:fontSize]];
}

+ (UIFont *)rh_fitSystemFontOfSize:(CGFloat)fontSize
                            weight:(UIFontWeight)weight NS_AVAILABLE_IOS(8_2) {
    
    return [UIFont systemFontOfSize:[self rh_fitScreen:fontSize]
                             weight:[self rh_fitScreen:weight]];
}

+ (UIFont *)rh_fitMonospacedDigitSystemFontOfSize:(CGFloat)fontSize
                                           weight:(UIFontWeight)weight NS_AVAILABLE_IOS(9_0) {
    
    return [UIFont monospacedDigitSystemFontOfSize:[self rh_fitScreen:fontSize]
                                            weight:[self rh_fitScreen:weight]];
}


@end
