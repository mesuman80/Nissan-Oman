//
//  Constants.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#ifndef Nudger_Constants_h
#define Nudger_Constants_h

//Color Codes
#define gray @"#0B99B8"
#define app_background @"424242"
#define btn_background @"#2196F3"
#define setting_btn_background @"#E0E0E0"
#define white @"ffffff"
#define black @"000000"
#define btn_red @"#8B0326"
#define btn_blue @"#0000ff"
#define performace_line_colour @"#E6E6E7"
#define performace_secondary_text @"#A2A3A4"
#define performace_title @"555657"
#define light_grey @"#eeeeee"
#define back_logo @"#C41732"

#define CANCEL_TIMER 3

#define screenHeight [[UIScreen mainScreen]bounds].size.height
#define screenWidth  [[UIScreen mainScreen]bounds].size.width

#define titleFont          @"HelveticaNeue-Roman"
#define subTitleFont       @"HelveticaNeue-Light"
#define buttonRedColor [UIColor colorWithRed:139.0f/255 green:3.0f/255 blue:38.0f/255 alpha:1.0]
#define appGrayColor [UIColor colorWithRed:66.0f/255 green:66.0f/255 blue:66.0f/255 alpha:1.0]

#define mapGeofenceColor [UIColor colorWithRed:250.0f/255 green:220.0f/255 blue:220.0f/255 alpha:1.0]
#define TableTextColor [UIColor colorWithRed:66.0f/255 green:66.0f/255 blue:66.0f/255 alpha:1.0]

#pragma Map variables
#define kLatitudinalMeters 1000.0 //1km
#define kLongitudinalMeters 1000.0 //1km
#define kRefreshTime 10.0

#define MAXLENGTH 3
#define CRITERIA_CATEGORY 1
#define CRITERIA_LOCATION 2
#define CRITERIA_NUDGE_MESSAGE 3

#define GoogleiOSPlacesKey   @"AIzaSyBb1oJRrBY_O_9qpVs3yjppitudZtSio2M"
#define GoogleiOSMapKeyScheme @"AIzaSyBDavXsSPaDZyfcKS9l6TFYVYm6i8sZ4R8"

//************************************************** PlaceHolder Strings **************************************************
#define PlaceholderLoginUsernameString  @"USERNAME"
#define PlaceholderLoginPasswordString  @"PASSWORD"
#define PlaceholderSignupFirstNameString  @"FIRST NAME"
#define PlaceholderSignupLastNameString  @"LAST NAME"
#define PlaceholderSignupDobString  @"dd-mm-yyyy"
#define PlaceholderSignupPhoneNumberString  @"  xx-xx-xxxx"
#define PlaceholderSignupEmailString  @"abc@gmail.com"
#define PlaceholderSignupCountryCodeString  @"   +968"
#define PlaceholderLForgetPassword  @"ENTER EMAIL"


#define IsSettingScreen @"Setting Screen"


#define LOYALITYPROGRAMURLPAGE @"http://webisdomsolutions.com/nissanweb/loyality-program.php"
#define MAINTENCETIPSURLPAGE @"http://webisdomsolutions.com/nissanweb/maintenance_tips.php"
#define ADVENTUREPARKPAGE @"http://webisdomsolutions.com/nissanweb/adventure.php"
//************************************************** Alerts **************************************************
#define ApplicationInternetConnectionErrorMessage   @"Please check your internet connection."


//************************************************** Networking **************************************************
#define kN_BaseURL                       @"kN_BaseURL"
#define kN_BaseIP                        @"kN_BaseIP"

//************************************************** Nudger Chat User Registration **************************************************
#define kN_ChatBaseIP                     @"kN_ChatBaseIP"
#define kN_ChatBaseURL                    @"kN_ChatBaseURL"
#define kN_Host                           @"Host"
#define kN_ServerDomain                   @"ServerDomain"

#define NudgerSQLFile                      @"Nudger.sqlite"
#define NudgerAllNumber                    @"AllNumbers"
#define NudgerDriversNumber                @"NudgerNumber"

//************************************************** Webservices URL **************************************************
#define W_UserSignup                       @"signup"
#define W_UserVerify                       @"verifyMobile"
#define W_UserResendVerification           @"resendVerificationCode"
#define W_UserUpdate                       @"updateUser"
#define W_GetUserById                      @"user/"
#define W_GetUsers                         @"users"
#define W_GetAllCategories                 @"categories"


//************************************************** Chat core Data entity Name **************************************************
#define ReadStatusNotification  @"ReadNotification"
#define ConversationDataEntity @"ConversationData"
#define MessageDataEntity @"MessageData"
#define SwoopAppendId @"Recv"

//************************************************** Message Type Keys **************************************************
#define TTMMessageTypeText @"1"
#define TTMMessageTypeImage @"2"
#define TTMMessageTypeAudio @"6"
#define TTMMessageTypeVideo @"3"

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

#define TollfreeNumber                     @"80050011"

//********************************** screen factors **************************************************
#define ScreenWidthFactor       [UIScreen mainScreen].bounds.size.width/320
#define ScreenHeightFactor      [UIScreen mainScreen].bounds.size.height/568
#define ScreenFactor            sqrt(pow([UIScreen mainScreen].bounds.size.width/320, 2)+pow([UIScreen mainScreen].bounds.size.height/568, 2))
#define cellPadding             ScreenWidthFactor*12
#define cellPaddingReg          ScreenWidthFactor*15

typedef enum {
    RequestTypeQuote          = 0,
    RequestTypeBrochure       = 1,
    RequestTypeTestDrive      = 2,
    
} RequestType;






#endif


