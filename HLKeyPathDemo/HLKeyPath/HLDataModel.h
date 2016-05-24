//
//  HLDataModel.h
//  HLKeyPath
//
//  Created by 易海 on 16/4/18.
//  Copyright © 2016年 易海. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HLDataModel;
/**
 *  @brief DataModelBlock 数据回调函数
 *
 *  @param data  数据
 *  @param model model
 */
typedef void(^DataModelBlock)(id data, NSString *keyPath, HLDataModel *model);

@interface HLDataModel : NSObject

/**
 *  @brief 增加回调，如果已存在，不再增加
 *
 *  @param block DataModelBlock
 */
- (void)addBlock:(DataModelBlock)block withKey:(NSString *)keyPath;

/**
 *  @brief 移除block
 *
 *  @param key   key值
 *  @param block block 如果是nil，则移除全部
 */
- (void)removeKey:(NSString *)keyPath withBlock:(DataModelBlock)block;

/**
 *  @brief 发送数据
 *
 *  @param data data数据
 */
- (void)sendData:(id)data;

@end
