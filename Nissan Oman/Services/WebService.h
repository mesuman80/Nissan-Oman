//
//  WebService.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseModel.h"

typedef void(^onCompletion)(NSString *error, ResponseModel *responseModel);

@protocol CustomWebServiceDelegate;

@interface WebService : NSObject
//Registration Webservices
-(void)registerMobileNumberInServer:(NSString*)mobileNumber withCC:(NSString*)countryCode completion:(onCompletion)iCompletion;
-(void)verifyMobileNumberInServer:(NSString*)mobileNumber withVerificationCode:(NSString*)verifyCode completion:(onCompletion)iCompletion;
-(void)resendVerificationCode:(NSString*)mobileNumber completion:(onCompletion)iCompletion;
-(void)registerUser:(NSDictionary *)dict;
-(void)loginUser:(NSDictionary *)dict;

//User Update Webservices
-(void)updateDeviceTokenInSever;

//Category Webservices
-(void)getCategoryListWithCompletion:(onCompletion)iCompletion;
@property id<CustomWebServiceDelegate>customWebServiceDelegate;

@end

@protocol CustomWebServiceDelegate <NSObject>

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict;
-(void)ConnectionDidFinishWithError:(NSDictionary *)dict;

@end
