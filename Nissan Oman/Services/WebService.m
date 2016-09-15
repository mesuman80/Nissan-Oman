//
//  WebService.m
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "WebService.h"

@implementation WebService{
    Utility *utility;
    SharePreferenceUtil *sharePreferenceUtil;
    UserData *userData;
    
}
@synthesize customWebServiceDelegate, serviceName;

-(id)init{
    utility = [[Utility alloc]init];
    sharePreferenceUtil = [SharePreferenceUtil getInstance];
    userData  = [sharePreferenceUtil getCustomObjectFromDefaultsWithKey:kN_UserData];

    return self;
}

#pragma Request Base
//Post Request with Authorization Header
-(NSMutableURLRequest*)getBasicHeaderForPostRequest:(NSString*)url withData:(NSMutableDictionary*)arguments{
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:arguments options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:userData.token forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

//Get Request with Authorization Header
-(NSMutableURLRequest*)getBasicHeaderForGetRequest:(NSString*)url  withData:(NSMutableDictionary*)arguments{
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:arguments options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:userData.token forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

//Post Request
-(NSMutableURLRequest*)requestForPost:(NSString*)url  withData:(NSMutableDictionary*)arguments{
    NSData *jsonData;
    if(arguments)
    {
       jsonData = [NSJSONSerialization
                            dataWithJSONObject:arguments options:NSJSONWritingPrettyPrinted error:nil];

    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:[NSString stringWithFormat:@"%lu",
                       (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

//Get Request
-(NSMutableURLRequest*)requestForGet:(NSString*)url  withData:(NSMutableDictionary*)arguments{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    if(arguments){
        NSData *jsonData = [NSJSONSerialization
                            dataWithJSONObject:arguments options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:jsonData];
        [request setValue:[NSString stringWithFormat:@"%lu",
                           (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

-(ResponseModel*)processResponseData:(NSData*)data{
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                options:kNilOptions
                                                                  error:nil];
    ResponseModel *responseModel = [[ResponseModel alloc]init];
    responseModel.status = [json valueForKey:@"status"];
    responseModel.errorMessage = [json valueForKey:@"errorMessage"];
    responseModel.results = [json valueForKey:@"results"];
    @try {
        responseModel.resultsArray = [json valueForKey:@"results"];
    } @catch (NSException *exception) {
    } @finally {        
    }
    
    return responseModel;
}

-(BOOL)isError:(ResponseModel*)response{
    if(response.errorMessage == nil || response.errorMessage == NULL){
        return NO;
    }else if([response.status isEqualToString:@"OK"]){
        return NO;
    }else{
        return YES;
    }
}

-(NSString*)getErrorMessage:(NSString*)responseStatus{
    NSString *data;
    if([responseStatus isEqualToString:@"OK"]){
        data = @"";
    }else if([responseStatus isEqualToString:@"Missing_Inputs"]){
        data = @"There are some missing inputs!";
    }else if([responseStatus isEqualToString:@"Invalid_Inputs"]){
        data = @"There are some invalid inputs!";
    }else if([responseStatus isEqualToString:@"Unknown_Error"]){
        data = @"Some error has occured!";
    }else if([responseStatus isEqualToString:@"UserExists"]){
        data = @"This User Already Exists!";
    }else if([responseStatus isEqualToString:@"UserNotExist"]){
        data = @"This user doesn't exist!";
    }else if([responseStatus isEqualToString:@"FailureLoginAuth"]){
        data = @"Login Failed!";
    }else if([responseStatus isEqualToString:@"No_ActiveRequest"]){
        data = @"There are no active Requests!";
    }else if([responseStatus isEqualToString:@"CodeNotValid"]){
        data = @"Code is Invalid!";
    }else if([responseStatus isEqualToString:@"No_Record_Found"]){
        data = @"No record is Found!";
    }else{
        data = @"Somethings not correct. Please try again.";
    }
    return data;
}

-(void)processServerResult:(NSURLResponse*)response withData:(NSData*)data withCompletionCallback:(onCompletion)iCompletion{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger statusCode   = httpResponse.statusCode;
        [utility hideHUD];
        if(statusCode  ==  200) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *userDict;
            if([self.serviceName isEqualToString:@"login"] || [self.serviceName isEqualToString:@"signUp"])
            {
                userDict = [dict valueForKey:@"user"];
                
                if([[dict valueForKey:@"error"] compare:[NSNumber numberWithInt:1]] == NSOrderedSame){
                    if(self.customWebServiceDelegate)
                    {
                        [self.customWebServiceDelegate ConnectionDidFinishWithError:dict];
                    }
                }
                else{
                    if(self.customWebServiceDelegate)
                    {
                        [self.customWebServiceDelegate ConnectionDidFinishWithSuccess:userDict];
                    }
                }
            }
            else if([self.serviceName isEqualToString:@"vehicleCategory"])
            {
               
                userDict = dict;
                if(self.customWebServiceDelegate)
                {
                    [self.customWebServiceDelegate ConnectionDidFinishWithSuccess:userDict];
                }

            }
            else if([self.serviceName isEqualToString:@"vehicleSubCategory"])
            {
                
                userDict = dict;
                if(self.customWebServiceDelegate)
                {
                    [self.customWebServiceDelegate ConnectionDidFinishWithSuccess:userDict];
                }
                
            }
            else if([self.serviceName isEqualToString:@"vehicleDescription"])
            {
                
                userDict = dict;
                if(self.customWebServiceDelegate)
                {
                    [self.customWebServiceDelegate ConnectionDidFinishWithSuccess:userDict];
                }
                
            }
            else if([self.serviceName isEqualToString:@"showroomAddress"])
            {
                
                userDict = dict;
                if(self.customWebServiceDelegate)
                {
                    [self.customWebServiceDelegate ConnectionDidFinishWithSuccess:userDict];
                }
                
            }

         
        }else {
            iCompletion(@"Somethings not correct. Please try again.", nil);
        }
    });
}

-(void)registerMobileNumberInServer:(NSString*)mobileNumber withCC:(NSString*)countryCode completion:(onCompletion)iCompletion{
    if([[InternetConnection sharedInstance] connectionStatus]) {
        NSString* url = [NSString stringWithFormat:@"%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],W_UserSignup];
        NSString *value=[NSString stringWithFormat:@"%@-%@",countryCode,mobileNumber];
        NSMutableDictionary *dict = @{U_PhoneNumber:value}.mutableCopy;
        NSMutableURLRequest *request = [self requestForPost:url withData:dict];
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                                iCompletion(error, responseModel);
                            }];
                        }] resume];
            
        }
    }else{
        [utility hideHUD];
        [utility showAlertWithTitle:@"Error!" message:ApplicationInternetConnectionErrorMessage andDelegate:nil];
    }
}


-(void)verifyMobileNumberInServer:(NSString*)mobileNumber withVerificationCode:(NSString*)verifyCode completion:(onCompletion)iCompletion{
     if([[InternetConnection sharedInstance] connectionStatus]) {
        NSString* url = [NSString stringWithFormat:@"%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],W_UserVerify];
        NSMutableDictionary *dict = @{U_PhoneNumber:mobileNumber,
                                      U_VerificationCode:verifyCode}.mutableCopy;
        NSMutableURLRequest *request = [self requestForPost:url withData:dict];
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                                iCompletion(error, responseModel);
                            }];
                        }] resume];
            
        }
     }else{
         [utility hideHUD];
         [utility showAlertWithTitle:@"Error!" message:ApplicationInternetConnectionErrorMessage andDelegate:nil];
     }
}

