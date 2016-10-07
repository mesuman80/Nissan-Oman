//
//  SignupViewController.m
//  Nissan Oman
//
//  Created by Sakshi on 30/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "SignupViewController.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "UserData.h"
#import "Common.h"

@interface SignupViewController ()<UITextFieldDelegate,CustomWebServiceDelegate>

@end

@implementation SignupViewController
{
    WebService *webService;                      // webservice object
    UITextField *activeTextField;                // to check which textfield is active
    UIView *datePickerView;                      // view to add datepicker
    UIDatePicker *myDatePicker;                  // uidatepicker object
    NSDate *dob;                                 // dob string
    UITextField *previousTextField;              // previously active textfield if any
    UITextField *desiredField;                   // textfield that act as label
}

@synthesize firstNameTextfield,lastNameTextfield;
@synthesize dobNameTextfield,phoneNumberTextfield;
@synthesize emailTextfield,passwordTextfield;
@synthesize signupButton,loginButton,bottomBannarView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackgroundTap:)];
    [self.scrollView addGestureRecognizer:gesture];
   // self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*1.2);
    // Do any additional setup after loading the view.
}
-(void)onBackgroundTap:(id)sender       // background tap gesture
{
    if(activeTextField)                 // if keyboard is there, the drop it down
    {
        [activeTextField resignFirstResponder];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupForTextfield];               // setting up textfields
    [self setupForSignup];                  // setting up sign up buton
    [self setBottomBanner];                 // setting up bottom logo
    
     [self addKeyBoardNotification];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeAllNotification];
}

#pragma mark KeyBoardNotification
-(void)addKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void) keyboardWillShow:(NSNotification *)note
{
    NSLog(@"self.frame %f", self.view.frame.size.height);
    
    NSDictionary* info = [note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint point= CGPointZero;
    // [scrollView setContentSize:CGSizeMake (scrollView.frame.size.width,scrollView.contentSize.height)];
    
    NSLog(@"self.frame %f", self.view.frame.size.height);
    point = activeTextField.frame.origin ;
    if (!CGRectContainsPoint(aRect,point))
    {
        CGPoint scrollPoint = CGPointMake(0.0, activeTextField.frame.origin.y-kbSize.height  );
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}

-(void) keyboardWillHide:(NSNotification *)note
{
    NSLog(@"KeyBoard wiil Hide");
    UIEdgeInsets contentInsets=UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    //[doneView removeFromSuperview];
}

-(void)removeAllNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ui drawig implementation
//************************************ UI elements drawing methods ********************************//
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
    dobNameTextfield.tag = 100;
    [self.scrollView addSubview:dobNameTextfield];
    
    self.y = dobNameTextfield.frame.origin.y+dobNameTextfield.frame.size.height+ScreenHeightFactor*10;
    
    phoneNumberTextfield = [[CustomTextField alloc] init];
    [phoneNumberTextfield setFrame:CGRectMake(ScreenWidthFactor*10,self.y, screenWidth-ScreenWidthFactor*20, ScreenHeightFactor*40)];
    [phoneNumberTextfield setPlaceholder:PlaceholderSignupPhoneNumberString];
    phoneNumberTextfield.delegate = self;
    phoneNumberTextfield.keyboardType = UIKeyboardTypePhonePad;
    UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,60,phoneNumberTextfield.frame.size.height)];
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
    
    
     self.scrollView.contentSize = CGSizeMake(0, bottomBannerView.frame.size.height + bottomBannerView.frame.origin.y);
}

#pragma textField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 100)                    // for DOB
    {
        desiredField = textField;
        [textField resignFirstResponder];
        [self openDatePicker];
        return NO;
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag != 100)
    {
        previousTextField = textField;
    }
   
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == phoneNumberTextfield)
    {
        if(textField.text.length > phoneNumLength - 1)                    // for phone numer lenght check
        {
            return NO;
        }
    }
    return YES;
}
-(void)signupButtonTouched:(id)sender{                        // touch handler of sign up button
   if([self checkValidation])
   {
       webService = [[WebService alloc]init];
       webService.serviceName = @"signUp";
       webService.customWebServiceDelegate = self;
       NSDictionary *dict = @{
                              @"firstName" : firstNameTextfield.text,
                              @"lastName" : lastNameTextfield.text,
                              @"dateOfBirth" :dobNameTextfield.text,
                              @"phoneNum" : phoneNumberTextfield.text,
                              @"email" : emailTextfield.text,
                              @"password" : passwordTextfield.text,
                              @"signUpMode": @"INAPP"
                              };
       [webService registerUser:dict];
   }
    
}

#pragma mark webservice delegates implementation

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict                   // webservice success case
{
     UserData *data = [UserData sharedData];
    data.userName = [dict valueForKey:@"name"];
    data.userId = [dict valueForKey:@"email"];
    data.firstName = [dict valueForKey:@"name"];
    
    [[SharePreferenceUtil getInstance]saveBool:YES withKey:kN_isUserMobileRegistered];      // save user to data base
    [Common saveCustomObject:data key:@"UserData"];

    [self openTabBar];                                                                      // open tabbar
}

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict                         // webservice error case
{
    [self showAlertView:@"Error" WithMessage:[dict valueForKey:@"error_msg"]];

}


-(AppDelegate *)getInstance                                               // getting instance of appdelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
-(void)openTabBar                                                       // open tabbar
{
    AppDelegate *appDelegate=[self getInstance];
    [appDelegate openTabBar];
}


