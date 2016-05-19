//
//  HLAutoViewUntil.h
//  AutoSizeView
//
//  Created by 易海 on 16/4/1.
//  Copyright © 2016年 易海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLAutoViewUntil : NSObject

//字符串与rect转换， 字符串格式为{x, y},{w, h}
+ (NSString *)rectToString:(CGRect)_r;
+ (CGRect)stringToRect:(NSString *)_s;

//字符串与point转换,字符串格式为x,y
+ (NSString *)piontToString:(CGPoint)_p;
+ (CGPoint)stringToPoint:(NSString *)_s;

//字符串与size转换,字符串格式为w,h
+ (NSString *)sizeToString:(CGSize)_z;
+ (CGSize)stringToSize:(NSString *)_s;

//16进制颜色字符串转换为UIColor，字符串格式为#FFFFFFFF 八位
+ (UIColor *) colorWithHexString: (NSString *)color;

//字体自动缩小,使用3x图值+ 2
+ (CGFloat) autoFontSize:(CGFloat)fontSize;
@end
