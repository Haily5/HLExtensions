//
//  HLRunTimeMachine.m
//  ycxmj
//
//  Created by 易海 on 16/5/5.
//  Copyright © 2016年 ycx.net. All rights reserved.
//

#import "HLRunTimeMachine.h"
#import "Aspects.h"
#import "UIViewController+Extensions.h"

@implementation HLRunTimeMachine

+ (void)load
{
    [self startListenFunc];
}

+ (void)startListenFunc
{
    [self listenViewWillAppear];
}

+ (void)listenViewWillAppear
{
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated)
     {
         if ([aspectInfo.instance respondsToSelector:@selector(descriptionName)]) {
             id <UIViewControllerDescription> viewCtrl = aspectInfo.instance;
             NSString *ctrlName = [viewCtrl descriptionName];
             NSLog(@"enter view named %@",ctrlName);
//             [TalkingData trackPageBegin:ctrlName];
         }
     }error:NULL];
}

+ (void)listenViewWillDisAppear
{
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo> aspectInfo, BOOL animated)
     {
         if ([aspectInfo.instance respondsToSelector:@selector(descriptionName)]) {
             id <UIViewControllerDescription> viewCtrl = aspectInfo.instance;
             NSString *ctrlName = [viewCtrl descriptionName];
             NSLog(@"leave view named %@",ctrlName);
//             [TalkingData trackPageEnd:ctrlName];
         }
     }error:NULL];
}

@end
