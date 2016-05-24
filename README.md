# **HLKeyPath**

###·使用keyPath路径访问数据元素
###·使用keyPath动态更新数据源
###·UI与数据源绑定，数据实时更新UI
######  很简单的就能够维护你的项目的数据结构问题

#### 项目使用ARC内存管理

#使用方法
#### keyPath
`NSString *keyPath = @"key1.key2[0].key3[1][2];"`

这个keyPath等同于访问

`data[@"key1"][@"key2"][0][@"key3"][1][2];`

#### 读取你的默认数据或者新加载数据
`[[HLDataModelManager shareDataModelManager] addOrUpdateDataModel:keyPath data:data];`
#### 监听你需要关心的数据源
`
[[HLDataModelManager shareDataModelManager] getData:keyPath compare:^(id data, NSString 
*keyPath, HLDataModel *model) {
        ...
    }];`                


#### 更新你的数据
`[[HLDataModelManager shareDataModelManager]updateDataModel:keyPath value:data];`
#数据持久化
只是做了转换为json后的data文件

##如果有bug以及建议，请lssues我