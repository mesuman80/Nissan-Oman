//
//  LoginViewController.m
//  Nissan Oman
//
//  Created by Sakshi on 26/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginBaseviewViewController.h"
#import "CustomTextField.h"
#import "SignupViewController.h"
#import "ForgetPasswordViewController.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "UserData.h"
#import "SharePreferenceUtil.h"
#import "Common.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController ()<UITextFieldDelegate,CustomWebServiceDelegate>

@end

@implementation LoginViewController
{
    WebService *webService;
    UITextField *activeTextField;
    NSString *fbAccessToken;
    BOOL isFirstTime;

}

@synthesize usernameTextfield,passwordTextfield;
@synthesize forgetPasswordButton,loginButton,loginWithFacebookButton;
@synthesize signupButton,separatorLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstTime = YES;
 
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self setupTextField];
        [self setupForForgetPassword];
        [self setupForSignUp];
        [self addSeparatorView];
        [self setupForFacebookLogin];
        [self setBottomBanner];

        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupTextField{
    
    usernameTextfield = [[CustomTextField alloc] init];
    [usernameTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [usernameTextfield setPlaceholder:PlaceholderLoginUsernameString];
    usernameTextfield.delegate =self;
    [self.scrollView addSubview:usernameTextfield];
    
    self.y = usernameTextfield.frame.origin.y+usernameTextfield.frame.size.height+ScreenHeightFactor*20;
    
    passwordTextfield = [[CustomTextField alloc] init];
    [passwordTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [passwordTextfield setPlaceholder:PlaceholderLoginPasswordString];
    passwordTextfield.delegate = self;
    passwordTextfield.secureTextEntry = YES;
    [self.scrollView addSubview:passwordTextfield];
    
    self.y = passwordTextfield.frame.origin.y+passwordTextfield.frame.size.height+ScreenHeightFactor*10;
}

-(void)setupForForgetPassword{
    forgetPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2 + 25*ScreenWidthFactor, self.y, screenWidth/2 - 25*ScreenWidthFactor, ScreenHeightFactor*40)];
    [forgetPasswordButton setBackgroundColor:[UIColor clearColor]];
    [forgetPasswordButton setTitle:@"Forget Password ?" forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetPasswordButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f] ];
    [self.scrollView addSubview:forgetPasswordButton];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonTouched:) forControlEvents:UIControlEventTouchUpInside];

    
    self.y = forgetPasswordButton.frame.origin.y+forgetPasswordButton.frame.size.height+ScreenHeightFactor*10;
}

-(void)setupForSignUp{
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [loginButton setBackgroundColor:[UIColor whiteColor]];
    [loginButton setTitle:@"LOGIN" forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [loginButton setTitleColor:buttonRedColor forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:loginButton];
    
    self.y = loginButton.frame.origin.y+loginButton.frame.size.height+ScreenHeightFactor*30;
    
    signupButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-ScreenWidthFactor*40,self.y, ScreenWidthFactor*80, ScreenHeightFactor*40)];
    [signupButton setBackgroundColor:[UIColor clearColor]];
    [signupButton setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signupButton addTarget:self action:@selector(signupButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:signupButton];
    
    UIView *highlighter = [[UIView alloc] initWithFrame:CGRectMake(screenWidth/2-ScreenWidthFactor*45, self.y+signupButton.frame.size.height-ScreenHeightFactor*7, ScreenWidthFactor*90, ScreenHeightFactor*2)];
    [highlighter setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:highlighter];
    
    self.y = signupButton.frame.origin.y+signupButton.frame.size.height+ScreenHeightFactor*30;
}

-(void)addSeparatorView{
    UIView *separatorView1 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidthFactor*10, self.y, screenWidth/2-ScreenWidthFactor*50, ScreenHeightFactor*1)];
    [separatorView1 setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:separatorView1];
    
    separatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidthFactor*130, self.y-ScreenHeightFactor*25, ScreenWidthFactor*50, ScreenHeightFactor*50)];
    [separatorLabel setText:@"OR"];
    separatorLabel.textAlignment = NSTextAlignmentCenter;
    [separatorLabel setTextColor:[UIColor whiteColor]];
    [self.scrollView addSubview:separatorLabel];
    
    UIView *separatorView2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidthFactor*190, self.y, screenWidth/2-ScreenWidthFactor*40, ScreenHeightFactor*1)];
    [separatorView2 setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:separatorView2];
    
    self.y = self.y+ScreenHeightFactor*30;
}

