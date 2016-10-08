//
//  AccountSettingViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 24/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "WebService.h"

@interface AccountSettingViewController ()<UITextFieldDelegate,CustomWebServiceDelegate,UIGestureRecognizerDelegate>

@end

@implementation AccountSettingViewController
{
    CGFloat yCordinate;
    NSArray *arrVal;
    NSMutableArray *dataFieldArr;
    UIScrollView *scrollView;
    UIButton *submitButton;
    UITextField *previousTextField;
    UITextField *activeField;
    UIView *datePickerView;
    UIDatePicker *myDatePicker;
    NSDate *dob;
    UITextField *dateField;
    CGFloat yVal;
    Utility *utility;
    BOOL isFirstTime;


}

#pragma mark view life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    utility = [[Utility alloc]init];
    arrVal = @[PlaceholderSignupFirstNameString,PlaceholderSignupLastNameString,PlaceholderSignupDobString,PlaceholderMobileNo,PLaceholderEmail];
    dataFieldArr = [[NSMutableArray alloc]init];
    isFirstTime = YES;
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackgroundTap)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    
    // Do any additional setup after loading the view.
}

#pragma mark tap gesture implementation

-(void)onBackgroundTap
{
    if(activeField)
    {
        [activeField resignFirstResponder];
    }
    if(datePickerView)
    {
        [self removeDatePicker1];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self addTitle];
        [self addSubTitle];
        [self drawForm];

    }
    
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

-(void) keyboardWillShow:(NSNotification *)note                 // keyboard up
{
    NSLog(@"self.frame %f", self.view.frame.size.height);
    
    NSDictionary* info = [note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint point= CGPointZero;
    // [scrollView setContentSize:CGSizeMake (scrollView.frame.size.width,scrollView.contentSize.height)];
    
    NSLog(@"self.frame %f", self.view.frame.size.height);
    point = CGPointMake(activeField.frame.origin.x, activeField.superview.frame.origin.y + activeField.frame.origin.y);
    if (!CGRectContainsPoint(aRect,point))
    {
        CGPoint scrollPoint = CGPointMake(0.0, point.y-kbSize.height - 10 );
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}

-(void) keyboardWillHide:(NSNotification *)note                      // keyboard down
{
    NSLog(@"KeyBoard wiil Hide");
    UIEdgeInsets contentInsets=UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    //[doneView removeFromSuperview];
}

-(void)removeAllNotification                                // remove keyboard notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark ui rendering

-(void)addTitle                             // add title
{
    yCordinate =  self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 250, 30)];
    label.text = @"ACCOUNT SETTINGS";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:22.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 20;
}

-(void)addSubTitle                          // add subtitle
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 20)];
    label.text = @"USER PROFILE";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:17.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 20;
    
}
-(void)drawForm                             // add form
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, yCordinate, screenWidth, screenHeight - yCordinate)];
    [scrollView setUserInteractionEnabled:YES];
    [scrollView setScrollEnabled:YES];
    [self.view addSubview:scrollView];
    yVal = 0;;

    for(int i=0; i<arrVal.count; i++)
    {
        UITextField *texfield = [[UITextField  alloc] initWithFrame:
                                 CGRectMake(0, yVal, self.view.frame.size.width*.90f, 40)];
        texfield.center = CGPointMake(screenWidth/2, texfield.center.y );
        [texfield setFont:[UIFont boldSystemFontOfSize:10]];
        [texfield setBackgroundColor:[UIColor whiteColor]];
        texfield.textColor = [UIColor blackColor];
        [texfield setTextAlignment:NSTextAlignmentLeft];
        //Placeholder text is displayed when no text is typed
        texfield.placeholder = [arrVal objectAtIndex:i];
        texfield.layer.borderColor = [[UIColor blackColor]CGColor];
        texfield.layer.borderWidth=1.0;
        texfield.delegate = self;
        [scrollView addSubview:texfield];
        texfield.tag = i;
        if(i == 2)
        {
            //texfield.delegate = nil;
            [texfield setUserInteractionEnabled:YES];
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openDatePicker)];
            [texfield addGestureRecognizer:gesture];
        }

        texfield.returnKeyType = UIReturnKeyDefault;
        
        if([[arrVal objectAtIndex:i] isEqualToString:@"MOBILE NO"])
        {
            texfield.keyboardType = UIKeyboardTypePhonePad;
        }
        if([[arrVal objectAtIndex:i] isEqualToString:@"EMAIL"])
        {
            texfield.keyboardType = UIKeyboardTypeEmailAddress;
        }
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        texfield.leftView = leftView;
        texfield.leftViewMode = UITextFieldViewModeAlways;
        
        yVal += texfield.frame.size.height + 3;
        
        [dataFieldArr addObject:texfield];
    }
    
    yVal += 7;
    [self addSubmitButton];
    
    [scrollView setContentSize:CGSizeMake(0, yVal)];
    
}

