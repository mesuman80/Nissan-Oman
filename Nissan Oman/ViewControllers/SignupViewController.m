//
//  SignupViewController.m
//  Nissan Oman
//
//  Created by Sakshi on 30/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "SignupViewController.h"


@interface SignupViewController ()<UITextFieldDelegate>

@end

@implementation SignupViewController

@synthesize firstNameTextfield,lastNameTextfield;
@synthesize dobNameTextfield,phoneNumberTextfield;
@synthesize emailTextfield,passwordTextfield;
@synthesize signupButton,loginButton,bottomBannarView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*1.2);
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self setupForTextfield];
    [self setupForSignup];
    [self setBottomBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupForTextfield{
    
    firstNameTextfield = [[CustomTextField alloc] init];
    [firstNameTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [firstNameTextfield setPlaceholder:PlaceholderSignupFirstNameString];
    firstNameTextfield.delegate =self;
    [self.scrollView addSubview:firstNameTextfield];
    
    self.y = firstNameTextfield.frame.origin.y+firstNameTextfield.frame.size.height+ScreenHeightFactor*10;
    
    lastNameTextfield = [[CustomTextField alloc] init];
    [lastNameTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [lastNameTextfield setPlaceholder:PlaceholderSignupLastNameString];
    lastNameTextfield.delegate = self;
    [self.scrollView addSubview:lastNameTextfield];
    
    self.y = lastNameTextfield.frame.origin.y+lastNameTextfield.frame.size.height+ScreenHeightFactor*10;
    
    dobNameTextfield = [[CustomTextField alloc] init];
    [dobNameTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [dobNameTextfield setPlaceholder:PlaceholderSignupDobString];
    dobNameTextfield.delegate = self;
    [self.scrollView addSubview:dobNameTextfield];
    
    self.y = dobNameTextfield.frame.origin.y+dobNameTextfield.frame.size.height+ScreenHeightFactor*10;
    
    phoneNumberTextfield = [[CustomTextField alloc] init];
    [phoneNumberTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [phoneNumberTextfield setPlaceholder:PlaceholderSignupPhoneNumberString];
    phoneNumberTextfield.delegate = self;
    phoneNumberTextfield.keyboardType = UIKeyboardTypePhonePad;
    UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,60,ScreenHeightFactor*50)];
    leftView1.backgroundColor = [UIColor clearColor];
    [leftView1 setText:PlaceholderSignupCountryCodeString];
    [leftView1 setFont:[UIFont systemFontOfSize:12.0]];
    [leftView1 setTextColor:[UIColor whiteColor]];
    [leftView1.layer setBorderWidth:1];
    [leftView1.layer setBorderColor:[UIColor whiteColor].CGColor];
    leftView1.textAlignment = NSTextAlignmentCenter;
    phoneNumberTextfield.leftView = leftView1;
    phoneNumberTextfield.leftViewMode = UITextFieldViewModeAlways;
    phoneNumberTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.scrollView addSubview:phoneNumberTextfield];
    
    self.y = phoneNumberTextfield.frame.origin.y+phoneNumberTextfield.frame.size.height+ScreenHeightFactor*10;
    
    emailTextfield = [[CustomTextField alloc] init];
    [emailTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [emailTextfield setPlaceholder:PlaceholderSignupEmailString];
    emailTextfield.delegate = self;
    emailTextfield.keyboardType = UIKeyboardTypeURL;
    [self.scrollView addSubview:emailTextfield];
    
    self.y = emailTextfield.frame.origin.y+emailTextfield.frame.size.height+ScreenHeightFactor*10;
    
    passwordTextfield = [[CustomTextField alloc] init];
    [passwordTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [passwordTextfield setPlaceholder:PlaceholderLoginPasswordString];
    passwordTextfield.delegate = self;
    passwordTextfield.secureTextEntry = YES;
    [self.scrollView addSubview:passwordTextfield];
    
    self.y = passwordTextfield.frame.origin.y+passwordTextfield.frame.size.height+ScreenHeightFactor*20;

}

-(void)setupForSignup{
    signupButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [signupButton setBackgroundColor:[UIColor whiteColor]];
    [signupButton setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [signupButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [signupButton setTitleColor:buttonRedColor forState:UIControlStateNormal];
    [signupButton addTarget:self action:@selector(signupButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:signupButton];
    
    self.y = signupButton.frame.origin.y+signupButton.frame.size.height+ScreenHeightFactor*10;
    
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-ScreenWidthFactor*40,self.y, ScreenWidthFactor*80, ScreenHeightFactor*40)];
    [loginButton setBackgroundColor:[UIColor clearColor]];
    [loginButton setTitle:@"LOGIN" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:loginButton];
    
    UIView *highlighter = [[UIView alloc] initWithFrame:CGRectMake(screenWidth/2-ScreenWidthFactor*45, self.y+signupButton.frame.size.height-ScreenHeightFactor*7, ScreenWidthFactor*90, ScreenHeightFactor*2)];
    [highlighter setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:highlighter];
    
    self.y = loginButton.frame.origin.y+loginButton.frame.size.height+ScreenHeightFactor*30;
}

-(void)setBottomBanner{
    UIImageView *bottomBannerView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/8, self.y, screenWidth-ScreenWidthFactor*80, ScreenHeightFactor*40)];
    [bottomBannerView setImage:[UIImage imageNamed:@"bottombar.png"]];
    [self.scrollView addSubview:bottomBannerView];
}

#pragma textField Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
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

-(void)signupButtonTouched:(id)sender{
   
}

-(void)loginButtonTouched:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
