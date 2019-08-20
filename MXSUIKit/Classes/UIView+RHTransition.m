//
//  UIView+RHTransition.m
//  RHBaseModule
//
//  Created by zero on 2018/7/9.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import "UIView+RHTransition.h"

@implementation UIView (RHTransition)

#pragma mark - CATransition动画实现
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
                      forView:(UIView *)forView
{
    if (!duration)
    {
        duration = 0.8f;
    }
    /*! 定义个转场动画 */
    CATransition *transition = [CATransition animation];
    
    /*! 转场动画持续时间 */
    transition.duration = duration;
    /*! 转场动画类型【过渡效果】 */
    [self rh_selectTransitionType:type subType:subType timingFunction:timingFunction transition:transition];
    
    /*! 计时函数，从头到尾的流畅度 */
    //    transition.timingFunction = timingFunction;
    /*! 在动画执行完时是否被移除 */
    transition.removedOnCompletion = removedOnCompletion;
    /*! 暂时不知,感觉与Progress一起用的,如果不加,Progress好像没有效果  */
    //    transition.fillMode = fillMode;
    
    //    transition.beginTime = beginTime;
    /*!
     图层的速率。 用于将父时间缩放为本地时间，例如
     *如果rate为2，本地时间的进度是父时间的两倍。
     *默认为1.  */
    //    transition.speed = beginTime;
    /*! 动画停止(在整体动画的百分比).  */
    //    transition.endProgress = beginTime;
    /*! 动画开始(在整体动画的百分比).   */
    //    transition.startProgress = beginTime;
    
    /*! 添加动画（转场动画是添加在层上的动画） */
    [forView.layer addAnimation:transition forKey:nil];
}

#pragma - UIView 实现动画
/*!
 *  UIView 实现动画
 *
 *  @param duration       转场动画持续时间，默认：0.8f
 *  @param animationCurve 动画曲线，默认：UIViewAnimationCurveEaseInOut
 *  @param transition     动画过渡，默认：UIViewAnimationTransitionNone
 *  @param forView        添加动画（转场动画是添加在层上的动画）
 */
- (void)rh_transitionViewWithDuration:(CFTimeInterval)duration
                       animationCurve:(UIViewAnimationCurve)animationCurve
                           transition:(UIViewAnimationTransition)transition
                              forView:(UIView *)forView
{
    if (!duration)
    {
        duration = 0.8f;
    }
    if (!animationCurve)
    {
        animationCurve = UIViewAnimationCurveEaseInOut;
    }
    if (!transition)
    {
        transition = UIViewAnimationTransitionNone;
    }
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:animationCurve];
        [UIView setAnimationTransition:transition forView:forView cache:YES];
    }];
}

- (void)rh_selectTransitionType:(RHViewTransitionType)type
                        subType:(RHViewTransitionSubtype)subType
                 timingFunction:(RHViewTransitionTimingFunctionType)timingFunction
                     transition:(CATransition *)transition
{
    if (!type)
    {
        type = RHViewTransitionTypeFade;
    }
    switch (type) {
        case RHViewTransitionTypeFade:
            transition.type = kCATransitionFade;
            break;
            
        case RHViewTransitionTypePush:
            transition.type = kCATransitionPush;
            break;
            
        case RHViewTransitionTypeReveal:
            transition.type = kCATransitionReveal;
            break;
            
        case RHViewTransitionTypeMoveIn:
            transition.type = kCATransitionMoveIn;
            break;
            
        case RHViewTransitionTypeCube:
            transition.type = @"cube";
            break;
            
        case RHViewTransitionTypeSuckEffect:
            transition.type = @"suckEffect";
            break;
            
        case RHViewTransitionTypeOglFlip:
            transition.type = @"oglFlip";
            break;
            
        case RHViewTransitionTypeRippleEffect:
            transition.type = @"rippleEffect";
            break;
            
        case RHViewTransitionTypePageCurl:
            transition.type = @"pageCurl";
            break;
            
        case RHViewTransitionTypePageUnCurl:
            transition.type = @"pageUnCurl";
            break;
            
        case RHViewTransitionTypeCameraIrisHollowOpen:
            transition.type = @"cameraIrisHollowOpen";
            break;
            
        case RHViewTransitionTypeCameraIrisHollowClose:
            transition.type = @"cameraIrisHollowClose";
            break;
            
        default:
            break;
    }
    
    if (!subType)
    {
        subType = RHViewTransitionSubtypeFromRight;
    }
    switch (subType) {
        case RHViewTransitionSubtypeFromTop:
            transition.subtype = kCATransitionFromTop;
            break;
        case RHViewTransitionSubtypeFromBottom:
            transition.subtype = kCATransitionFromBottom;
            break;
        case RHViewTransitionSubtypeFromLeft:
            transition.subtype = kCATransitionFromLeft;
            break;
        case RHViewTransitionSubtypeFromRight:
            transition.subtype = kCATransitionFromRight;
            break;
            
        default:
            break;
    }
    
    if (!timingFunction)
    {
        timingFunction = RHViewTransitionTimingFunctionTypeDefault;
    }
    switch (timingFunction) {
        case RHViewTransitionTimingFunctionTypeDefault:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            break;
            
        case RHViewTransitionTimingFunctionTypeLinear:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
        case RHViewTransitionTimingFunctionTypeEaseIn:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
        case RHViewTransitionTimingFunctionTypeEaseOut:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case RHViewTransitionTimingFunctionTypeEaseInEaseOut:
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;
            
        default:
            break;
    }
}


@end
