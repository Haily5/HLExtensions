//
//  NSData+HLUntil.m
//  AutoSizeView
//
//  Created by 易海 on 16/4/14.
//  Copyright © 2016年 易海. All rights reserved.
//

#import "NSData+HLUntil.h"
#include <string>
#include <stdlib.h>

typedef enum {
    KeyTypeStrStart = 1 << 0,
    KeyTypeStrEnd   = 1 << 1,
    KeyTypeNumStart = 1 << 2,
    KeyTypeNumEnd   = 1 << 3
}KeyTypeStatus;

@implementation NSString (hlUntil)
- (BOOL)isURLString
{
    return [self hasPrefix:@"http"];
}

- (NSArray *)keyPathValue
{
    //model.submodel.key[0]
    NSMutableArray *array = [NSMutableArray array];
    
    const char *cstring = self.UTF8String;
    
    KeyTypeStatus status = KeyTypeStrStart;
    std::string str_buf = "";
    uint index_buf = 0;
    
    for (uint i = 0; i < self.length; i ++) {
        char buf = cstring[i];
        if ('[' == buf && KeyTypeNumStart   != status) {
            if (str_buf.length() > 0) [array addObject:[NSString stringWithUTF8String:str_buf.c_str()]];
            str_buf = "";
            status = KeyTypeNumStart;
            continue;
        }
        if (']' == buf && KeyTypeNumEnd     != status) status = KeyTypeNumEnd;
        if ('.' == buf && KeyTypeStrEnd     != status) status = KeyTypeStrEnd;
        if (self.length - 1 == i && KeyTypeStrStart == status)
        {
            str_buf += buf;
            status = KeyTypeStrEnd;
        }
        switch (status) {
            case KeyTypeStrStart:
                str_buf += buf;
                break;
            case KeyTypeStrEnd:
            {
                if (str_buf.length() > 0) [array addObject:[NSString stringWithUTF8String:str_buf.c_str()]];
                str_buf = "";
                status = KeyTypeStrStart;
            }
                break;
            case KeyTypeNumStart:
                index_buf = index_buf * 10 + atoi(&buf);
                break;
            case KeyTypeNumEnd:
            {
                [array addObject:[NSNumber numberWithInt:index_buf]];
                index_buf = 0;
                status = KeyTypeStrStart;
            }
                break;
            default:
                break;
        }
    }
    
    return array.copy;
}

- (id)objectFromJSONString
{
    return [self dataUsingEncoding:NSUTF8StringEncoding].objectFromJSONData;
}
- (NSData *)JSONData
{
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}

- (NSString *)JSONString
{
    return [[NSString alloc] initWithData:[self JSONData] encoding:NSUTF8StringEncoding];
}
@end

@implementation NSNumber (hlKeyPath)

- (NSArray *)keyPathValue
{
    return @[self];
}

@end

@implementation NSDictionary (hlKeyPath)

- (NSMutableDictionary *)mutableDeepCopy
{
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] init];
    NSArray *keys = [self allKeys];
    for (id key in keys) {
        id oldData = [self valueForKey:key];
        id newData = nil;
        
        if ([oldData respondsToSelector:@selector(mutableDeepCopy)]) {
            newData = [oldData mutableDeepCopy];
        }else
            newData = [oldData copy];
        [returnDict setValue:newData forKey:key];
    }
    return returnDict;
}

- (id)getObjectFromKeyPaths:(NSArray *)keyPaths
{
    id tmpData = self;
    for (uint i = 0; i < keyPaths.count; i ++) {
        id key = keyPaths[i];
        if ([[key class] isSubclassOfClass:[NSString class]]) {
            //字典
            if (![[tmpData class] isSubclassOfClass:[NSDictionary class]]) return nil;
            NSDictionary *dictTmp = (NSDictionary *)tmpData;
            tmpData = dictTmp[key];
            
        }else if ([[key class] isSubclassOfClass:[NSNumber class]])
        {
            //数组
            if (![[tmpData class] isSubclassOfClass:[NSArray class]]) return nil;
            NSArray *arrTmp = (NSArray *)tmpData;
            if (arrTmp.count == 0) return nil;
            if (arrTmp.count > [key intValue])
                tmpData = arrTmp[[key intValue]];
            else
                return nil;
        }
    }
    return tmpData;
}

- (id)getObjectFromKeyPath:(NSString *)keyPath
{
    NSArray *keyPaths = keyPath.keyPathValue;
    return [self getObjectFromKeyPaths:keyPaths];
}

- (NSData *)JSONData
{
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}

- (NSString *)JSONString
{
    return [[NSString alloc] initWithData:[self JSONData] encoding:NSUTF8StringEncoding];
}
@end

@implementation NSMutableDictionary (hlKeyPath)

- (void)setObject:(id)objct forKeyPaths:(NSArray *)keyPaths
{
    if (keyPaths.count == 1) {
        id key = keyPaths.lastObject;
        if ([objct respondsToSelector:@selector(mutableDeepCopy)]) {
            objct = [objct mutableDeepCopy];
        }
        [self setObject:objct forKey:key];
    }
    else
    {
        id mObj = [self objectForKey:keyPaths[0]];
        if ([mObj respondsToSelector:@selector(setObject:forKeyPaths:)]) {
            [mObj performSelector:@selector(setObject:forKeyPaths:) withObject:objct withObject:[keyPaths subarrayWithRange:(NSRange){1, keyPaths.count - 1}]];
        }
        else
        {
            NSLog(@"%s %d: the keypath: %@ not found!", __func__, __LINE__, mObj);
        }
    }
}