#pragma mark login button touch implementation
-(void)loginButtonTouched:(id)sender{                                   // touch hadler of login button
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark validation implementation
-(BOOL)checkValidation                                                  // check validation
{
    NSString *firstname;
    NSString *lastname;
    NSString *dateOfBirth;
    NSString *email;
    NSString *phoneNum;
    NSString *password;
    BOOL isValid;
    
    firstname = [firstNameTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(firstname.length >0)
    {
        isValid = YES;
    }
    else
    {
        isValid = NO;
        [self showAlertView:@"Error" WithMessage:@"Please enter all required fields"];
        return NO;
    }
    lastname = [lastNameTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(isValid && lastname.length >0)
    {
        isValid = YES;
       
    }
    else
    {
        isValid = NO;
        [self showAlertView:@"Error" WithMessage:@"Please enter all required fields"];
        return NO;

    }
    
    dateOfBirth = [dobNameTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(isValid && dateOfBirth.length >0)
    {
        isValid = YES;
        
    }
    else
    {
        isValid = NO;
        [self showAlertView:@"Error" WithMessage:@"Please enter all required fields"];
        return NO;

    }
    lastname = [lastNameTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(isValid && lastname.length >0)
    {
        isValid = YES;
        
    }
    else
    {
        isValid = NO;
        [self showAlertView:@"Error" WithMessage:@"Please enter all required fields"];
        return NO;
        
    }

    
    phoneNum = [phoneNumberTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(isValid && [utility NSStringIsValidPhoneNum:phoneNum])
    {
        isValid = YES;
    }
    else
    {
        isValid = NO;
        [self showAlertView:@"Error" WithMessage:@"Please enter valid Phone Number"];
        return NO;
        
    }
    
    email = [emailTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(isValid && [utility NSStringIsValidEmail:email])
    {
        isValid = YES;
    }
    else
    {
        isValid = NO;
        [self showAlertView:@"Error" WithMessage:@"Please enter valid Email."];
        return NO;
        
    }
    password = [passwordTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(isValid && password.length >0)
    {
        return YES;
    }
    else
    {
        isValid = NO;
        [self showAlertView:@"Error" WithMessage:@"Please enter all required fields"];
        return NO;
        
    }


    return NO;
}

#pragma mark alertview implementation

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

#pragma mark TextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    activeTextField = textField;
    
    if(datePickerView)
    {
        [self removeDatePicker1];
    }
}

#pragma mark datepicker implementation

-(void)openDatePicker
{
    if(activeTextField)
    {
         [activeTextField resignFirstResponder];    }
   
    if(!myDatePicker)
    {
        datePickerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 200  , self.view.frame.size.width ,200)];
        [datePickerView setBackgroundColor:[UIColor whiteColor]];
        myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,47, self.view.frame.size.width ,datePickerView.frame.size.height-47)];
        NSLog(@"%f",myDatePicker.frame.origin.y);
        // myDatePicker.minimumDate=[NSDate date];
        
        myDatePicker.datePickerMode = UIDatePickerModeDate;
        myDatePicker.backgroundColor = [UIColor whiteColor];
        [myDatePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
        
        datePickerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear: -18];
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        myDatePicker.maximumDate = maxDate;

        
        
        //        NSDate *now = [NSDate date];
        //        int daysToAdd = 1;
        //        NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
        
    }
    [self.view bringSubviewToFront:datePickerView];
    [self.view addSubview:datePickerView];
    [datePickerView addSubview:myDatePicker];
    [datePickerView bringSubviewToFront:myDatePicker];
    
    [self setupDoneButton:datePickerView];
    [self setupCancelButton:datePickerView];
    
}

-(void)setupDoneButton:(UIView *)view
{
    UIButton *doneButton = [[UIButton alloc]init];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self
                   action:@selector(onDoneTap:)forControlEvents:UIControlEventTouchUpInside];
    doneButton.frame = CGRectMake(self.view.frame.size.width -80, 3, 70 , 40);
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:doneButton];
    
}

-(void)setupCancelButton:(UIView *)view
{
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(onCancelTap:)forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake( 20, 3, 70 , 40);
    [view addSubview:cancelButton];
    
}

-(void)onDoneTap:(id)sender
{
    dob = myDatePicker.date;
    //previousMessageFutureDate  = futureDate;
    NSString *str = [self getDatePickerTimeStr];
    [self setDateOnLabel:str];
    [self removeDatePicker1];
    
    NSLog(@"Date = %@",str);
    myDatePicker = nil;
    
    
}
-(void)dateSelected:(id)sender
{
    
    //futureDate = myDatePicker.date;
}

-(void)removeDatePicker1 {
    
    [datePickerView removeFromSuperview];
    [myDatePicker removeFromSuperview];
    datePickerView =nil;
    myDatePicker  = nil;
}


-(void)setDateOnLabel:(NSString *)dateAndTime               // set date on textfield
{
    NSString * dateTimeString;
    if(dateAndTime)
    {
        dateTimeString = dateAndTime;
    }
    else
    {
       // dateTimeString = TTMFutureButton;
    }
    
    [dobNameTextfield setText:dateTimeString];
    
}


-(NSString *)getDatePickerTimeStr               // converting date to string format
{
    NSDateFormatter *dateSelected = [[NSDateFormatter alloc]init];
    dateSelected.dateFormat = @"MM/dd/YYYY";
    NSString *time =[dateSelected stringFromDate:dob];
    return time;
}

-(void)onCancelTap:(id)sender
{
    [self removeDatePicker1];
    dob = nil;
    
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
