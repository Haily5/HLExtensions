//
//  HLDataModel.m
//  HLKeyPath
//
//  Created by 易海 on 16/4/18.
//  Copyright © 2016年 易海. All rights reserved.
//

#import "HLDataModel.h"
#import "NSData+HLUntil.h"

@interface HLDataModel ()
@property (nonatomic, strong) NSMutableDictionary *blockDict;
@end

@implementation HLDataModel

#pragma mark -
#pragma mark - property
- (NSMutableDictionary *)blockDict
{
    if (!_blockDict) {
        _blockDict = ({
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            dict;
        });
    }
    return _blockDict;
}

#pragma mark -
#pragma mark - function
- (void)addBlock:(DataModelBlock)block withKey:(NSString *)keyPath
{
    NSMutableArray *array = self.blockDict[keyPath];
    if (!array) {
        array = [NSMutableArray array];
        self.blockDict[keyPath] = array;
    }
    if (![array containsObject:block]) {
        [array addObject:block];
    }
}

- (void)removeKey:(NSString *)keyPath withBlock:(DataModelBlock)block
{
    NSMutableArray *array = self.blockDict[keyPath];
    if (array) {
        if (block) {
            if ([array containsObject:block]) [array removeObject:block];
        }
        else
            [self.blockDict removeObjectForKey:keyPath];
    }
}

- (void)sendData:(id)data
{
    for (NSString *keyPath in self.blockDict) {
        NSArray *blocks = self.blockDict[keyPath];
        for (DataModelBlock block in blocks) {
            if (block) {
                id sData = [data getObjectFromKeyPaths:[keyPath.keyPathValue subarrayWithRange:(NSRange){1, keyPath.keyPathValue.count - 1}]];
                block(sData, keyPath, self);
            }
        }
    }
}

@end
