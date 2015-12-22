//
//  CLSystemAlertController.h
//  CLSystemAlertController
//
//  Created by 李辉 on 15/12/22.
//  Copyright © 2015年 李辉. All rights reserved.
//  https://github.com/changelee82/CLSystemAlertController
//


#import <UIKit/UIKit.h>

/**  点击按钮的Block类型 */
typedef void(^ButtonDidClickBlock)(NSUInteger index);

/**  提示框风格 */
typedef NS_ENUM(NSInteger, SystemAlertStyle) {
    SystemAlertStyleSheet,
    SystemAlertStyleAlert
};


/**  系统自带的提示框 */
@interface CLSystemAlertController : UIViewController

/**
 *  显示提示窗口，兼容iOS8.3以下版本
 *
 *  如果共有n个按钮，则：
 *  cancelButton按钮的序号为 0，
 *  destructiveButton按钮的序号为1，
 *  otherButton按钮的序号从为 2 ～ n-1，
 *  如果cancelButtonTitle或者destructiveButtonTitle为nil，则其他按钮的序号向前补位
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
           clickedButtonBlock:(ButtonDidClickBlock)buttonDidClickBlock;


@end