-(void)resendVerificationCode:(NSString*)mobileNumber completion:(onCompletion)iCompletion{
    if([[InternetConnection sharedInstance] connectionStatus]) {
        NSString* url = [NSString stringWithFormat:@"%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],W_UserResendVerification];
        NSMutableDictionary *dict = @{U_PhoneNumber:mobileNumber}.mutableCopy;
        NSMutableURLRequest *request = [self requestForPost:url withData:dict];
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                                iCompletion(error, responseModel);
                            }];
                        }] resume];
        }
    }else{
        [utility hideHUD];
        [utility showAlertWithTitle:@"Error!" message:ApplicationInternetConnectionErrorMessage andDelegate:nil];
    }
}

-(void)updateDeviceTokenInSever{
    if([[InternetConnection sharedInstance] connectionStatus]) {
        NSString* url = [NSString stringWithFormat:@"%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],W_UserUpdate];
        NSMutableDictionary *dict = @{U_PhoneNumber:userData.userNumberWithCountryCode,
                                      U_DeviceToken:userData.deviceToken}.mutableCopy;
        NSMutableURLRequest *request = [self getBasicHeaderForPostRequest:url withData:dict];
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        }] resume];
            
        }
    }
}

-(void)getCategoryListWithCompletion:(onCompletion)iCompletion{
    if([[InternetConnection sharedInstance] connectionStatus]) {
        NSString* url = [NSString stringWithFormat:@"%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],W_GetAllCategories];
        NSMutableURLRequest *request = [self requestForGet:url withData:nil];
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                                iCompletion(error, responseModel);
                            }];
                        }] resume];
            
        }
    }
}

