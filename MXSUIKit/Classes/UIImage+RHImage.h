//
//  UIImage+RHImage.h
//  RHBaseModule
//
//  Created by aicai on 2018/7/9.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RHImage)(UIImage *image);

@interface UIImage (RHImage)

#pragma mark - 生成指定颜色图片
/**
 根据给定的颜色异步生成一张图
 
 @param color UIColor
 @param completion 回调
 */
+ (void)rh_asyncGetImageWithColor:(UIColor *)color
                       completion:(RHImage)completion;

/**
 根据给定的颜色异步生成一张图
 
 @param color UIColor
 @param rect 指定大小
 @param completion 回调
 */
+ (void)rh_asyncGetImageWithColor:(UIColor *)color
                             rect:(CGRect)rect
                       completion:(RHImage)completion;

#pragma mark - 合并图片
/**
 合并两个Image

 @param image1
 @param image2
 @param frame1
 @param frame2
 @param size
 @return 指定视图
 */
+ (UIImage *)mergeWithImage1:(UIImage *)image1 image2:(UIImage *)image2 frame1:(CGRect)frame1 frame2:(CGRect)frame2 size:(CGSize)size;


/**
 把一个Image盖在另一个Image上面

 @param image 底层image
 @param mask 上层image
 @return 指定视图
 */
+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)mask;

#pragma mark - 打水印

/**
 *  打水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 */
+ (UIImage *)waterImageWithBg:(UIImage *)bg logo:(UIImage *)logo;

/**
 *  给图片加文字水印
 *
 *  @param str     水印文字
 *  @param strRect 文字所在的位置大小
 *  @param attri   文字的相关属性，自行设置
 *
 *  @return 加完水印文字的图片
 */
- (UIImage*)imageWaterMarkWithString:(NSString*)str rect:(CGRect)strRect attribute:(NSDictionary *)attri;

/**
 给图片加文字水印
 
 @param str 水印文字
 @param point 文字所在的位置
 @param attri 文字的相关属性，自行设置
 @return 加完水印文字的图片
 */
- (UIImage*)imageWaterMarkWithString:(NSString*)str point:(CGPoint)point attribute:(NSDictionary *)attri;

/**
 给图片加文字水印
 
 @param str 水印文字
 @param point 文字所在的位置
 @param attri 文字的相关属性，自行设置
 @return 加完水印文字的图片
 */
- (UIImage *)imageWaterMarkWithAttributedString:(NSAttributedString *)str point:(CGPoint)point;

#pragma mark - 截取指定视图大小的截图
/**
 截取指定视图大小的截图
 
 @param view 指定视图
 */
+ (UIImage *)rh_getImageForView:(UIView *)view;

#pragma mark - 缩放指定比例的图片
/**
 给指定图片绘制指定大小
 
 @param size Size
 @param image 图片
 @param completion 回调
 */
+ (void)rh_asyncDrawImageToSize:(CGSize)size
                          image:(UIImage *)image
                     completion:(RHImage)completion;

#pragma mark - 加载GIF图片
/**
 加载指定名称的GIF图片
 
 @param name 图片名
 @param completion 回调
 */
+ (void)rh_asyncLoadGIFImageForName:(NSString *)name
                         completion:(RHImage)completion;

/**
 从NSData里加载GIF图片
 
 @param data 图片数据
 @param completion 回调
 */
+ (void)rh_asyncLoadGIFImageWithData:(NSData *)data
                          completion:(RHImage)completion;

#pragma mark - 生成二维码
/**
 异步创建一个二维码
 
 @param string 二维码的内容
 @param completion 回调
 */
+ (void)rh_asyncCreateQRCodeImageWithString:(NSString *)string
                                 completion:(RHImage)completion;

/**
 创建一个二维码, 且可以添加中间的Logo图
 
 @param string 二维码内容
 @param logoImage logo图 default size is 150 * 150
 @param completion 回调
 */
+ (void)rh_asyncCreateQRCodeImageWithString:(NSString *)string
                                  logoImage:(UIImage *)logoImage
                                 completion:(RHImage)completion;

#pragma mark - 生成条形码
/**
 创建一个条形码
 
 @param string 条形码内容, 只能输入ASCII字符
 @param completion 回调
 */
+ (void)rh_asyncCreate128BarcodeImageWithString:(NSString *)string
                                     completion:(RHImage)completion;

/**
 创建一个条形码, 并且可以设置条形码与UIImageView两边的间距
 
 @param string 条形码内容, 只能输入ASCII字符
 @param imageSpace 与UIImageView两边的距离
 @param completion 回调
 */
+ (void)rh_asyncCreate128BarcodeImageWithString:(NSString *)string
                                     imageSpace:(CGFloat)imageSpace
                                     completion:(RHImage)completion;

#pragma mark - 获取指定Bundle文件里的图片
/**
 从指定的Bundle包里获取对应的图片
 
 @param bundle 资源包
 @param imageName 图片名
 @return UIImage
 */
+ (UIImage *)rh_getImageWithBundleName:(NSString *)bundle
                             imageName:(NSString *)imageName;

#pragma mark - 图片高斯模糊处理
/**
 输入一张图片, 返回一张带高斯模糊的图片
 
 @param blur 模糊值
 @param image 指定的图片
 @param completion 回调
 */
+ (void)rh_asyncBlurImageWithBlur:(CGFloat)blur
                            image:(UIImage *)image
                       completion:(RHImage)completion;

#pragma mark - 图片圆角处理
/**
 给指定的图片添加圆角效果
 
 @param radius 弧度
 @param image 指定的图片
 @param completion 回调
 */
+ (void)rh_asyncCornerImageWithRadius:(CGFloat)radius
                                image:(UIImage *)image
                           completion:(RHImage)completion;

/**
 给指定的图片增加圆角,边框, 边框的颜色.
 
 @param radius 弧度
 @param image 指定的图片
 @param borderWidth 边框的宽度
 @param borderColor 边框的颜色
 @param completion 回调
 */
+ (void)rh_asyncCornerImageWithRadius:(CGFloat)radius
                                image:(UIImage *)image
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                           completion:(RHImage)completion;

#pragma mark - 图片底色处理
/**
 *  图片底色处理
 *
 *  @param anImage 要处理的图片
 *  @param type    1:黑白 2:变淡 3:曝光 其他:原图
 *
 *  @return 处理好的图片
 */
+ (UIImage *)grayscale:(UIImage *)anImage type:(int)type;

@end
