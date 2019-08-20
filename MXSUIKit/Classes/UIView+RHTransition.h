//
//  UIView+RHTransition.h
//  RHBaseModule
//
//  Created by zero on 2018/7/9.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! Common transition types. */
typedef NS_ENUM(NSUInteger, RHViewTransitionType) {
    /*! 淡入淡出 */
    RHViewTransitionTypeFade = 0,
    /*! 推挤 */
    RHViewTransitionTypePush,
    /*! 揭开 */
    RHViewTransitionTypeReveal,
    /*! 覆盖 */
    RHViewTransitionTypeMoveIn,
    /*! 立方体 */
    RHViewTransitionTypeCube,
    /*! 吮吸 */
    RHViewTransitionTypeSuckEffect,
    /*! 翻转 */
    RHViewTransitionTypeOglFlip,
    /*! 波纹 */
    RHViewTransitionTypeRippleEffect,
    /*! 翻页 */
    RHViewTransitionTypePageCurl,
    /*! 反翻页 */
    RHViewTransitionTypePageUnCurl,
    /*! 开镜头 */
    RHViewTransitionTypeCameraIrisHollowOpen,
    /*! 关镜头 */
    RHViewTransitionTypeCameraIrisHollowClose,
    // 下翻页效果
    RHViewTransitionTypeCurlDown,
    // 上翻页效果
    RHViewTransitionTypeCurlUp,
    // 左翻转效果
    RHViewTransitionTypeFlipFromLeft,
    // 右翻转效果
    RHViewTransitionTypeFlipFromRight
};

/*! Common transition subtypes. */
typedef NS_ENUM(NSUInteger, RHViewTransitionSubtype) {
    RHViewTransitionSubtypeFromRight = 0,
    RHViewTransitionSubtypeFromLeft,
    RHViewTransitionSubtypeFromTop,
    RHViewTransitionSubtypeFromBottom
};

/*!  Timing function names.  */
typedef NS_ENUM(NSUInteger, RHViewTransitionTimingFunctionType) {
    /*! 默认 */
    RHViewTransitionTimingFunctionTypeDefault = 0,
    /*! 线性,即匀速 */
    RHViewTransitionTimingFunctionTypeLinear,
    /*! 先慢后快 */
    RHViewTransitionTimingFunctionTypeEaseIn,
    /*! 先快后慢 */
    RHViewTransitionTimingFunctionTypeEaseOut,
    /*! 先慢后快再慢 */
    RHViewTransitionTimingFunctionTypeEaseInEaseOut
};

@interface UIView (RHTransition)

/*!
 *  CATransition动画实现
 *
 *  @param type                转场动画类型【过渡效果】，默认：RHViewTransitionTypeFade
 *  @param subType             转场动画将去的方向，默认：RHViewTransitionSubtypeFromRight
 *  @param duration            转场动画持续时间，默认：0.8f
 *  @param timingFunction      计时函数，从头到尾的流畅度，默认：RHViewTransitionTimingFunctionTypeDefault
 *  @param removedOnCompletion 在动画执行完时是否被移除，默认：YES
 *  @param forView             添加动画（转场动画是添加在层上的动画）
 */
- (void)rh_transitionWithType:(RHViewTransitionType)type
                      subType:(RHViewTransitionSubtype)subType
                     duration:(CFTimeInterval)duration
               timingFunction:(RHViewTransitionTimingFunctionType)timingFunction
          removedOnCompletion:(BOOL)removedOnCompletion
                      forView:(UIView *)forView;

/*!
 *  UIView实现动画
 *
 *  @param duration       转场动画持续时间，默认：0.8f
 *  @param animationCurve 动画曲线，默认：UIViewAnimationCurveEaseInOut
 *  @param transition     动画过渡，默认：UIViewAnimationTransitionNone
 *  @param forView        添加动画（转场动画是添加在层上的动画）
 */
- (void)rh_transitionViewWithDuration:(CFTimeInterval)duration
                       animationCurve:(UIViewAnimationCurve)animationCurve
                           transition:(UIViewAnimationTransition)transition
                              forView:(UIView *)forView;


@end
