//
//  HLDataModelManager.h
//  AutoSizeView
//
//  Created by 易海 on 16/4/18.
//  Copyright © 2016年 易海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLDataModel.h"

@interface HLDataModelManager : NSObject

+ (HLDataModelManager *)shareDataModelManager;

/**
 *  @brief 增加或更新数据
 *
 *  @param key  key值为dataconfig的filename
 *  @param data 数据源
 *
 *  @return 是否成功
 */
- (BOOL)addOrUpdateDataModel:(NSString *)key data:(id)data;

/**
 *  @brief 更新单条数据
 *
 *  @param keyPath 数据路径 dataName.key1.key2[index].key3.key4[index]
 *  @param value   更新数据值
 *
 *  @return 是否成功
 */
- (BOOL)updateDataModel:(NSString *)keyPath value:(id)value;

/**
 *  @brief 获取数据
 *
 *  @param keyPath 数据路径
 *  @param block   回调
 */
- (void)getData:(NSString *)keyPath  compare:(DataModelBlock) block ;

/**
 *  直接获取数据
 *
 *  @param keyPath 数据路径
 *
 *  @return 数据值
 */
- (id)getData:(NSString *)keyPath;

/**
 *  @brief 移除model
 *
 *  @param key 要移除的model
 *
 *  @return 是否成功
 */
- (BOOL)removeModelWithKeyPath:(NSString *)keyPath;

/**
 *  某个数据是否存在
 *
 *  @param keyPath 数据路径
 *
 *  @return 是否存在
 */
- (BOOL)hasData:(NSString *)keyPath;

/**
 *  某个数据是否存在,如果不存在则添加默认值
 *
 *  @param keyPath 数据路径
 *  @param value 默认值
 *
 *  @return 是否存在
 */
- (BOOL)hasData:(NSString *)keyPath andDefault:(id)value;


#pragma mark -
#pragma mark - save or read

/**
 *  @brief 保存数据
 */
- (void)save;

/**
 *  @brief 读取数据
 */
- (void)read;

@end
