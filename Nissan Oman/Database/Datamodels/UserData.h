//
//  UserData.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserData : NSObject<NSCoding>{
    
}

@property NSString *userId;
@property NSString *userName;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *userNumber;
@property NSString *userNumberWithCountryCode;
@property NSString *countryCode;
@property NSString *password;
@property NSString *token;
@property NSString *deviceType;
@property NSString *deviceToken;
@property NSString *latitude;
@property NSString *longitude;
@property NSString *image;
@property NSString *timeZone;
@property NSString *verificationCode;
@property NSString *createdOn;
@property NSString *modifiedOn;

@property BOOL isVerifiedPhoneNumber;
@property BOOL isActive;

@end
