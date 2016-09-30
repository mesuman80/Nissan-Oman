//
//  Constants.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#ifndef Nissan_Constants_h
#define Nissan_Constants_h

#define screenHeight [[UIScreen mainScreen]bounds].size.height
#define screenWidth  [[UIScreen mainScreen]bounds].size.width

#define titleFont          @"HelveticaNeue-Roman"
#define subTitleFont       @"HelveticaNeue-Light"

//Color Codes
#define buttonRedColor [UIColor colorWithRed:139.0f/255 green:3.0f/255 blue:38.0f/255 alpha:1.0]
#define appGrayColor [UIColor colorWithRed:66.0f/255 green:66.0f/255 blue:66.0f/255 alpha:1.0]

#define mapGeofenceColor [UIColor colorWithRed:250.0f/255 green:220.0f/255 blue:220.0f/255 alpha:1.0]
#define TableTextColor [UIColor colorWithRed:66.0f/255 green:66.0f/255 blue:66.0f/255 alpha:1.0]


//********************************** Nissan Google Map key **************************************************

#define GoogleiOSMapKeyScheme @"AIzaSyBdh5VQWaVZcfE5iKPxh0k8IeMun9-IDHU"

//************************************************** PlaceHolder Strings **************************************************
#define PlaceholderLoginUsernameString      @"USERNAME"
#define PlaceholderLoginPasswordString      @"PASSWORD"
#define PlaceholderSignupFirstNameString    @"FIRST NAME"
#define PlaceholderSignupLastNameString     @"LAST NAME"
#define PlaceholderSignupDobString          @"dd-mm-yyyy"
#define PlaceholderSignupPhoneNumberString  @"  xx-xx-xxxx"
#define PlaceholderSignupEmailString        @"abc@gmail.com"
#define PlaceholderSignupCountryCodeString  @"   +968"
#define PlaceholderLForgetPassword          @"ENTER EMAIL"


#define PlaceholderLSelectCarModel          @"SELECT CAR MODEL"
#define PlaceholderLSelectShowroom          @"SELECT SHOWROOM"
#define PLaceholderEmail                    @"EMAIL"
#define PlaceholderPhone                    @"PHONE"
#define PlaceholderPOBox                    @"P O BOX"
#define PlaceholderPC                       @"PC"
#define PlaceholderSelectBranch             @"SELECT BRANCH"
#define PlaceholderMobileNo                 @"MOBILE NO"
#define PlaceholderName                     @"NAME"
#define PlaceholderLocation                 @"LOCATION"
#define PlaceholderPreferredTestDate        @"PREFERRED TEST DRIVE DATE"




#define IsSettingScreen @"Setting Screen"

//************************************************** Web Page URLs **************************************************


#define LOYALITYPROGRAMURLPAGE @"http://webisdomsolutions.com/nissanweb/loyality-program.php"
#define MAINTENCETIPSURLPAGE @"http://webisdomsolutions.com/nissanweb/maintenance_tips.php"
#define ADVENTUREPARKPAGE @"http://webisdomsolutions.com/nissanweb/adventure.php"
//************************************************** Alerts **************************************************
#define ApplicationInternetConnectionErrorMessage   @"Please check your internet connection."


//************************************************** Networking **************************************************
#define kN_BaseURL                       @"kN_BaseURL"
#define kN_BaseIP                        @"kN_BaseIP"



//************************************************ Registration Key Values **************************************************
#define kN_DeviceToken                     @"DeviceToken"
#define kN_UserData                        @"kN_UserData"
#define kN_isUserMobileRegistered          @"kN_isUserMobileRegistered"
#define kN_isNewNudgeSkiped                @"kN_isNewNudgeSkiped"

//************************************************** User Key Values **************************************************
#define kIphoneDeviceType                 @"0"//For iPhone
#define U_UserID                          @"userId"
#define U_UserName                        @"userName"
#define U_FirstName                       @"firstName"
#define U_LastName                        @"lastName"
#define U_PhoneNumber                     @"phoneNumber"
#define U_IsVerifiedPhoneNumber           @"isVerifiedPhoneNumber"
#define U_Latitude                        @"latitude"
#define U_Longitude                       @"longitude"
#define U_Image                           @"image"
#define U_Token                           @"token"
#define U_VerificationCode                @"verificationCode"
#define U_DeviceType                      @"deviceType"
#define U_DeviceToken                     @"deviceToken"
#define U_TimeZone                        @"timeZone"
#define U_IsActive                        @"isActive"
#define U_CreatedOn                       @"createdOn"
#define U_ModifiedOn                      @"modifiedOn"
#define U_CountryCode                     @"cc"
#define U_PhoneNumberWithCC               @"PhoneNumberWithCC"
#define U_Password                        @"password"


//********************************** Nissan Toll free Number **************************************************


#define TollfreeNumber                     @"80050011"

//********************************** screen factors **************************************************
#define ScreenWidthFactor       [UIScreen mainScreen].bounds.size.width/320
#define ScreenHeightFactor      [UIScreen mainScreen].bounds.size.height/568
#define ScreenFactor            sqrt(pow([UIScreen mainScreen].bounds.size.width/320, 2)+pow([UIScreen mainScreen].bounds.size.height/568, 2))
#define cellPadding             ScreenWidthFactor*12
#define cellPaddingReg          ScreenWidthFactor*15



//********************************** Request form types **************************************************

typedef enum {
    RequestTypeQuote          = 0,
    RequestTypeBrochure       = 1,
    RequestTypeTestDrive      = 2,
    
} RequestType;


#define phoneNumLength          8



#endif


