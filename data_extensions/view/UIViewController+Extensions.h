//
//  UIViewController+Extensions.h
//  ycxmj
//
//  Created by 易海 on 16/5/5.
//  Copyright © 2016年 ycx.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIViewControllerDescription <NSObject>

/**
 *  @brief 页面名，统计使用
 *
 *  @return 当前显示controller名字， 只需要实现这个协议即可。
 */
- (NSString *)descriptionName;

@end
