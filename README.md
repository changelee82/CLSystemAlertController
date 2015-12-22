# CLSystemAlertController 1.0
显示提示窗口，兼容iOS8.3以下版本

<br />
作者：李辉 <br />
联系方式：6545823@qq.com <br />
编译环境：Xcode 7.2 <br />
运行环境：iOS 9.2 运行正常 <br />
您在使用该控件的过程中，如有任何疑问或建议，请通过邮箱联系我，谢谢！ <br />


使用方法
===============
    __weak __typeof(self) weakSelf = self;
    [CLSystemAlertController ShowAlertToController:self
                              alertControllerStyle:SystemAlertStyleAlert
                                             title:@"这是标题"
                                           message:@"详细信息"
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:@"重点按钮"
                                 otherButtonTitles:@[@"第二", @"第三"]
                                clickedButtonBlock:^(NSUInteger index) {
                                    weakSelf.indexField.text = [NSString stringWithFormat:@"%d", index];
                                }];

历史版本
===============
v1.0 - 2015-12-22 <br />
Added <br />
基础功能完成 <br />