-(void)setupForFacebookLogin{
    
    loginWithFacebookButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidthFactor*10, self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [loginWithFacebookButton setBackgroundImage:[UIImage imageNamed:@"signfacebook.png"] forState:UIControlStateNormal];
    [loginWithFacebookButton addTarget:self action:@selector(facebookLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:loginWithFacebookButton];
    
    self.y = loginWithFacebookButton.frame.origin.y+loginWithFacebookButton.frame.size.height+ScreenHeightFactor*20;
}

-(void)setBottomBanner{
    UIImageView *bottomBannerView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/8, self.y, screenWidth-ScreenWidthFactor*80, ScreenHeightFactor*40)];
    [bottomBannerView setImage:[UIImage imageNamed:@"bottombar.png"]];
    [self.scrollView addSubview:bottomBannerView];
    self.y += bottomBannerView.frame.size.height + 5;
    [self.scrollView setContentSize:CGSizeMake(0, self.y)];
}

#pragma textField Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"usernameTextfield.text = %@",usernameTextfield.text);
    
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.scrollView endEditing:YES];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeTextField = textField;
}

-(void)signupButtonTouched:(id)sender{
    SignupViewController *signupViewController = [[SignupViewController alloc] init];
    [self.navigationController pushViewController:signupViewController animated:YES];
}

-(void)forgetPasswordButtonTouched:(id)sender
{
    ForgetPasswordViewController *forgetPasswordViewController = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
}

-(void)loginButtonTouched:(id)sender{
    
    if([self checkValidation])
    {
        NSDictionary *dict = @{
                               @"name" : usernameTextfield.text,
                               @"password" : passwordTextfield.text
                               };
        webService = [[WebService alloc]init];
        webService.serviceName = @"login";
        webService.customWebServiceDelegate = self;
        [activeTextField resignFirstResponder];
       [ webService loginUser:dict];
    }
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict
{
    UserData *data = [UserData sharedData];

    data.userName = [dict valueForKey:@"name"];
    data.userId = [dict valueForKey:@"email"];
    data.firstName = [dict valueForKey:@"name"];
    
    [[SharePreferenceUtil getInstance]saveBool:YES withKey:kN_isUserMobileRegistered];

    
    [Common saveCustomObject:data key:@"UserData"];
    
   
    [self openTabBar];
}

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict
{
    [self showAlertView:@"Error" WithMessage:[dict valueForKey:@"error_msg"]];
}

-(AppDelegate *)getInstance
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
-(void)openTabBar
{
    AppDelegate *appDelegate=[self getInstance];
    [appDelegate openTabBar];
}

-(BOOL)checkValidation
{
    NSString *userName;
    NSString *password;
    BOOL isValid;
    
    userName = [usernameTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(userName.length >0)
    {
        isValid = YES;
    }
    else
    {
        isValid = NO;
        [self showAlertView:@"Error" WithMessage:@"Please enter all required fields"];
        return NO;
    }
    
    password = [passwordTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    
    if(isValid && password.length > 0)
    {
        return YES;
    }
    
    return NO;
}

-(void)showAlertView:(NSString *)title WithMessage:(NSString *)msg
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle: title
                                                                        message: msg
                                                                 preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction      = [UIAlertAction actionWithTitle: @"Ok"
                                                               style: UIAlertActionStyleCancel
                                                             handler: ^(UIAlertAction *action) {
                                                                 
                                                             }];
    
    [controller addAction: alertAction];
    
    UIViewController* viewController =[[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    
    [viewController presentViewController: controller
                                 animated: YES
                               completion: nil];

}


#pragma mark FaceBook Related Function 
-(void)facebookLogin:(id)sender {
    NSLog(@"FaceBook Login");
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile",@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
         }
         
         if(result.token)   // This means if There is current access token.
         {
             
             fbAccessToken =result.token.tokenString;
             NSLog(@"fbAccessToken:%@", fbAccessToken);
             [[NSUserDefaults standardUserDefaults] setValue:(fbAccessToken)  forKey:@"fbaccesstoken"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender"}]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
                          NSLog(@"fetched user:%@", result);
                          
                          [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"fbuser"];
                          [[NSUserDefaults standardUserDefaults] synchronize];
                          
                          
                                    
                          webService = [[WebService alloc]init];
                          webService.serviceName = @"signUp";
                          webService.customWebServiceDelegate = self;
                          NSDictionary *dict = @{
                                                 @"firstName" : [result valueForKey:@"first_name"],
                                                 @"lastName" : [result valueForKey:@"last_name"],
                                                 @"dateOfBirth" :@"",
                                                 @"phoneNum" : @"",
                                                 @"email" : [result valueForKey:@"email"],
                                                 @"password" : @"",
                                                 @"signUpMode": @"FACEBOOK"
                                                 };
                          [webService registerUser:dict];

                          
                          
                          // [self showPhoneNumberPopup];
                      }
                  }];
             }
         }

     }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
