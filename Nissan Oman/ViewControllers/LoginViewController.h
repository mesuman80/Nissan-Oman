//
//  LoginViewController.h
//  Nissan Oman
//
//  Created by Sakshi on 26/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginBaseviewViewController.h"
#import "CustomTextField.h"

@interface LoginViewController : LoginBaseviewViewController

@property CustomTextField *usernameTextfield;
@property CustomTextField *passwordTextfield;
@property UIButton *forgetPasswordButton;
@property UIButton *loginButton;
@property UIButton *signupButton;
@property UIButton *loginWithFacebookButton;

@property UILabel *separatorLabel;

-(void)setupTextField;
-(void)setupForForgetPassword;
-(void)setupForSignUp;
-(void)setupForFacebookLogin;
-(void)setBottomBanner;
-(void)addSeparatorView;
-(void)signupButtonTouched:(id)sender;
-(void)loginButtonTouched:(id)sender;
-(void)facebookButtonTouched:(id)sender;

@end
