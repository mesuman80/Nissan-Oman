//
//  WebService.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseModel.h"

typedef void(^onCompletion)(NSString *error);

@protocol CustomWebServiceDelegate;

@interface WebService : NSObject
//Registration Webservices

@property NSString *serviceName;

-(void)registerUser:(NSDictionary *)dict;
-(void)loginUser:(NSDictionary *)dict;
-(void)getVehicleCategeoryList;
-(void)getVehicleSubCategeoryList:(NSString *)idVal;
-(void)getVehicleDescription:(NSString *)idVal;
-(void)getShowroomAddress;
-(void)getVehicleDropDown;
-(void)requestBrochure:(NSDictionary *)dict;
-(void)requestQuote:(NSDictionary *)dict;
-(void)requestTestDrive:(NSDictionary *)dict;
-(void)getServiceCentre;
-(void)getBodyShop;
-(void)getGenuinePart;
-(void)getCurrentOffers;
-(void)requestAdventurePark:(NSDictionary *)dict;
-(void)requestServiceAppointment:(NSDictionary *)dict;
-(void)requestFeedback:(NSDictionary *)dict;
-(void)forgetPassword:(NSString *)email;
-(void)accountSettings:(NSDictionary *)dict;


@property id<CustomWebServiceDelegate>customWebServiceDelegate;

@end

@protocol CustomWebServiceDelegate <NSObject>

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict;
-(void)ConnectionDidFinishWithError:(NSDictionary *)dict;

@end
