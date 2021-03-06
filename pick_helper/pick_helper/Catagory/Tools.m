//
//  Tools.m
//  RenRenApp
//
//  Created by RichyLeo on 15/8/31.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "Tools.h"
#import "AppDelegate.h"

@implementation Tools

/**
 *  通过文件路径加载图片
 *  该方法加载图片优势：不会将图片加到内存缓存中（适用类型：较大图片的处理）
 *
 *  @param imgName 图片名称（带扩展名）eg：btn_login.png
 *
 *  @return 返回图片对象
 */
+(UIImage *)imageWithName:(NSString *)imgName
{
    if(imgName){
        NSString * path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
        UIImage * image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
    
    return nil;
}

// 创建一个按钮 （以图片展现）
+(UIButton *)createButtonNormalImage:(NSString *)normalImageName selectedImage:(NSString *)selectImageName tag:(NSUInteger)tag addTarget:(id)target action:(SEL)action
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateHighlighted];
    btn.tag = tag;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

// 创建UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame textContent:(NSString *)text withFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = color;
    label.textAlignment = align;
    label.text = text;
    
    return label;
}

+(UIButton *)createNormalButtonWithFrame:(CGRect)frame textContent:(NSString *)text withFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.titleLabel.textAlignment = align;
    return button;
}

+(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIColor *)getColor:(NSString *)hexColor
{
    NSMutableString *color = [[NSMutableString alloc]initWithString:hexColor];
    // 转换成标准16进制数
    [color replaceCharactersInRange:[color rangeOfString:@"#" ] withString:@"0x"];
    // 十六进制字符串转成整形。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B = colorLong & 0x0000FF;
    
    //string转color
    UIColor *wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    return wordColor;
}

+(UITextField*)createTextFieldFrame:(CGRect)frame placeholder:(NSString*)placeholder bgImageName:(NSString*)imageName leftView:(UIView*)leftView rightView:(UIView*)rightView isPassWord:(BOOL)isPassWord
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    if (placeholder) {
        textField.placeholder=placeholder;
    }
    if (imageName) {
        textField.background=[UIImage imageNamed:imageName];
    }
    if (leftView) {
        textField.leftView=leftView;
        textField.leftViewMode=UITextFieldViewModeAlways;
    }
    if (rightView) {
        textField.rightView=rightView;
        textField.rightViewMode=UITextFieldViewModeAlways;
    }
    if (isPassWord) {
        textField.secureTextEntry=YES;
    }
    return textField;
}

+(void)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName View:(UIView *)motherView{
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    [motherView addSubview:imageView];
}

+(void)addSelectorWithObject:(UILabel *)obj target:(id)target selector:(SEL)selector{
    
    obj.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:@selector(selector)];
    [obj addGestureRecognizer:tap];
}

+(NSString *)connectOriginImgStr:(NSString *)originStr width:(NSString *)width height:(NSString *)height{
    
    return [NSString stringWithFormat:@"%@;width=%@;height=%@;equalratio=1",originStr,width,height];
}

+(CGFloat)getTextWidth:(NSString *)text withHeight:(CGFloat)height{
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12*S6]} context:nil].size;
    return size.width;
}

+(void)exit{
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:app.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    app.window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
    }
}

+(void)presentFromWindow:(UIWindow *)window forward:(UIViewController *)vc{
    
    if(window.rootViewController.presentedViewController){
        [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:^{
            [window.rootViewController presentViewController:vc animated:true completion:nil];
        }];
    }else {
        [window.rootViewController presentViewController:vc animated:true completion:nil];
    }
}

@end
