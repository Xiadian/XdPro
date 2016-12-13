//
//  SZRFunction.m
//  yingke
//
//  Created by SZR on 16/3/17.
//  Copyright © 2016年 VDchina. All rights reserved.
//

#import "SZRFunction.h"
#define iOS8 [[UIDevice currentDevice].systemVersion doubleValue] >= 8.0
@interface SZRFunction()<UIAlertViewDelegate>
@end
@implementation SZRFunction
//构建富文本
+(NSMutableAttributedString *)SZRCreateAttriStrWithStr:(NSString *)str
                                            withSubStr:(NSString *)subStr
                                             withColor:(UIColor *)color
                                              withFont:(UIFont *)font{
    NSRange range = [str rangeOfString:subStr];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc]initWithString:str];
    if (color) {
        [attriStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (font) {
        [attriStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attriStr;
}

//创建button
+(UIButton *)createButtonWithFrame:(CGRect)frame
                         withTitle:(NSString *)title
                      withImageStr:(NSString *)imageStr
                  withBackImageStr:(NSString *)backImageStr{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    if (imageStr != nil) {
        [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];

    }
    if (backImageStr !=nil) {
        [btn setBackgroundImage:[UIImage imageNamed:backImageStr] forState:UIControlStateNormal];
    }
    
    return btn;
}

//创建label
+(UILabel *)createLabelWithFrame:(CGRect)frame color:(UIColor *)color font:(UIFont *)font text:(NSString* )text{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = color;
    label.font = font;
    label.text = text;
    return label;
}

//文本框大小及占位符
+(UITextField *)VDCreateTextFieldFrame:(CGRect)frame color:(UIColor *)color   font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    if (!color) {
        textField.textColor = color;
    }

    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;

    return textField;
}

+ (void)createAlertViewTextTitle:(NSString *)title withTextMessage:(NSString *)message WithButtonMessages:(NSArray *)ButtonMessages Action:(actionBlock)actionBlock viewVC:(UIViewController *)viewVC
{
    SZRFunction* alertView = [[self alloc] init];
    [alertView createAlertViewTextTitle:title withTextMessage:message WithButtonMessages:ButtonMessages Action:actionBlock viewVC:viewVC];
}

// UIAlertController的封装方法
- (void)createAlertViewTextTitle:(NSString *)title withTextMessage:(NSString *)message WithButtonMessages:(NSArray *)ButtonMessages Action:(actionBlock)actionBlock viewVC:(UIViewController *)viewVC
{
    if (iOS8) {
        UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        int indexPath = 0;
        for (NSString* VDStr in ButtonMessages) {
            [alertVC addAction:[UIAlertAction actionWithTitle:VDStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (actionBlock) {
                    actionBlock(indexPath);
                }
            }]];
            indexPath ++;
        }
        [viewVC presentViewController:alertVC animated:YES completion:nil];
    }else{
        actionBlock = actionBlock;
        self.messageArray = ButtonMessages;
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    for (int i = 0; i < self.messageArray.count; i++) {
        if (self.actionBlock) {
            self.actionBlock(i);
        }
    }
    
}


+(void)SZRSetLayerImage:(UIView *)view imageStr:(NSString *)imageStr{
    UIImage* image = [UIImage imageNamed:imageStr];
    view.layer.contents = (id)image.CGImage;
}

+(UIColor *)SZRstringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}
//根据颜色设置图片
+(UIImage*) createImageWithColor:(UIColor*) color
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

//文本框中图片大小 名称 颜色
+(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

//创建阴影视图
+(UIView *)SZRCreateShadeView{
    
    UIView * shadeView = [[UIView alloc]initWithFrame:SZRScreenBounds];
    shadeView.backgroundColor = [UIColor blackColor];
    shadeView.alpha = 0.4;
    return shadeView;
}


#pragma mark 时间戳  时间戳>当前时间
+(NSString *)SZR_TimeWithStr:(NSString *)timeStr{
    NSTimeInterval late = [timeStr integerValue];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1000;
//    NSLog(@"****当前时间戳%lf",now);
    NSString *timeString=@"";
    
    //NSTimeInterval cha=now-late;
    NSTimeInterval cha = (late - now)/1000;
    
//    NSLog(@"----时间戳差值%lf",cha);
    
    if (cha <= 0) {
        timeString = @"已停止";
    }
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天", timeString];
        
    }
    return timeString;
}


//随机生成固定位数的数
+(NSString *)randomKey{
    NSString *alphabet = @"1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSUInteger numberOfCharacters = [alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];

    
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        NSUInteger j = (arc4random_uniform((float)numberOfCharacters - i) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    
    NSString *result = [NSString stringWithCharacters:characters length:24];
    free(characters);
    return result;
}


#pragma mark  字典 json数据互转
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+(BOOL)VD_CheckPhoneNum:(NSString *)phoneNum{
    NSString * pattern = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate * pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:phoneNum];
}

+(BOOL)VD_CheckVerifyCode:(NSString *)verifyCode{
    NSString * pattern = @"^\\d{4,6}$";
    NSPredicate * pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:verifyCode];
}
//判断密码是否至少6位
+(BOOL)VD_CheckPassword:(NSString *)password{
    NSString * pattern = @"^[0-9_a-zA-Z]{6,16}$";
    NSPredicate * pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:password];
}
//判断昵称
+(BOOL)VD_CheckNickName:(NSString *)nickName{
    NSString * pattern = @"^[a-zA-Z0-9_u4e00-u9fa5]+$";
    NSPredicate * pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:nickName];
}
//判断QQ号码是否正确
+(BOOL)VD_CheckQQNum:(NSString *)QQNum{
    NSString * pattern = @"^[1-9][0-9]{4,9}$";
    NSPredicate * pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:QQNum];
}
//邮箱正则表达式
+(BOOL)VD_CheckEmail:(NSString *)email{
    
    NSString * pattern = @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
    NSPredicate * pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:email];
}

@end
