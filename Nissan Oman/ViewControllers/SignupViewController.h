//
//  SignupViewController.h
//  Nissan Oman
//
//  Created by Sakshi on 30/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginBaseviewViewController.h"
#import "CustomTextField.h"

@interface SignupViewController : LoginBaseviewViewController

@property CustomTextField *firstNameTextfield;
@property CustomTextField *lastNameTextfield;
@property CustomTextField *dobNameTextfield;
@property CustomTextField *phoneNumberTextfield;
@property CustomTextField *emailTextfield;
@property CustomTextField *passwordTextfield;
@property UIButton *signupButton;
@property UIButton *loginButton;
@property UIImageView *bottomBannarView;

-(void)setupForTextfield;
-(void)setupForSignup;
-(void)signupButtonTouched:(id)sender;
-(void)loginButtonTouched:(id)sender;

@end
