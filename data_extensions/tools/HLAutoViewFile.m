//
//  HLAutoViewFile.m
//  AutoSizeView
//
//  Created by 易海 on 16/4/15.
//  Copyright © 2016年 易海. All rights reserved.
//

#import "HLAutoViewFile.h"

@implementation HLAutoViewFile
+ (NSString *)getFilePath:(NSString *)file
{
    NSString *str = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
        str = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    }
    else
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"json"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    return str;
}
@end

/**
 根据指定时间算出多久 (如：1年前，1月前……)
 
 - parameter date:         比较时间
 - parameter numericDates: 简单化 (1年前 = 去年)
 
 - returns: 结果字符串
 */
NSString *timeAgoSinceDate(NSTimeInterval timeInterVal, BOOL numericDates)
{
    
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:timeInterVal];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nowDate = [NSDate date];
    NSDate *earDate = [nowDate earlierDate:oldDate];
    
    NSDate *latest = earDate == nowDate ? earDate : oldDate;
    
    NSDateComponents *componets = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:earDate toDate:latest options:NSCalendarWrapComponents];
   
    NSString *str = @"";
    if (componets.year >= 2) {
        [str stringByAppendingFormat:NSLocalizedString(@"%d年前", nil), componets.year];
    }
    else if (componets.year >= 1)
        [str stringByAppendingString:(numericDates ? NSLocalizedString(@"1年前", nil): NSLocalizedString(@"去年",nil))];
    else if (componets.month >= 2)
        [str stringByAppendingFormat:NSLocalizedString(@"%d月前", nil), componets.month];
    else if (componets.month >= 1)
        [str stringByAppendingString:(numericDates ? NSLocalizedString(@"1月前", nil): NSLocalizedString(@"上个月",nil))];
    else if (componets.weekOfYear >= 2)
        [str stringByAppendingFormat:NSLocalizedString(@"%d周前", nil), componets.weekOfYear];
    else if (componets.weekOfYear >= 1)
        [str stringByAppendingString:(numericDates ? NSLocalizedString(@"1周前", nil): NSLocalizedString(@"上周",nil))];
    else if (componets.day >= 2)
        [str stringByAppendingFormat:NSLocalizedString(@"%d天前", nil), componets.day];
    else if (componets.day >= 1)
        [str stringByAppendingString:(numericDates ? NSLocalizedString(@"1天前", nil): NSLocalizedString(@"昨天",nil))];
    else if (componets.hour >= 1)
        [str stringByAppendingFormat:NSLocalizedString(@"%d小时前", nil), componets.hour];
    else if (componets.minute >= 1)
        [str stringByAppendingFormat:NSLocalizedString(@"%d分钟前", nil), componets.minute];
    else if (componets.second >= 30)
        [str stringByAppendingFormat:NSLocalizedString(@"%d秒前", nil), componets.second];
    else
        [str stringByAppendingString:NSLocalizedString(@"刚刚", nil)];
    
    return str;
    
}
