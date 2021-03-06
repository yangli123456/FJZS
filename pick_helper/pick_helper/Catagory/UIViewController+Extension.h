//
//  UIViewController+Extension.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

- (void)pushWebViewWithURL:(NSString *)URL;
-(void)pushToViewControllerWithTransition:(UIViewController *)viewController withDirection:(NSString *)direction type:(BOOL)loginBool;
-(void)popToViewControllerWithDirection:(NSString *)direction type:(BOOL)loginBool;
@end
