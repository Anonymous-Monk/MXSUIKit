//
//  UIControl+RHSound.h
//  RHBaseModule
//
//  Created by aicai on 2018/7/9.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (RHSound)

//不同事件增加不同声音
- (void)rh_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;

@end
