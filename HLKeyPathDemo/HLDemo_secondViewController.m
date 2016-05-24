//
//  HLDemo_secondViewController.m
//  HLKeyPathDemo
//
//  Created by 易海 on 16/5/24.
//  Copyright © 2016年 易海. All rights reserved.
//

#import "HLDemo_secondViewController.h"
#import "HLKeyPath.h"

@interface HLDemo_secondViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation HLDemo_secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) ws = self;
    [[HLDataModelManager shareDataModelManager] getData:self.keyPath compare:^(id data, NSString *keyPath, HLDataModel *model) {
        ws.firstLabel.text = [data objectForKey:@"key"];
        ws.secondLabel.text = [data objectForKey:@"value"];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = textField.text;
    if (0 == string.length && text.length > 0)
    {
        text = [text substringToIndex:text.length - 1];
    }
    else if ([@"\n" isEqualToString:string])
    {
        return NO;
    }
    else
    {
        text = [text stringByAppendingString:string];
    }
    NSString *keyPath = [self.keyPath stringByAppendingString:@".value"];
    [[HLDataModelManager shareDataModelManager]updateDataModel:keyPath value:text];
    return YES;
}

@end
