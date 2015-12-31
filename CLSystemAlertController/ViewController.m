//
//  ViewController.m
//  CLSystemAlertController
//
//  Created by 李辉 on 15/12/22.
//  Copyright © 2015年 李辉. All rights reserved.
//

#import "ViewController.h"
#import "CLSystemAlertController.h"

@interface ViewController ()
- (IBAction)sheetButtonClick:(UIButton *)sender;
- (IBAction)alertButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *indexField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sheetButtonClick:(UIButton *)sender {
    __weak __typeof(self) weakSelf = self;
    [CLSystemAlertController showAlertToController:self
                              alertControllerStyle:SystemAlertStyleSheet
                                             title:@"这是标题"
                                           message:@"详细信息"
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:@"重点按钮"
                                 otherButtonTitles:@[@"第二", @"第三"]
                                clickedButtonBlock:^(NSUInteger index) {
                                    weakSelf.indexField.text = [NSString stringWithFormat:@"%d", index];
                                }];
}

- (IBAction)alertButtonClick:(UIButton *)sender {
    __weak __typeof(self) weakSelf = self;
    [CLSystemAlertController showAlertToController:self
                              alertControllerStyle:SystemAlertStyleAlert
                                             title:@"这是标题"
                                           message:@"详细信息"
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:@"重点按钮"
                                 otherButtonTitles:@[@"第二", @"第三"]
                                clickedButtonBlock:^(NSUInteger index) {
                                    weakSelf.indexField.text = [NSString stringWithFormat:@"%d", index];
                                }];
}
@end
