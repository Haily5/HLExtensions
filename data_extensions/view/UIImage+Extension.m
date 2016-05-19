//
//  UIImage+Extension.m
//  ycxmj
//
//  Created by 易海 on 16/5/10.
//  Copyright © 2016年 ycx.net. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (ScaleAndCut)
- (UIImage *)imageByScalingToMaxSize
{
    if (self.size.width < [UIScreen mainScreen].bounds.size.width) return self;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (self.size.width > self.size.height) {
        btHeight = [UIScreen mainScreen].bounds.size.width;
        btWidth = [UIScreen mainScreen].bounds.size.width * ([UIScreen mainScreen].bounds.size.width / self.size.height);
    } else {
        btWidth = [UIScreen mainScreen].bounds.size.width;
        btHeight = self.size.height * ([UIScreen mainScreen].bounds.size.width / self.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
        return newImage;
}

@end
