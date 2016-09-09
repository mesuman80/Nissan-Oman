//
//  Common.h
//  Nissan Oman
//
//  Created by Tripta Garg on 08/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+(void)addBorderToButton:( UIButton * _Nonnull )button
             BorderWidth:(float)borderWidth
                  Radius:(float)radius
                   Color:(nonnull UIColor *)color;

+(void)addBorderToUiView:(nonnull UIView *)view
         withBorderWidth:(float)borderWidth
            cornerRadius:(float)cornerRadius
                   Color:(nonnull UIColor *)color;

+(void)addBorderToTextView:(nonnull UITextView *)textView
          withCornerRadius:(float)cornerRadius
               BorderWidth:(float)borderWidth
                     Color:(nonnull UIColor *)color ;

+(void)addBorderToLabel:(nonnull UILabel *)label
            BorderWidth:(float)borderWidth
                 Radius:(float)radius Color:(nonnull UIColor *)color;


+(void)addBorderToTable:(nonnull UITableView *)tableView
            BorderWidth:(float)borderWidth
                 Radius:(float)radius Color:(nonnull UIColor *)color;


+(nonnull UIAlertView *)showAlertWithTitle:(nonnull NSString *)title
                                  message :(nonnull NSString *)message
                               cancelTitle:(nonnull NSString *)buttonTitle;

+(nonnull UIColor*)colorWithHexString:(nonnull NSString*)hex
                            withAlpha:(float)alphaVal;

+(void)saveCustomObject:(nonnull NSObject *)object key:(nonnull NSString *)key ;

+(nonnull NSObject *)loadCustomObjectWithKey:(nonnull NSString *)key;

    
@end
