//
//  ForgetPasswordViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 23/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "WebService.h"
#import "SharePreferenceUtil.h"
#import "Common.h"
#import "CustomTextField.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate,CustomWebServiceDelegate>

@end

@implementation ForgetPasswordViewController
{
    WebService *webService;
    CustomTextField *usernameTextfield;
    UIButton *submitButton;
    UIButton *loginButton;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupTextField];
    [self setupForSignUp];
}


#pragma mark ui rendering

-(void)setupTextField{                  // setting up text field
    
    usernameTextfield = [[CustomTextField alloc] init];
    [usernameTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [usernameTextfield setPlaceholder:PlaceholderLForgetPassword];
    usernameTextfield.delegate =self;
    [self.scrollView addSubview:usernameTextfield];
    
    self.y = usernameTextfield.frame.origin.y+usernameTextfield.frame.size.height+ScreenHeightFactor*20;
    

}

-(void)setupForSignUp{
    submitButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [submitButton setBackgroundColor:[UIColor whiteColor]];
    [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [submitButton setTitleColor:buttonRedColor forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:submitButton];
    
    self.y = submitButton.frame.origin.y+submitButton.frame.size.height+ScreenHeightFactor*30;
    
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2-ScreenWidthFactor*40,self.y, ScreenWidthFactor*140, ScreenHeightFactor*40)];
    loginButton.center = CGPointMake(screenWidth/2, loginButton.center.y);
    [loginButton setBackgroundColor:[UIColor clearColor]];
    [loginButton setTitle:@"BACK TO LOGIN" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:loginButton];
    
    UIView *highlighter = [[UIView alloc] initWithFrame:CGRectMake(screenWidth/2-ScreenWidthFactor*45, self.y+loginButton.frame.size.height-ScreenHeightFactor*7, loginButton.frame.size.width, ScreenHeightFactor*2)];
    highlighter.center = CGPointMake(screenWidth/2, highlighter.center.y);

    [highlighter setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:highlighter];
    
    self.y = loginButton.frame.origin.y+loginButton.frame.size.height+ScreenHeightFactor*30;
}

#pragma mark touch handler

-(void)loginButtonTouched:(id)sender{                   // touch handler of login button
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitBtnClicked:(id)sender                      // touch handler of submit button
{
    webService = [[WebService alloc]init];
    webService.serviceName = @"forgetPassword";
    webService.customWebServiceDelegate = self;
    [ webService forgetPassword:usernameTextfield.text.lowercaseString];
}

#pragma mark connection delegate

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict                  // connection success case
{
    
}

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict                // connection failure case
{
    [self showAlertView:@"Error" WithMessage:[dict valueForKey:@"error_msg"]];
}


#pragma mark alertview implementation

-(void)showAlertView:(NSString *)title WithMessage:(NSString *)msg          // show alertview
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
