//
//  UIImage+RHImage.m
//  RHBaseModule
//
//  Created by aicai on 2018/7/9.
//  Copyright © 2018年 aicai. All rights reserved.
//

#import "UIImage+RHImage.h"
#import <ImageIO/ImageIO.h>
#import <Accelerate/Accelerate.h>


@implementation UIImage (RHImage)

#pragma mark - 生成指定颜色图片
+ (void)rh_asyncGetImageWithColor:(UIColor *)color
                       completion:(RHImage)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CGRect rh_rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        
        UIGraphicsBeginImageContext(rh_rect.size);
        
        CGContextRef rh_context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(rh_context, color.CGColor);
        
        CGContextFillRect(rh_context, rh_rect);
        
        UIImage *rh_image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        NSData *rh_imageData = UIImageJPEGRepresentation(rh_image, 1.0f);
        
        rh_image = [UIImage imageWithData:rh_imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion != nil) {
                
                completion(rh_image);
            }
        });
    });
}

+ (void)rh_asyncGetImageWithColor:(UIColor *)color
                             rect:(CGRect)rect
                       completion:(RHImage)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef rh_context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(rh_context, color.CGColor);
        
        CGContextFillRect(rh_context, rect);
        
        UIImage *rh_image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        NSData *rh_imageData = UIImageJPEGRepresentation(rh_image, 1.0f);
        
        rh_image = [UIImage imageWithData:rh_imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion != nil) {
                
                completion(rh_image);
            }
        });
    });
}

#pragma mark - 截取指定视图大小的截图
+ (UIImage *)rh_getImageForView:(UIView *)view {
    
    UIImage *__block rh_image = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0);
        
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        rh_image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    });
    
    
    return rh_image;
}

#pragma mark - 缩放指定比例的图片
+ (void)rh_asyncDrawImageToSize:(CGSize)size
                          image:(UIImage *)image
                     completion:(RHImage)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIGraphicsBeginImageContext(size);
        
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        
        UIImage *rh_drawImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                
                completion(rh_drawImage);
            }
        });
    });
}

#pragma mark - 加载GIF图片
+ (void)rh_asyncLoadGIFImageForName:(NSString *)name
                         completion:(RHImage)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CGFloat rh_scale = [UIScreen mainScreen].scale;
        
        if (rh_scale > 1.0f) {
            
            NSString *rh_retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"]
                                                                      ofType:@"gif"];
            
            NSData *rh_data = [NSData dataWithContentsOfFile:rh_retinaPath];
            
            if (completion) {
                
                if (rh_data) {
                    
                    [UIImage rh_asyncLoadGIFImageWithData:rh_data
                                               completion:^(UIImage *image) {
                                                   
                                                   completion(image);
                                               }];
                }
            }
            
            NSString *rh_path = [[NSBundle mainBundle] pathForResource:name
                                                                ofType:@"gif"];
            
            rh_data = [NSData dataWithContentsOfFile:rh_path];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (completion) {
                    
                    if (rh_data) {
                        
                        [UIImage rh_asyncLoadGIFImageWithData:rh_data
                                                   completion:^(UIImage *image) {
                                                       
                                                       completion(image);
                                                   }];
                        
                        return;
                    }
                    
                    completion([UIImage imageNamed:name]);
                }
            });
            
        } else {
            
            NSString *rh_path = [[NSBundle mainBundle] pathForResource:name
                                                                ofType:@"gif"];
            
            NSData *rh_data = [NSData dataWithContentsOfFile:rh_path];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (completion) {
                    
                    if (rh_data) {
                        
                        [UIImage rh_asyncLoadGIFImageWithData:rh_data
                                                   completion:^(UIImage *image) {
                                                       
                                                       completion(image);
                                                   }];
                    }
                    
                    completion([UIImage imageNamed:name]);
                }
            });
        }
    });
}