-(void)registerUser:(NSDictionary *)dict {
    if([[InternetConnection sharedInstance] connectionStatus]) {
        [utility showHUD];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",@"users/?tag=register&name=",[dict valueForKey:@"firstName"],@"&email=",[dict valueForKey:@"email"],@"&password=",[dict valueForKey:@"password"],@"&mobile=",[dict valueForKey:@"phoneNum"],@"&dob=",[dict valueForKey:@"dateOfBirth"]];
        
        NSString* url = [NSString stringWithFormat:@"%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],str];
        NSMutableURLRequest *request = [self requestForPost:url withData:nil];
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                               // iCompletion(error, responseModel);
                            }];
                        }] resume];
            
        }
    }
    else{
        [utility hideHUD];
        [utility showAlertWithTitle:@"Error!" message:ApplicationInternetConnectionErrorMessage andDelegate:nil];
    }

}

-(void)loginUser:(NSDictionary *)dict
{
    if([[InternetConnection sharedInstance] connectionStatus]) {
        [utility showHUD];
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@",@"users/?tag=login&email=",[dict valueForKey:@"name"],@"&password=",[dict valueForKey:@"password"]];
        
        NSString* url = [NSString stringWithFormat:@"%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],str];
        NSMutableURLRequest *request = [self requestForGet:url withData:nil];
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                               // iCompletion(error, responseModel);
                            }];
                        }] resume];
            
        }
    }
    else{
        [utility hideHUD];
        [utility showAlertWithTitle:@"Error!" message:ApplicationInternetConnectionErrorMessage andDelegate:nil];
    }
    
}

-(void)getVehicleCategeoryList
{
    if([[InternetConnection sharedInstance] connectionStatus]) {
        [utility showHUD];
        NSString* url = [NSString stringWithFormat:@"%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],@"category/?tag=view"];
        NSMutableURLRequest *request = [self requestForGet:url withData:nil];
        
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                                // iCompletion(error, responseModel);
                            }];
                        }] resume];
            
        }
    }
    else{
        [utility hideHUD];
        [utility showAlertWithTitle:@"Error!" message:ApplicationInternetConnectionErrorMessage andDelegate:nil];
    }
    
}

-(void)getVehicleSubCategeoryList:(NSString *)idVal
{
    if([[InternetConnection sharedInstance] connectionStatus]) {
        [utility showHUD];
        
        NSString* url = [NSString stringWithFormat:@"%@%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],@"model/?id=",idVal];
        NSMutableURLRequest *request = [self requestForGet:url withData:nil];
        
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                                // iCompletion(error, responseModel);
                            }];
                        }] resume];
            
        }
    }
    else{
        [utility hideHUD];
        [utility showAlertWithTitle:@"Error!" message:ApplicationInternetConnectionErrorMessage andDelegate:nil];
    }
    
}

-(void)getVehicleDescription:(NSString *)idVal
{
    if([[InternetConnection sharedInstance] connectionStatus]) {
        [utility showHUD];
        
        NSString* url = [NSString stringWithFormat:@"%@%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],@"vehicle/?id=",idVal];
        NSMutableURLRequest *request = [self requestForGet:url withData:nil];
        
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                                // iCompletion(error, responseModel);
                            }];
                        }] resume];
            
        }
    }
    else{
        [utility hideHUD];
        [utility showAlertWithTitle:@"Error!" message:ApplicationInternetConnectionErrorMessage andDelegate:nil];
    }
    
}

-(void)getShowroomAddress
{
    if([[InternetConnection sharedInstance] connectionStatus]) {
        [utility showHUD];
        NSString* url = [NSString stringWithFormat:@"%@%@",[sharePreferenceUtil getStringWithKey:kN_BaseURL],@"showroom_address/?tag=view"];
        NSMutableURLRequest *request = [self requestForGet:url withData:nil];
        
        if(request) {
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            [[session dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                            [self processServerResult:response withData:data withCompletionCallback:^(NSString *error, ResponseModel *responseModel) {
                                // iCompletion(error, responseModel);
                            }];
                        }] resume];
            
        }
    }
    else{
        [utility hideHUD];
        [utility showAlertWithTitle:@"Error!" message:ApplicationInternetConnectionErrorMessage andDelegate:nil];
    }
    
}


@end
