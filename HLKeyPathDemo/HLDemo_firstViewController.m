//
//  HLDemo_firstViewController.m
//  HLKeyPathDemo
//
//  Created by 易海 on 16/5/24.
//  Copyright © 2016年 易海. All rights reserved.
//

#import "HLDemo_firstViewController.h"
#import "HLKeyPath.h"
#import "HLDemo_secondViewController.h"
//cell

@interface HLDemo_firstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
- (void)regsiterDataKeyPath:(NSString *)keyPath;
@end

@implementation HLDemo_firstCell

- (void)regsiterDataKeyPath:(NSString *)keyPath
{
    __weak typeof(self) ws = self;
    [[HLDataModelManager shareDataModelManager] getData:keyPath compare:^(id data, NSString *keyPath, HLDataModel *model) {
        ws.firstLabel.text = [data objectForKey:@"key"];
        ws.secondLabel.text = [data objectForKey:@"value"];
    }];
}

@end

@interface HLDemo_firstViewController ()

@end

@implementation HLDemo_firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人展示界面";
    if (![[HLDataModelManager shareDataModelManager] hasData:@"data"])
    {
        NSArray *array = @[@{@"key": @"名字", @"value": @"haily"},
                           @{@"key": @"性别", @"value": @"男"},
                           @{@"key": @"年龄", @"value": @"28"}];
        [[HLDataModelManager shareDataModelManager] addOrUpdateDataModel:@"data" data:array];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"nameCell";
    HLDemo_firstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    [cell regsiterDataKeyPath:[NSString stringWithFormat:@"data[%ld]", indexPath.row]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HLDemo_secondViewController *second = [storyboard instantiateViewControllerWithIdentifier:@"second"];
    [self.navigationController pushViewController:second animated:YES];
    second.keyPath = [NSString stringWithFormat:@"data[%ld]", indexPath.row];
}

@end
