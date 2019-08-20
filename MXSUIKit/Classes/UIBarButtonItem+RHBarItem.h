//
//  UIBarButtonItem+RHBarItem.h
//  RHBaseModule
//
//  Created by aicai on 2018/7/9.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RHBarItem)

/**
 创建 自定义 UIBarButtonItem
 
 @param image image
 @param highImage highImage
 @param target target
 @param action action
 @param controlEvents controlEvents
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *_Nullable)barButtonItemWithImage:(UIImage *_Nullable)image
                                           highImage:(UIImage *_Nullable)highImage
                                              target:(id _Nullable)target
                                              action:(SEL _Nullable)action
                                    forControlEvents:(UIControlEvents)controlEvents;

@end