+ (void)rh_asyncLoadGIFImageWithData:(NSData *)data
                          completion:(RHImage)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (!data) {
            return;
        }
        
        //获取数据源
        CGImageSourceRef rh_source = CGImageSourceCreateWithData((__bridge CFDataRef)data,
                                                                 NULL);
        
        // 获取图片数量(如果传入的是gif图的二进制，那么获取的是图片帧数)
        size_t rh_count = CGImageSourceGetCount(rh_source);
        
        UIImage *rh_animatedImage;
        
        if (rh_count <= 1) {
            rh_animatedImage = [[UIImage alloc] initWithData:data];
            
        } else {
            
            NSMutableArray *rh_images = [NSMutableArray array];
            
            NSTimeInterval rh_duration = 0.0f;
            
            for (size_t i = 0; i < rh_count; i++) {
                
                CGImageRef rh_image = CGImageSourceCreateImageAtIndex(rh_source,
                                                                      i,
                                                                      NULL);
                
                rh_duration += [self rh_frameDurationAtIndex:i
                                                      source:rh_source];
                
                [rh_images addObject:[UIImage imageWithCGImage:rh_image
                                                         scale:[UIScreen mainScreen].scale
                                                   orientation:UIImageOrientationUp]];
                
                CGImageRelease(rh_image);
            }
            
            // 如果上面的计算播放时间方法没有成功，就按照下面方法计算
            // 计算一次播放的总时间：每张图播放1/10秒 * 图片总数
            if (!rh_duration) {
                rh_duration = (1.0f / 10.0f) * rh_count;
            }
            
            rh_animatedImage = [UIImage animatedImageWithImages:rh_images
                                                       duration:rh_duration];
        }
        
        CFRelease(rh_source);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                
                completion(rh_animatedImage);
            }
        });
    });
}

/**
 计算GIF图片播放的时间
 
 @param index 索引
 @param source 图片内容
 @return 计算时间
 */
+ (CGFloat)rh_frameDurationAtIndex:(NSUInteger)index
                            source:(CGImageSourceRef)source {
    
    CGFloat rh_frameDuration = 0.1f;
    
    // 获取这一帧的属性字典
    CFDictionaryRef rh_cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source,
                                                                              index,
                                                                              nil);
    
    NSDictionary *rh_frameProperties = (__bridge NSDictionary *)rh_cfFrameProperties;
    NSDictionary *rh_gifProperties = rh_frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    // 从字典中获取这一帧持续的时间
    NSNumber *rh_delayTimeUnclampedProp = rh_gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    
    if (rh_delayTimeUnclampedProp) {
        
        rh_frameDuration = [rh_delayTimeUnclampedProp floatValue];
        
    } else {
        
        NSNumber *rh_delayTimeProp = rh_gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        
        if (rh_delayTimeProp) {
            
            rh_frameDuration = [rh_delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (rh_frameDuration < 0.011f) {
        
        rh_frameDuration = 0.100f;
    }
    
    CFRelease(rh_cfFrameProperties);
    
    return rh_frameDuration;
}

#pragma mark - 异步生成一个二维码
+ (void)rh_asyncCreateQRCodeImageWithString:(NSString *)string
                                 completion:(RHImage)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CIFilter *rh_QRCodeImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        
        [rh_QRCodeImageFilter setDefaults];
        
        NSData *QRCodeImageData = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        [rh_QRCodeImageFilter setValue:QRCodeImageData
                                forKey:@"inputMessage"];
        [rh_QRCodeImageFilter setValue:@"H"
                                forKey:@"inputCorrectionLevel"];
        
        CIImage *rh_QRCodeCIImage = [rh_QRCodeImageFilter outputImage];
        
        rh_QRCodeCIImage = [rh_QRCodeCIImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
        
        UIImage *rh_QRCodeUIImage = [UIImage imageWithCIImage:rh_QRCodeCIImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion != nil) {
                
                completion(rh_QRCodeUIImage);
            }
        });
    });
}

+ (void)rh_asyncCreateQRCodeImageWithString:(NSString *)string
                                  logoImage:(UIImage *)logoImage
                                 completion:(RHImage)completion {
    
    [self rh_asyncCreateQRCodeImageWithString:string
                                   completion:^(UIImage *image) {
                                       
                                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                           
                                           UIGraphicsBeginImageContext(image.size);
                                           
                                           [image drawInRect:CGRectMake(0,
                                                                        0,
                                                                        image.size.width,
                                                                        image.size.height)];
                                           
                                           CGFloat rh_imageW = 150;
                                           CGFloat rh_imageH = rh_imageW;
                                           CGFloat rh_imageX = (image.size.width - rh_imageW) * 0.5;
                                           CGFloat rh_imgaeY = (image.size.height - rh_imageH) * 0.5;
                                           
                                           [logoImage drawInRect:CGRectMake(rh_imageX, rh_imgaeY, rh_imageW, rh_imageH)];
                                           
                                           UIImage *rh_finalyImage = UIGraphicsGetImageFromCurrentImageContext();
                                           
                                           UIGraphicsEndImageContext();
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               
                                               if (completion) {
                                                   
                                                   completion(rh_finalyImage);
                                               }
                                           });
                                       });
                                   }];
}

