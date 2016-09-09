//
//  UserData.m
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "UserData.h"

static UserData *userData;


@implementation UserData
{
    BOOL isDefaultImage;
}
@synthesize userId;
@synthesize userName;
@synthesize firstName;
@synthesize lastName;
@synthesize userNumber;
@synthesize userNumberWithCountryCode;
@synthesize countryCode;
@synthesize password;
@synthesize token;
@synthesize deviceType;
@synthesize deviceToken;
@synthesize latitude;
@synthesize longitude;
@synthesize image;
@synthesize timeZone;
@synthesize verificationCode;
@synthesize createdOn;
@synthesize modifiedOn;

@synthesize isVerifiedPhoneNumber;
@synthesize isActive;


-(id)init{
    if(self=[super init]){
        return self;
    }
    return nil;
}


+ (id)sharedData {
    if(!userData)
    {
        userData=[[UserData alloc]init];
    }
    return userData;
}

-(id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init])
    {
        userId                      = [decoder decodeObjectForKey: U_UserID]                   ;
        userName                    = [decoder decodeObjectForKey: U_UserName]                 ;
        firstName                   = [decoder decodeObjectForKey: U_FirstName]                ;
        lastName                    = [decoder decodeObjectForKey: U_LastName]                 ;
        userNumber                  = [decoder decodeObjectForKey: U_PhoneNumber]              ;
        userNumberWithCountryCode   = [decoder decodeObjectForKey: U_PhoneNumberWithCC]        ;
        countryCode                 = [decoder decodeObjectForKey: U_CountryCode]              ;
        password                    = [decoder decodeObjectForKey: U_Password]                 ;
        token                       = [decoder decodeObjectForKey: U_Token]                    ;
        deviceToken                 = [decoder decodeObjectForKey: U_DeviceToken]              ;
        latitude                    = [decoder decodeObjectForKey: U_Latitude]                 ;
        longitude                   = [decoder decodeObjectForKey: U_Longitude]                ;
        timeZone                    = [decoder decodeObjectForKey: U_TimeZone]                 ;
        verificationCode            = [decoder decodeObjectForKey: U_VerificationCode]         ;
        createdOn                   = [decoder decodeObjectForKey: U_CreatedOn]                ;
        modifiedOn                  = [decoder decodeObjectForKey: U_ModifiedOn]               ;
        isVerifiedPhoneNumber       = [decoder decodeBoolForKey: U_IsVerifiedPhoneNumber]    ;
        isActive                    = [decoder decodeBoolForKey: U_IsActive]                 ;
        
        deviceType = kIphoneDeviceType;
        
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject   :userId                     forKey: U_UserID]                   ;
    [encoder encodeObject   :userName                   forKey: U_UserName]                 ;
    [encoder encodeObject   :firstName                  forKey: U_FirstName]                ;
    [encoder encodeObject   :lastName                   forKey: U_LastName]                 ;
    [encoder encodeObject   :userNumber                 forKey: U_PhoneNumber]              ;
    [encoder encodeObject   :userNumberWithCountryCode  forKey: U_PhoneNumberWithCC]        ;
    [encoder encodeObject   :countryCode                forKey: U_CountryCode]              ;
    [encoder encodeObject   :password                   forKey: U_Password]                 ;
    [encoder encodeObject   :token                      forKey: U_Token]                    ;
    [encoder encodeObject   :deviceToken                forKey: U_DeviceToken]              ;
    [encoder encodeObject   :latitude                   forKey: U_Latitude]                 ;
    [encoder encodeObject   :longitude                  forKey: U_Longitude]                ;
    [encoder encodeObject   :timeZone                   forKey: U_TimeZone]                 ;
    [encoder encodeObject   :verificationCode           forKey: U_VerificationCode]         ;
    [encoder encodeObject   :createdOn                  forKey: U_CreatedOn]                ;
    [encoder encodeObject   :modifiedOn                 forKey: U_ModifiedOn]               ;
    [encoder encodeBool     :isVerifiedPhoneNumber      forKey: U_IsVerifiedPhoneNumber]    ;
    [encoder encodeBool     :isActive                   forKey: U_IsActive]                 ;
    
}



@end
