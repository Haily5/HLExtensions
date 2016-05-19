//
//  HLAutoViewUntil.m
//  AutoSizeView
//
//  Created by 易海 on 16/4/1.
//  Copyright © 2016年 易海. All rights reserved.
//

#import "HLAutoViewUntil.h"

@implementation HLAutoViewUntil

+ (NSString *)rectToString:(CGRect)_r
{
    return [NSString stringWithFormat:@"{%.1f,%.1f},{%.1f,%.1f}",
            _r.origin.x,
                _r.origin.y,
                    _r.size.width,
                        _r.size.height];
}
+ (CGRect)stringToRect:(NSString *)_s
{
    NSArray *_sa = [_s componentsSeparatedByString:@"},{"];
    NSString *_sp = _sa[0];
    NSString *_sr = _sa[1];
    
    _sp = [_sp substringFromIndex:1];
    _sr = [_sr substringToIndex:_sr.length - 1];
    
    NSArray *_spa = [_sp componentsSeparatedByString:@","];
    NSArray *_sra = [_sr componentsSeparatedByString:@","];
    
    return (CGRect)
            {{[_spa[0] floatValue],
                [_spa[1] floatValue]},
            {[_sra[0] floatValue],
                [_sra[1] floatValue]}};
}

+ (NSString *)piontToString:(CGPoint)_p
{
    return [NSString stringWithFormat:@"%.1f, %.1f",_p.x, _p.y];
}
+ (CGPoint)stringToPoint:(NSString *)_s
{
    NSArray *_sp = [_s componentsSeparatedByString:@","];
    
    return (CGPoint)
            {[_sp[0] floatValue],
            [_sp[1] floatValue]};
}

+ (NSString *)sizeToString:(CGSize)_z
{
    return [NSString stringWithFormat:@"%.1f, %.1f",_z.width, _z.height];
}
+ (CGSize)stringToSize:(NSString *)_s
{
    NSArray *_sp = [_s componentsSeparatedByString:@","];
    
    return (CGSize)
        {[_sp[0] floatValue],
        [_sp[1] floatValue]};

}

+ (UIColor *)colorWithHexString:(NSString *)color
{
    if (!color || 0 == color.length) return [UIColor clearColor];
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 8)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    //a
    range.location = 6;
    NSString *aString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) a / 255.0f)];
}

+ (CGFloat) autoFontSize:(CGFloat)fontSize
{
    if (HLWINSIZE.width <= 375) return fontSize;
    return fontSize + 2;
}
@end