#pragma mark - 生成条形码
+ (void)rh_asyncCreate128BarcodeImageWithString:(NSString *)string
                                     completion:(RHImage)completion {
    
    [self rh_asyncCreate128BarcodeImageWithString:string
                                       imageSpace:[self rh_fitScreen:14]
                                       completion:completion];
}

+ (CGFloat)rh_fitScreen:(CGFloat)value {
    return ceilf([[UIScreen mainScreen] bounds].size.width / (750.0f / 2)  * (value / 2.0f));
}

+ (void)rh_asyncCreate128BarcodeImageWithString:(NSString *)string
                                     imageSpace:(CGFloat)imageSpace
                                     completion:(RHImage)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CIFilter *rh_code128Filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
        
        NSData *rh_contentData = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        [rh_code128Filter setValue:rh_contentData
                            forKey:@"inputMessage"];
        [rh_code128Filter setValue:@(imageSpace)
                            forKey:@"inputQuietSpace"];
        
        CIImage *rh_code128Image = rh_code128Filter.outputImage;
        
        rh_code128Image = [rh_code128Image imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
        
        UIImage *rh_code128UIImage = [UIImage imageWithCIImage:rh_code128Image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                
                completion(rh_code128UIImage);
            }
        });
    });
}

#pragma mark - 获取指定Bundle文件里的图片
+ (UIImage *)rh_getImageWithBundleName:(NSString *)bundle
                             imageName:(NSString *)imageName {
    
    NSBundle *rh_mainBundle = [NSBundle bundleForClass:NSClassFromString(bundle)];
    
    NSString *rh_pathString = [rh_mainBundle pathForResource:bundle
                                                      ofType:@"bundle"];
    
    NSBundle *rh_resourcesBundle = [NSBundle bundleWithPath:rh_pathString];
    
    if (!rh_resourcesBundle) {
        
        rh_resourcesBundle = rh_mainBundle;
    }
    
    UIImage *rh_image = [UIImage imageNamed:imageName
                                   inBundle:rh_resourcesBundle
              compatibleWithTraitCollection:nil];
    
    return rh_image;
}

#pragma mark - 图片高斯模糊处理
+ (void)rh_asyncBlurImageWithBlur:(CGFloat)blur
                            image:(UIImage *)image
                       completion:(RHImage)completion {
    
    __block CGFloat rh_blurValue = blur;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *rh_imageData  = UIImageJPEGRepresentation(image, 1); // convert to jpeg
        UIImage *rh_destImage = [UIImage imageWithData:rh_imageData];
        
        if (rh_blurValue < 0.f || rh_blurValue > 1.f) {
            rh_blurValue = 0.5f;
        }
        
        int rh_boxSize = (int)(blur * 40);
        
        rh_boxSize = rh_boxSize - (rh_boxSize % 2) + 1;
        
        CGImageRef rh_imageRef = rh_destImage.CGImage;
        
        vImage_Buffer rh_inBuffer, rh_outBuffer;
        
        vImage_Error rh_error;
        
        void *rh_pixelBuffer;
        
        //create vImage_Buffer with data from CGImageRef
        
        CGDataProviderRef rh_inProvider = CGImageGetDataProvider(rh_imageRef);
        CFDataRef rh_inBitmapData = CGDataProviderCopyData(rh_inProvider);
        
        rh_inBuffer.width    = CGImageGetWidth(rh_imageRef);
        rh_inBuffer.height   = CGImageGetHeight(rh_imageRef);
        rh_inBuffer.rowBytes = CGImageGetBytesPerRow(rh_imageRef);
        rh_inBuffer.data     = (void *)CFDataGetBytePtr(rh_inBitmapData);
        
        //create vImage_Buffer for output
        
        rh_pixelBuffer = malloc(CGImageGetBytesPerRow(rh_imageRef) * CGImageGetHeight(rh_imageRef));
        
        if(rh_pixelBuffer == NULL) {
            
            NSLog(@"No pixelbuffer");
        }
        
        rh_outBuffer.data     = rh_pixelBuffer;
        rh_outBuffer.width    = CGImageGetWidth(rh_imageRef);
        rh_outBuffer.height   = CGImageGetHeight(rh_imageRef);
        rh_outBuffer.rowBytes = CGImageGetBytesPerRow(rh_imageRef);
        
        // Create a third buffer for intermediate processing
        void *rh_pixelBuffer2 = malloc(CGImageGetBytesPerRow(rh_imageRef) * CGImageGetHeight(rh_imageRef));
        
        vImage_Buffer rh_outBuffer2;
        
        rh_outBuffer2.data     = rh_pixelBuffer2;
        rh_outBuffer2.width    = CGImageGetWidth(rh_imageRef);
        rh_outBuffer2.height   = CGImageGetHeight(rh_imageRef);
        rh_outBuffer2.rowBytes = CGImageGetBytesPerRow(rh_imageRef);
        
        //perform convolution
        rh_error = vImageBoxConvolve_ARGB8888(&rh_inBuffer,
                                              &rh_outBuffer2,
                                              NULL,
                                              0,
                                              0,
                                              rh_boxSize,
                                              rh_boxSize,
                                              NULL,
                                              kvImageEdgeExtend);
        
        if (rh_error) {
            NSLog(@"error from convolution %ld", rh_error);
        }
        
        rh_error = vImageBoxConvolve_ARGB8888(&rh_outBuffer2,
                                              &rh_inBuffer,
                                              NULL,
                                              0,
                                              0,
                                              rh_boxSize,
                                              rh_boxSize,
                                              NULL,
                                              kvImageEdgeExtend);
        
        if (rh_error) {
            NSLog(@"error from convolution %ld", rh_error);
        }
        
        rh_error = vImageBoxConvolve_ARGB8888(&rh_inBuffer,
                                              &rh_outBuffer,
                                              NULL,
                                              0,
                                              0,
                                              rh_boxSize,
                                              rh_boxSize,
                                              NULL,
                                              kvImageEdgeExtend);
        
        if (rh_error) {
            NSLog(@"error from convolution %ld", rh_error);
        }
        
        CGColorSpaceRef rh_colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGContextRef rh_ontextRef = CGBitmapContextCreate(rh_outBuffer.data,
                                                          rh_outBuffer.width,
                                                          rh_outBuffer.height,
                                                          8,
                                                          rh_outBuffer.rowBytes,
                                                          rh_colorSpaceRef,
                                                          (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
        
        CGImageRef rh_imageRef2 = CGBitmapContextCreateImage(rh_ontextRef);
        UIImage *rh_image = [UIImage imageWithCGImage:rh_imageRef2];
        
        //clean up
        CGContextRelease(rh_ontextRef);
        CGColorSpaceRelease(rh_colorSpaceRef);
        
        free(rh_pixelBuffer);
        free(rh_pixelBuffer2);
        CFRelease(rh_inBitmapData);
        
        CGImageRelease(rh_imageRef2);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                
                completion(rh_image);
            }
        });
    });
}