- (void)setObject:(id)objct forKeyPath:(NSString *)keyPath
{
    [self setObject:objct forKeyPaths:keyPath.keyPathValue];
}


- (void)removeObjectForKeyPath:(NSString *)keyPath
{
    [self removeObjectForKeyPaths:keyPath.keyPathValue];
}

- (void)removeObjectForKeyPaths:(NSArray *)keyPaths
{
    if (keyPaths.count == 1)
    {
        id key = keyPaths.lastObject;
        [self removeObjectForKey:key];
    }
    else
    {
        id mObj = [self objectForKey:keyPaths[0]];
        if ([mObj respondsToSelector:@selector(removeObjectForKeyPaths:)])
        {
            [mObj performSelector:@selector(removeObjectForKeyPaths:) withObject:[keyPaths subarrayWithRange:(NSRange){1, keyPaths.count -1}]];
        }
        else
        {
            NSLog(@"%s %d: the keypath: %@ not found!", __func__, __LINE__, mObj);
        }
    }
}

@end

@implementation NSArray (hlKeyPath)

- (NSMutableArray *)mutableDeepCopy
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.count; i ++) {
        id oldData = self[i];
        id newData = nil;
        
        if ([oldData respondsToSelector:@selector(mutableDeepCopy)]) {
            newData = [oldData mutableDeepCopy];
        }else
            newData = [oldData copy];
        [returnArray addObject:newData];
    }
    return returnArray;
    
}


- (id)getObjectFromKeyPaths:(NSArray *)keyPaths
{
    id tmpData = self;
    for (uint i = 0; i < keyPaths.count; i ++) {
        id key = keyPaths[i];
        if ([[key class] isSubclassOfClass:[NSString class]]) {
            //字典
            if (![[tmpData class] isSubclassOfClass:[NSDictionary class]]) return nil;
            NSDictionary *dictTmp = (NSDictionary *)tmpData;
            tmpData = dictTmp[key];
            
        }else if ([[key class] isSubclassOfClass:[NSNumber class]])
        {
            //数组
            if (![[tmpData class] isSubclassOfClass:[NSArray class]]) return nil;
            NSArray *arrTmp = (NSArray *)tmpData;
            tmpData = arrTmp[[key intValue]];
        }
    }
    return tmpData;
}

- (id)getObjectFromKeyPath:(NSString *)keyPath
{
    NSArray *keyPaths = keyPath.keyPathValue;
    return [self getObjectFromKeyPaths:keyPaths];
}

- (NSData *)JSONData
{
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}

- (NSString *)JSONString
{
    return [[NSString alloc] initWithData:[self JSONData] encoding:NSUTF8StringEncoding];
}

- (NSArray *) randomizedArray {
    NSMutableArray *results = [NSMutableArray arrayWithArray:self];
    srand([[NSDate date] timeIntervalSince1970]);
    int i = (int)[results count];
    while(--i > 0) {
        int j = rand() % (i+1);
        [results exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:results];
}

@end

@implementation NSMutableArray (hlKeyPath)

- (void)setObject:(id)objct forKeyPaths:(NSArray *)keyPaths
{
    if (keyPaths.count == 1) {
        id key = keyPaths.lastObject;
        if ([objct respondsToSelector:@selector(mutableDeepCopy)]) {
            objct = [objct mutableDeepCopy];
        }
        if (self.count == [key intValue]) {
            [self addObject:objct];
        }
        else
            [self replaceObjectAtIndex:[key intValue] withObject:objct];
    }
    else
    {
        id mObj = [self objectAtIndex:[keyPaths[0] intValue]];
        if ([mObj respondsToSelector:@selector(setObject:forKeyPaths:)]) {
            [mObj performSelector:@selector(setObject:forKeyPaths:) withObject:objct withObject:[keyPaths subarrayWithRange:(NSRange){1, keyPaths.count - 1}]];
        }
        else
        {
            NSLog(@"setObject:forKeyPaths: the keypath: %@ not found!", mObj);
        }
    }
}

- (void)setObject:(id)objct forKeyPath:(NSString *)keyPath
{
    [self setObject:objct forKeyPaths:keyPath.keyPathValue];
}

- (void)removeObjectForKeyPath:(NSString *)keyPath
{
    [self removeObjectForKeyPaths:keyPath.keyPathValue];
}

- (void)removeObjectForKeyPaths:(NSArray *)keyPaths
{
    if (keyPaths.count == 1)
    {
        id key = keyPaths.lastObject;
        [self removeObjectAtIndex:[key intValue]];
    }
    else
    {
        id mObj = [self objectAtIndex:[keyPaths[0] intValue]];
        if ([mObj respondsToSelector:@selector(removeObjectForKeyPaths:)])
        {
            [mObj performSelector:@selector(removeObjectForKeyPaths:) withObject:[keyPaths subarrayWithRange:(NSRange){1, keyPaths.count -1}]];
        }
        else
        {
            NSLog(@"%s %d: the keypath: %@ not found!", __func__, __LINE__, mObj);
        }
    }
}

@end

@implementation NSData (Json)

- (id)objectFromJSONData
{
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
}

@end