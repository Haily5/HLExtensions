//
//  HLAutoViewDefine.h
//  AutoSizeView
//
//  Created by 易海 on 16/4/1.
//  Copyright © 2016年 易海. All rights reserved.
//

#ifndef HLAutoViewDefine_h
#define HLAutoViewDefine_h

#import "HLAutoViewUntil.h"
#import "UIView+HLUntil.h"
#import "NSData+HLUntil.h"
#import "HLAutoViewFile.h"
#import "HLDataModelManager.h"
#import "UIViewController+Extensions.h"
#import "UIImage+Extension.h"


#define HLWINSIZE [UIScreen mainScreen].bounds.size

#define rectToString(arg)   [HLAutoViewUntil rectToString:arg]
#define stringToRect(arg)   [HLAutoViewUntil stringToRect:arg]
#define piontToString(arg)  [HLAutoViewUntil piontToString:arg]
#define stringToPoint(arg)  [HLAutoViewUntil stringToPoint:arg]
#define sizeToString(arg)   [HLAutoViewUntil sizeToString:arg]
#define stringToSize(arg)   [HLAutoViewUntil stringToSize:arg]
#define noEmptyString(arg)  arg && arg.length > 0

#define hly_scaleW(arg, base) arg * (HLWINSIZE.width / base)
#define hly_scaleH(arg, base) arg * (HLWINSIZE.height / base)

#define colorWithHexString(arg)    [HLAutoViewUntil colorWithHexString:arg]
#define hly_autoFontSize(arg)      [HLAutoViewUntil autoFontSize:arg]

#define d_CachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
#define d_Document  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

#define realyValue(key, data) \
    data[key] ? [data[key] intValue] : -1

#define hlp(x, y) \
        (CGPoint){x, y}

#define hls(w, h) \
        (CGSize){w, h}

#define rgb(r, g, b) \
        [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1]

#define rgba(r, g, b, a) \
        [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) a / 255.0f)]

#endif /* HLAutoViewDefine_h */