#pragma mark - 图片圆角处理
+ (void)rh_asyncCornerImageWithRadius:(CGFloat)radius
                                image:(UIImage *)image
                           completion:(RHImage)completion {
    
    [UIImage rh_asyncCornerImageWithRadius:radius
                                     image:image
                               borderWidth:0
                               borderColor:nil
                                completion:completion];
}

+ (void)rh_asyncCornerImageWithRadius:(CGFloat)radius
                                image:(UIImage *)image
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                           completion:(RHImage)completion {
    
    [UIImage rh_asyncCornerImageWithRadius:radius
                                     image:image
                                   corners:UIRectCornerAllCorners
                               borderWidth:borderWidth
                               borderColor:borderColor
                            borderLineJoin:kCGLineJoinMiter
                                completion:completion];
}

+ (void)rh_asyncCornerImageWithRadius:(CGFloat)radius
                                image:(UIImage *)image
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin
                           completion:(RHImage)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        
        CGContextScaleCTM(context, 1, -1);
        
        CGContextTranslateCTM(context, 0, -rect.size.height);
        
        CGFloat minSize = MIN(image.size.width, image.size.height);
        
        if (borderWidth < minSize / 2) {
            
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth)
                                                       byRoundingCorners:corners
                                                             cornerRadii:CGSizeMake(radius, borderWidth)];
            [path closePath];
            
            CGContextSaveGState(context);
            
            [path addClip];
            
            CGContextDrawImage(context, rect, image.CGImage);
            CGContextRestoreGState(context);
        }
        
        if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
            
            CGFloat strokeInset = (floor(borderWidth * image.scale) + 0.5) / image.scale;
            
            CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
            
            CGFloat strokeRadius = radius > image.scale / 2 ? radius - image.scale / 2 : 0;
            
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect
                                                       byRoundingCorners:corners
                                                             cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
            [path closePath];
            
            path.lineWidth = borderWidth;
            path.lineJoinStyle = borderLineJoin;
            
            [borderColor setStroke];
            
            [path stroke];
        }
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                
                completion(image);
            }
        });
    });
}

@end
