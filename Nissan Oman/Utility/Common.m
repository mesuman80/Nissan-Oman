//
//  Common.m
//  Nissan Oman
//
//  Created by Tripta Garg on 08/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "Common.h"

@implementation Common

+(void)addBorderToButton:(UIButton *)button BorderWidth:(float)borderWidth Radius:(float)radius Color:(UIColor *)color
{
    [button.layer setBorderColor:[color CGColor]];
    [button.layer setBorderWidth:borderWidth];
    button.layer.cornerRadius =radius;
    button.clipsToBounds = YES;
}

+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(void)addBorderToUiView:(UIView *)view withBorderWidth:(float)borderWidth cornerRadius:(float)cornerRadius Color:(UIColor *)color {
    [view.layer setBorderColor:color.CGColor];//[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [view.layer setBorderWidth:borderWidth];
    view.layer.cornerRadius = cornerRadius;
    view.clipsToBounds = YES;
}

+(void)addBorderToTextView:(nonnull UITextView *)textView
          withCornerRadius:(float)cornerRadius
               BorderWidth:(float)borderWidth
                     Color:(nonnull UIColor *)color  {
    [textView.layer setBorderColor:[color CGColor]];
    [textView.layer setBorderWidth:borderWidth];
    textView .layer.cornerRadius = cornerRadius;
    textView.clipsToBounds = YES;
    
}

+(void)addBorderToLabel:(UILabel *)label BorderWidth:(float)borderWidth Radius:(float)radius Color:(UIColor *)color
{
    [label.layer setBorderColor:[color CGColor]];
    [label.layer setBorderWidth:borderWidth];
    label.layer.cornerRadius =radius;
    label.clipsToBounds = YES;
}

#pragma mark AlertViewSpecificFunctions
+(UIAlertView *)showAlertWithTitle:(NSString *)title
                          message :(NSString *)message
                       cancelTitle:(NSString *)buttonTitle {
    UIAlertView *alertview =[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil, nil];
    [alertview show];
    return alertview;
}

#pragma colorSpecification
+(UIColor*)colorWithHexString:(NSString*)hex withAlpha:(float)alphaVal
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alphaVal];
}


+(void)addBorderToTable:(nonnull UITableView *)tableView
            BorderWidth:(float)borderWidth
                 Radius:(float)radius Color:(nonnull UIColor *)color {
    [tableView.layer setBorderColor:[color CGColor]];
    [tableView.layer setBorderWidth:borderWidth];
    tableView.layer.cornerRadius =radius;
    tableView.clipsToBounds = YES;
}

+(void)saveCustomObject:(NSObject *)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

+(NSObject *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

@end
