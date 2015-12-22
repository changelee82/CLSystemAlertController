//
//  CLSystemAlertController.m
//  CLSystemAlertController
//
//  Created by 李辉 on 15/12/22.
//  Copyright © 2015年 李辉. All rights reserved.
//  https://github.com/changelee82/CLSystemAlertController
//

#import "CLSystemAlertController.h"


@interface CLSystemAlertController () <UIAlertViewDelegate, UIActionSheetDelegate>

/**  点击按钮后的回调block */
@property (nonatomic,copy) ButtonDidClickBlock buttonDidClickBlock;

@end



@implementation CLSystemAlertController

/**
 *  显示提示窗口
 *
 *  @param viewController         父控制器
 *  @param alertStyle             提示框风格
 *  @param title                  标题，只对Alert风格的提示框有效
 *  @param message                需要显示的信息，只对Alert风格的提示框有效
 *  @param cancelButtonTitle      取消按钮文字
 *  @param destructiveButtonTitle 重要按钮文字
 *  @param otherButtonTitles      其他按钮文字
 *  @param buttonDidClickBlock    点击按钮的Block
 */
+ (void)ShowAlertToController:(UIViewController *)viewController
         alertControllerStyle:(SystemAlertStyle)alertStyle
                        title:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray  *)otherButtonTitles
           clickedButtonBlock:(ButtonDidClickBlock)buttonDidClickBlock
{
    // 创建对象
    CLSystemAlertController *alertController=[[CLSystemAlertController alloc] init];
    
    // 加入子控制器，保住自己的命
    [viewController addChildViewController:alertController];
    
    // 记录block
    alertController.buttonDidClickBlock = buttonDidClickBlock;
    
    // 根据不同的style创建视图
    [alertController  ShowAlertWithStyle:alertStyle
                                         title:title
                                       message:message
                             cancelButtonTitle:cancelButtonTitle
                        destructiveButtonTitle:destructiveButtonTitle
                             otherButtonTitles:otherButtonTitles];
}


- (void)ShowAlertWithStyle:(SystemAlertStyle)alertStyle
                     title:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
    destructiveButtonTitle:(NSString *)destructiveButtonTitle
         otherButtonTitles:(NSArray  *)otherButtonTitles
{
    __weak __typeof(self)weakSelf = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3)
    {
        // iOS8.0以上用UIAlertController创建警告框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:(UIAlertControllerStyle)alertStyle];
        // 设置序号
        NSUInteger buttonIndex = 0;
        
        // 添加取消按钮
        if (cancelButtonTitle != nil)
        {
            UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:^(UIAlertAction *action){
                                                                      if(weakSelf.buttonDidClickBlock != nil)
                                                                          weakSelf.buttonDidClickBlock(buttonIndex);
                                                                      // 释放自己
                                                                      [weakSelf removeFromParentViewController];
                                                                  }];
            [alertController addAction:cancelAction];
            buttonIndex++;
        }
        
        // 添加红色按钮
        if (destructiveButtonTitle != nil)
        {
            UIAlertAction *destructive  = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                                   style:UIAlertActionStyleDestructive
                                                                 handler:^(UIAlertAction *action){
                                                                     if(weakSelf.buttonDidClickBlock != nil)
                                                                         weakSelf.buttonDidClickBlock(buttonIndex);
                                                                     // 释放自己
                                                                     [weakSelf removeFromParentViewController];
                                                                 }];
            [alertController addAction:destructive];
            buttonIndex++;
        }
        
        // 添加其他标题
        if(otherButtonTitles != nil && otherButtonTitles.count != 0)
        {
            for (NSString *otherButtonTitle in otherButtonTitles)
            {
                UIAlertAction *defaultAction  = [UIAlertAction actionWithTitle:otherButtonTitle
                                                                         style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction *action){
                                                                           if(weakSelf.buttonDidClickBlock != nil)
                                                                               weakSelf.buttonDidClickBlock(buttonIndex);
                                                                           // 释放自己
                                                                           [weakSelf removeFromParentViewController];
                                                                       }];
                [alertController addAction:defaultAction];
                buttonIndex++;
            }
        }
        
        // 异步显示
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.parentViewController presentViewController:alertController animated:YES completion:nil];
        });
    }
    else
    {
        if (alertStyle == SystemAlertStyleAlert)
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:nil, nil];
            // 添加cancelButton
            if (cancelButtonTitle != nil)
            {
                [alertView addButtonWithTitle:cancelButtonTitle];
                alertView.cancelButtonIndex = 0;
            }
            
            // 添加destructiveButton
            if (destructiveButtonTitle != nil)
                [alertView addButtonWithTitle:destructiveButtonTitle];
            
            // 添加其他标题
            if (otherButtonTitles != nil && otherButtonTitles.count != 0)
            {
                for (NSString *otherButtonTitle in otherButtonTitles)
                {
                    [alertView addButtonWithTitle:otherButtonTitle];
                }
            }
            
            // 异步显示
            dispatch_async(dispatch_get_main_queue(), ^{
                [alertView show];
            });
        }
        else if (alertStyle == SystemAlertStyleSheet)
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                                     delegate:self
                                                            cancelButtonTitle:nil
                                                       destructiveButtonTitle:destructiveButtonTitle
                                                            otherButtonTitles:nil];
            // 提示框风格
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            
            // 添加cancelButton
            if (cancelButtonTitle != nil)
            {
                [actionSheet addButtonWithTitle:cancelButtonTitle];
                actionSheet.cancelButtonIndex = 0;
            }
            
            // 添加destructiveButton
            if (destructiveButtonTitle != nil)
                actionSheet.destructiveButtonIndex = 1;
            
            // 添加其他按钮
            if(otherButtonTitles != nil && otherButtonTitles.count != 0)
            {
                for (NSString *otherButtonTitle in otherButtonTitles)
                {
                    [actionSheet addButtonWithTitle:otherButtonTitle];
                }
            }
            
            // 异步显示
            dispatch_async(dispatch_get_main_queue(), ^{
                [actionSheet showInView:self.parentViewController.view];
            });
        }
    }
}

// iOS8以下，使用UIAlertView按钮事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(_buttonDidClickBlock != nil)
        {
            _buttonDidClickBlock(buttonIndex);
        }
        
        // 释放自己
        [weakSelf removeFromParentViewController];
    });
}

// iOS8以下，使用UIActionSheet按钮事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(_buttonDidClickBlock != nil)
        {
            _buttonDidClickBlock(buttonIndex);
        }
        
        // 释放自己
        [weakSelf removeFromParentViewController];
    });
}

@end
