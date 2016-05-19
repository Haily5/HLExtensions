//
//  HLAutoViewFile.h
//  AutoSizeView
//
//  Created by 易海 on 16/4/15.
//  Copyright © 2016年 易海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLAutoViewFile : NSObject

+ (NSString *)getFilePath:(NSString *)file;

@end

NSString *timeAgoSinceDate(NSTimeInterval timeInterVal, BOOL numericDates);