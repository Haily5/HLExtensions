//
//  HLDataModelManager.m
//  AutoSizeView
//
//  Created by 易海 on 16/4/18.
//  Copyright © 2016年 易海. All rights reserved.
//

#import "HLDataModelManager.h"
#import "HLAutoViewDefine.h"
#import "HLDataModel.h"

#define MDKey @"YcX_P0jkeT"

static HLDataModelManager *instance = nil;
@interface HLDataModelManager ()
@property (nonatomic, retain) NSMutableDictionary *allData;
@property (nonatomic, retain) NSMutableDictionary *dataConfig;
@property (nonatomic, strong) NSMutableDictionary<NSString *, HLDataModel *> *blocksDict;
@end

@implementation HLDataModelManager

#pragma mark -
#pragma mark - property
- (NSMutableDictionary *)allData
{
    if (!_allData) {
        _allData = ({
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            dict;
        });
    }
    return _allData;
}

+ (NSString *)dataPath
{
    return [d_Document stringByAppendingPathComponent:@"data"];
}

- (NSMutableDictionary *)dataConfig
{
    if (!_dataConfig) {
        _dataConfig = ({
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            dict;
        });
    }
    return _dataConfig;
}

- (NSMutableDictionary <NSString *, HLDataModel *> *)blocksDict
{
    if (!_blocksDict) {
        _blocksDict = ({
            NSMutableDictionary <NSString *, HLDataModel *> *dict = [[NSMutableDictionary <NSString *, HLDataModel *> alloc]init];
            dict;
        });
    }
    return _blocksDict;
}

#pragma mark - 
#pragma mark - init

+ (HLDataModelManager *)shareDataModelManager
{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[HLDataModelManager alloc]init];
            [instance read];
        });
    }
    return instance;
}

- (BOOL)addOrUpdateDataModel:(NSString *)key data:(id)data
{
    [self.allData setObject:[data mutableDeepCopy] forKey:key];
    
    [self sendData:self.allData[key] WithKey:key];
    [self save];
    return YES;
}

- (BOOL)updateDataModel:(NSString *)keyPath value:(id)value
{
    if ([self hasData:keyPath andDefault:value])
        [self.allData setObject:value forKeyPath:keyPath];
    [self sendData:self.allData[keyPath.keyPathValue[0]] WithKey:keyPath.keyPathValue[0]];
    [self save];
    return YES;
}

- (void)getData:(NSString *)keyPath  compare:(DataModelBlock) block
{
    HLDataModel *dataModel = self.blocksDict[keyPath.keyPathValue[0]];
    if (!dataModel) {
        dataModel = [HLDataModel new];
        self.blocksDict[keyPath.keyPathValue[0]] = dataModel;
    }
    [dataModel addBlock:block withKey:keyPath];
    
    //判断数据是否存在
    if (self.allData[keyPath.keyPathValue[0]]) {
        [self sendData:self.allData[keyPath.keyPathValue[0]] WithKey:keyPath.keyPathValue[0]];
    }
    
}

- (id)getData:(NSString *)keyPath
{
    return [self.allData getObjectFromKeyPath:keyPath];
}

- (void)sendData:(id)data WithKey:(NSString *)key
{
    HLDataModel *dataModel = self.blocksDict[key];
    if (dataModel) {
        [dataModel sendData:data];
    }
}

- (BOOL)removeModelWithKeyPath:(NSString *)keyPath
{
    id data = self.allData[keyPath.keyPathValue[0]];
    if (!data) return NO;
    [self.allData removeObjectForKeyPath:keyPath];
    HLDataModel *dataModel = self.blocksDict[keyPath.keyPathValue[0]];
    if (dataModel) [dataModel removeKey:keyPath withBlock:nil];
    [self save];
    return YES;
}

- (BOOL)hasData:(NSString *)keyPath
{
    id data = self.allData[keyPath.keyPathValue[0]];
    if (!data) return NO;
    data = [self.allData getObjectFromKeyPath:keyPath];
    if (!data) return NO;
    return YES;
}

- (void)setDefaultValue:(id)value keyPaths:(NSArray *)keyPaths withMainDict:(id)dict
{
    if (1 == keyPaths.count)
    {
        [dict setObject:value forKeyPath:keyPaths.lastObject];
        [self save];
    }
    else
    {
        id key = keyPaths[0];
        id currentObj = [dict getObjectFromKeyPath:key];
        if (nil == currentObj) {
            //当前容器不存在
            id nextKey = keyPaths[1];
            if ([nextKey isKindOfClass:[NSString class]])
            {
                //需要的是字典
                currentObj = [NSMutableDictionary dictionary];
            }
            else if ([nextKey isKindOfClass:[NSNumber class]])
            {
                //需要的是数组
                currentObj = [NSMutableArray array];
            }
            else
            {
                NSLog(@"DATA ERROR:!  the key is not verif!");
                return;
            }
            [dict setObject:currentObj forKeyPath:key];
        }
        [self setDefaultValue:value keyPaths:[keyPaths subarrayWithRange:(NSRange){1, keyPaths.count - 1}] withMainDict:currentObj];
    }
}

- (BOOL)hasData:(NSString *)keyPath andDefault:(id)value
{
    if ([self hasData:keyPath]) return YES;
    [self setDefaultValue:value keyPaths:keyPath.keyPathValue withMainDict:self.allData];
    return NO;
}


#pragma mark - 
#pragma makr - save
- (void)save
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableData *data =  self.allData.JSONData.mutableCopy;
        [data appendData:[NSData dataWithBytes:MDKey length:MDKey.length]];
        
        NSString *base64Encode = [data base64EncodedStringWithOptions:0];
        [base64Encode writeToFile:[HLDataModelManager dataPath] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    });
    
}

#pragma mark - 
#pragma mark - read
- (void)read
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[HLDataModelManager dataPath]]) return;
    
    NSString *bufString = [NSString stringWithContentsOfFile:[HLDataModelManager dataPath] encoding:NSUTF8StringEncoding error:NULL];
    NSData *data =[[NSData alloc] initWithBase64EncodedString:bufString options:0];
    NSUInteger lenth = data.length;
    data = [data subdataWithRange:(NSRange){0, lenth - MDKey.length}];
    NSDictionary *jsonData = data.objectFromJSONData;
    self.allData = jsonData.mutableDeepCopy;
}
@end
