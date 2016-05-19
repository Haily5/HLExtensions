//
//  NSData+HLUntil.h
//  AutoSizeView
//
//  Created by 易海 on 16/4/14.
//  Copyright © 2016年 易海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (hlUntil)
/**
 *  @brief 判断是否为URL地址的string
 *
 *  @return boolean
 */
- (BOOL)isURLString;

/**
 *  @brief 转换成keypath为array， self: key1.key2[1].key3 dict使用.分割，array使用[index]标示
 *
 *  @return 带有顺序的key（NSString） index(NSNumber)数组
 */
- (NSArray *)keyPathValue;

/**
 *  @brief 转换为json对象
 *
 *  @return id array or dict
 */
- (id)objectFromJSONString;

- (NSData *)JSONData;

- (NSString *)JSONString;
@end

@interface NSNumber (hlKeyPath)
- (NSArray *)keyPathValue;
@end

@interface NSDictionary (hlKeyPath)

/**
 *  @brief 深拷贝NSDictionary 内部容器全部为mutable
 *
 *  @return NSMutableDictionary
 */
- (NSMutableDictionary *)mutableDeepCopy;

/**
 *  @brief 根据keyPath获得对象
 *
 *  @param keyPath keypath字符, key1.key2[2].key3
 *
 *  @return 数据对象
 */
- (id)getObjectFromKeyPath:(NSString *)keyPath;
- (id)getObjectFromKeyPaths:(NSArray *)keyPaths;

- (NSData *)JSONData;

- (NSString *)JSONString;
@end
@interface NSMutableDictionary (hlKeyPath)

/**
 *  @brief 根据keypath设置object
 *
 *  @param object   要设置的object
 *  @param keyPath keyPath路径  key1.key2[2].key3
 */
- (void)setObject:(id)objct forKeyPath:(NSString *)keyPath;
- (void)setObject:(id)object forKeyPaths:(NSArray *)keyPaths;

/**
 *  @brief 移除keyPath下内容
 *
 *  @param keyPath keyPath路径
 */
- (void)removeObjectForKeyPath:(NSString *)keyPath;
- (void)removeObjectForKeyPaths:(NSArray *)keyPaths;

@end

@interface NSArray (hlKeyPath)

/**
 *  @brief 深拷贝NSArray 内部容器全部为mutable
 *
 *  @return NSMutableArray
 */
- (NSMutableArray *)mutableDeepCopy;

/**
 *  @brief 根据keyPath获得对象
 *
 *  @param keyPath keypath字符, key1.key2[2].key3
 *
 *  @return 数据对象
 */
- (id)getObjectFromKeyPath:(NSString *)keyPath;
- (id)getObjectFromKeyPaths:(NSArray *)keyPaths;

- (NSData *)JSONData;

- (NSString *)JSONString;

- (NSArray *) randomizedArray;
@end

@interface NSMutableArray(hlKeyPath)

/**
 *  @brief 根据keypath设置object
 *
 *  @param object   要设置的object
 *  @param keyPath keyPath路径  key1.key2[2].key3
 */
- (void)setObject:(id)object forKeyPaths:(NSArray *)keyPaths;
- (void)setObject:(id)objct forKeyPath:(NSString *)keyPath;

/**
 *  @brief 移除keyPath下内容
 *
 *  @param keyPath keyPath路径
 */
- (void)removeObjectForKeyPath:(NSString *)keyPath;
- (void)removeObjectForKeyPaths:(NSArray *)keyPaths;
@end

@interface NSData (Json)
- (id)objectFromJSONData;
@end

@interface UIImage (color)
- (UIImage *)imageWithColor:(UIColor *)color;
@end