#pragma mark add submit button

-(void)addSubmitButton
{
    submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, yVal, self.view.frame.size.width*.90f, 35)];
    [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    submitButton.backgroundColor = buttonRedColor;
    submitButton.center = CGPointMake(screenWidth/2, submitButton.center.y );
    [scrollView addSubview:submitButton];
    [submitButton addTarget:self action:@selector(submitRequest:) forControlEvents:UIControlEventTouchUpInside];
    yVal += submitButton.frame.size.height + 3;
}

#pragma mark submit button touch handler

-(void)submitRequest:(id)sender
{
    if([self isValidate])
    {
        WebService *webService = [[WebService alloc]init];
        webService.customWebServiceDelegate = self;
        NSArray *arr = @[@"name",@"email",@"phone",@"dob"];
        NSMutableArray *dataArr = [[NSMutableArray alloc]init];
        for(UITextField *textField in dataFieldArr)
        {
            NSString *str = textField.text;
            [dataArr addObject:str];
            
        }
        
        NSDictionary *dict = @{
                               [arr objectAtIndex:0] : [dataArr objectAtIndex:0],
                               [arr objectAtIndex:1] : [dataArr objectAtIndex:4],
                               [arr objectAtIndex:2] : [dataArr objectAtIndex:3],
                               [arr objectAtIndex:3] : [dataArr objectAtIndex:2]
                               
                               };
        webService.serviceName = @"accountSettings";
        [webService accountSettings:dict];

    }
}

#pragma mark connection delegates

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict            // connection error case
{
    
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict              // connection success case
{
    if([[dict valueForKey:@"serviceName"]isEqualToString:@"accountSettings"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self showAlertView:nil WithMessage:@"Your profile is updated."];
        
    }
        
        //  [self addTableView];
    
}

#pragma mark check validation


-(BOOL)isValidate{
    for(UITextField *textField in dataFieldArr)
    {
        NSString *str = textField.text;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(str.length >0)
        {
            if(textField.tag == 3)
            {
                if(![utility NSStringIsValidPhoneNum:textField.text])
                {
                    [self showAlertView:@"Error" WithMessage:@"Please enter Valid Phone Number"];
                    
                    return NO;
                }
            }
            if(textField.tag == 4)
            {
                if(![utility NSStringIsValidEmail:textField.text])
                {
                    [self showAlertView:@"Error" WithMessage:@"Please enter Valid Email address"];
                    
                    return NO;
                }
            }
            //return YES;
        }
        else
        {
            [self showAlertView:@"Error" WithMessage:@"Please enter all required fields"];
            return NO;
        }
    }
    
    
    return YES;
}

#pragma mark show alertview

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


#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.settingView.tableView]) {
        
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}


#pragma mark Textfield delegate implementation
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 2)
    {
        dateField = textField;
         [self openDatePicker];
        return NO;
       
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    if(previousTextField)
    {
        [previousTextField resignFirstResponder];
        previousTextField = nil;
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    previousTextField = textField;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        

    }
    if(textField.tag == 0 || textField.tag == 1)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS_FOR_NAME] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    else if(textField.tag == 3)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS_FOR_NUMBERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    
    return YES;
}

#pragma mark datepicker implementation

-(void)openDatePicker
{
    [activeField resignFirstResponder];
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

-(void)setupDoneButton:(UIView *)view           // setting up done button
{
    UIButton *doneButton = [[UIButton alloc]init];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self
                   action:@selector(onDoneTap:)forControlEvents:UIControlEventTouchUpInside];
    doneButton.frame = CGRectMake(self.view.frame.size.width -80, 3, 70 , 40);
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:doneButton];
    
}

-(void)setupCancelButton:(UIView *)view             // setting up cancel button
{
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(onCancelTap:)forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake( 20, 3, 70 , 40);
    [view addSubview:cancelButton];
    
}

-(void)onDoneTap:(id)sender             // done tap implementation
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

-(void)removeDatePicker1 {          // removing date picker
    
    [datePickerView removeFromSuperview];
    [myDatePicker removeFromSuperview];
    datePickerView =nil;
    myDatePicker  = nil;
}


-(void)setDateOnLabel:(NSString *)dateAndTime           // setting date on label
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

    
    [dateField setText:dateTimeString];
    
}


-(NSString *)getDatePickerTimeStr           // get string from date
{
    NSDateFormatter *dateSelected = [[NSDateFormatter alloc]init];
    dateSelected.dateFormat = @"MM/dd/YYYY";
    NSString *time =[dateSelected stringFromDate:dob];
    return time;
}

-(void)onCancelTap:(id)sender           // cancel button tap
{
    [self removeDatePicker1];
    dob = nil;
    
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
