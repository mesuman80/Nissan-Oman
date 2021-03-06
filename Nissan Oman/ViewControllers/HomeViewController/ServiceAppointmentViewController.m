//
//  ServiceAppointmentViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 22/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "ServiceAppointmentViewController.h"
#import "Constants.h"
#import "Common.h"
#import "WebService.h"

@interface ServiceAppointmentViewController ()<UITextFieldDelegate,CustomWebServiceDelegate,UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>

@end

@implementation ServiceAppointmentViewController
{
    BOOL isFirstTime;
    CGFloat yValue;
    NSMutableArray *serviceCentreArray;
    NSMutableArray *modelArray;
    NSArray *arrOfDict;
    UITableView *tableView;
    UITextField *activeField;
    UIScrollView *scrollView;
    CGFloat yVal;
    UITextField *previousTextField;
    UIButton *submitButton;
    NSArray *timeArray;
    
    NSMutableArray *dataFieldArr;
    
    NSDictionary *showRoomDict;
    NSArray *carDictArr;
    NSDictionary *carDict;
    
    UIView *datePickerView;
    UIDatePicker *myDatePicker;
    NSDate *dob;
    NSArray *arrVal;
    CGFloat tableCellHeight;
    UITextField *desiredTextField;
    Utility *utility;
}

#pragma mark view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    utility = [[Utility alloc]init];
    arrOfDict = [[NSMutableArray alloc]init];
    serviceCentreArray = [[NSMutableArray alloc]init];
    modelArray = [[NSMutableArray alloc]init];
    dataFieldArr = [[NSMutableArray alloc]init];
    isFirstTime = YES;
    tableCellHeight = 30;
    arrVal = @[@"SERVICE APPOINTMENT",@"SERVICE INFORMATION", @"PREFERRED TEST DRIVR DATE",@"SERVICE CENTRE LOCATION",@"VEHICLE REGISTRATION NO",@"MODEL OWNED",@"PREFERRED DATE", @"PREFERRED TIME SLOT",@"CURRENT ODOMETER READING",@"MOBILE NO",@"EMAIL"];
    
    timeArray = @[@"9:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00"];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackgroundTap)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tap gesture implementation

-(void)onBackgroundTap
{
    if(activeField)
    {
        [activeField resignFirstResponder];
    }
    if(tableView)
    {
        [tableView removeFromSuperview];
        tableView = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];

    [self addKeyBoardNotification];
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self gerServiceCentreData];
        [self getVehicleDropDown];
        [self addTitle];
        [self addSubTitle];
        [self drawForm];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeAllNotification];
    if(activeField)
    {
        [activeField resignFirstResponder];
    }
}

#pragma mark KeyBoardNotification
-(void)addKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void) keyboardWillShow:(NSNotification *)note             // keyboard up
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
        CGPoint scrollPoint = CGPointMake(0.0, point.y-kbSize.height  );
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}

-(void) keyboardWillHide:(NSNotification *)note                     // keyboard down
{
    NSLog(@"KeyBoard wiil Hide");
    UIEdgeInsets contentInsets=UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    //[doneView removeFromSuperview];
}

-(void)removeAllNotification                            // remove keyboard notifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark get service centre data

-(void)gerServiceCentreData
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"serviceCentre";
    [webService getServiceCentre];

}

#pragma mark get vehicle data

-(void)getVehicleDropDown
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"vehicleDropdown";
    [webService getVehicleDropDown];
    
}

#pragma mark connection delegates


-(void)ConnectionDidFinishWithError:(NSDictionary *)dict            // connection error case
{
    
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict           //connection success case
{
    if([dict isKindOfClass:[NSArray class]])                // for showroom
    {
        arrOfDict = (NSArray *)dict;
        int i = 0;
        for(NSDictionary *dict in arrOfDict)
        {
            NSString *str1 = [dict valueForKey:@"showroom_branch"];
            NSString *str2 = [dict valueForKey:@"showroom_address"];
            NSString *name = [NSString stringWithFormat:@"%@-%@",str1,str2];
            
            i++;
            
            [serviceCentreArray addObject:name];
        }
    }
    
    else
    {
        if([[dict valueForKey:@"serviceName"]isEqualToString:@"vehicleDropdown"])           // for vehicle
        {
            carDictArr = [dict valueForKey:@"dropDown"];
            int j=0;
            for(NSDictionary *dict in carDictArr)
            {
                NSString *name = [dict valueForKey:@"vehicle_name"];
                
                j++;
                
                [modelArray addObject:name];
            }
        }
        else if([[dict valueForKey:@"serviceName"]isEqualToString:@"serviceAppointment"])       // for service appointment
        {
            [self.navigationController popViewControllerAnimated:YES];
            [self showAlertView:nil WithMessage:@"Your request for Service Appointment is successfully submitted."];
            
        }
       
    }
    
}

#pragma mark ui rendering

-(void)addTitle             // add title
{
    yValue = self.yCordinate + 10;
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, yValue, screenWidth, screenHeight - yValue)];
    [scrollView setUserInteractionEnabled:YES];
    [scrollView setScrollEnabled:YES];
    [self.view addSubview:scrollView];
    yVal = 0;;
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yVal, 250, 30)];
    label.text = [arrVal objectAtIndex:0];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    [scrollView addSubview:label];
    
    yVal += label.frame.size.height + 10;
}

-(void)addSubTitle                  // add subtitle
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yVal, 250, 30)];
    label.text = [arrVal objectAtIndex:1];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:14.0f];
    [scrollView addSubview:label];
    
    yVal += label.frame.size.height + 8;
}


-(void)drawForm                 // draw form
{
    
    for(int i=2; i<arrVal.count; i++)
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
        texfield.returnKeyType = UIReturnKeyDefault;
        
        if([[arrVal objectAtIndex:i] isEqualToString:@"MOBILE NO"] || [[arrVal objectAtIndex:i] isEqualToString:@"CURRENT ODOMETER READING"] | [[arrVal objectAtIndex:i] isEqualToString:@"VEHICLE REGISTRATION NO"])
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
    
    [scrollView setContentSize:CGSizeMake(0, yVal + 50)];
    
}

-(void)addSubmitButton              // add submit button
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
        NSArray *arr = @[@"test_drive_date",@"service_centre_id",@"vehicle_reg_number",@"car_model",@"preferred_time_slot",@"current_odometer_reading",@"phone",@"email"];
        NSMutableArray *dataArr = [[NSMutableArray alloc]init];
        for(UITextField *textField in dataFieldArr)
        {
            NSString *str = textField.text;
            if(textField.tag == 5)
            {
                [dataArr addObject:[showRoomDict valueForKey:@"vehicle_id"]];
            }
            else if(textField.tag == 3)
            {
                [dataArr addObject:[carDict valueForKey:@"showroom_id"]];
                
            }
            else
            {
                [dataArr addObject:str];
            }
    }
        
        NSDictionary *dict = @{
                               [arr objectAtIndex:0] : [dataArr objectAtIndex:0],
                               [arr objectAtIndex:1] : [dataArr objectAtIndex:1],
                               [arr objectAtIndex:2] : [dataArr objectAtIndex:2],
                               [arr objectAtIndex:3] : [dataArr objectAtIndex:1],
                               [arr objectAtIndex:4] : [dataArr objectAtIndex:5],
                               [arr objectAtIndex:5] : [dataArr objectAtIndex:6],
                               [arr objectAtIndex:6] : [dataArr objectAtIndex:7],
                               [arr objectAtIndex:7] : [dataArr objectAtIndex:8]
                               };
        webService.serviceName = @"serviceAppointment";
        [webService requestServiceAppointment:dict];
    }
}

#pragma mark check validation

-(BOOL)isValidate{
    for(UITextField *textField in dataFieldArr)
    {
        NSString *str = textField.text;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(str.length >0)
        {
            if(textField.tag == 9)
            {
                if(![utility NSStringIsValidPhoneNum:textField.text])
                {
                    [self showAlertView:@"Error" WithMessage:@"Please enter Valid Phone Number"];
                    
                    return NO;
                }
            }
            
            if(textField.tag == 10)
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


#pragma mark Textfield delegate implementation
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 3 || textField.tag == 5 || textField.tag == 7)
    {
        [textField resignFirstResponder];
        desiredTextField = textField;
        if(datePickerView)
        {
            [self removeDatePicker1];
        }
        [self addTableView:textField];
        return NO;
        
    }
    if(textField.tag == 2 || textField.tag == 6)
    {
        desiredTextField = textField;
        if(tableView)
        {
            [tableView removeFromSuperview];
            tableView = nil;
        }
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
    else
    {
        [self removeDatePicker1];
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
    if( textField.tag == 8 || textField.tag == 9 || textField.tag == 4)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS_FOR_NUMBERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }

    return YES;
}

#pragma mark add tableview

-(void)addTableView:(UITextField *)texfield
{
    [activeField resignFirstResponder];
    if(!tableView)
    {
        CGFloat tableHeight;
        if(texfield.tag == 3)
        {
            if(serviceCentreArray.count >4)
            {
                tableHeight = .4*self.view.frame.size.height;
            }
            else
            {
                tableHeight = tableCellHeight *serviceCentreArray.count;
            }
        }
        else  if(texfield.tag == 5)
        {
            if(modelArray.count >4)
            {
                tableHeight = .4*self.view.frame.size.height;
            }
            else
            {
                tableHeight = tableCellHeight *modelArray.count;
            }
        }
        
        else  if(texfield.tag == 7)
        {
            if(timeArray.count >4)
            {
                tableHeight = .3*self.view.frame.size.height;
            }
            else
            {
                tableHeight = tableCellHeight *timeArray.count;
            }
        }
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(3, texfield.frame.origin.y + texfield.frame.size.height -2, texfield.frame.size.width - 6, tableHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:1.0];
        tableView.delegate = self;
        tableView.center = CGPointMake(screenWidth/2, tableView.center.y );
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.dataSource = self;
        [Common addBorderToUiView:tableView withBorderWidth:1.0f cornerRadius:0 Color:[UIColor lightGrayColor]];
    }
   // [scrollView setScrollEnabled:NO];
    [scrollView addSubview:tableView];
}

#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:tableView] || [touch.view isDescendantOfView:self.settingView.tableView]) {
        
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}

#pragma mark tableView Delegaes implementation


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Value rows");
    
    if(desiredTextField.tag == 3)
    {
        return serviceCentreArray.count;
    }
   else  if(desiredTextField.tag == 7)
    {
        return timeArray.count;
    }
    
    return modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentifierForReadReceipt = @"cellIdentifier";
    UITableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifierForReadReceipt];
    if(tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                     tableCellIdentifierForReadReceipt];
    }
    
    if(desiredTextField.tag == 3)
    {
        tableCell.textLabel.text =[serviceCentreArray objectAtIndex:indexPath.row];
    }
    else if(desiredTextField.tag == 7)
    {
        tableCell.textLabel.text =[timeArray objectAtIndex:indexPath.row];
    }
    else
    {
        tableCell.textLabel.text =[modelArray objectAtIndex:indexPath.row];
    }
    
    tableCell.textLabel.textColor = [UIColor darkGrayColor];
    tableCell.backgroundColor = [UIColor clearColor];
    tableCell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    
    
    return tableCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableCellHeight;
}



-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    NSString *name;
    
    //if(self.formType == RequestTypeQuote)
    //{
    if(desiredTextField.tag == 7)
    {
        name = [timeArray objectAtIndex:indexPath.row];
        
    }
    else if(desiredTextField.tag == 3)
    {
        name = [serviceCentreArray objectAtIndex:indexPath.row];
        carDict = [arrOfDict objectAtIndex:indexPath.row];
        
    }
    
    else
    {
        name = [modelArray objectAtIndex:indexPath.row];
        showRoomDict = [carDictArr objectAtIndex:indexPath.row];
    }
    
    desiredTextField.text = name;
    [desiredTextField resignFirstResponder];
    [desiredTextField endEditing:YES];
    
    [tableView removeFromSuperview];
    tableView = nil;
    
    
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
        myDatePicker.minimumDate=[NSDate date];
        
        myDatePicker.datePickerMode = UIDatePickerModeDate;
        myDatePicker.backgroundColor = [UIColor whiteColor];
        [myDatePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
        
        datePickerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        NSDate *now = [NSDate date];
        int daysToAdd = 1;
        NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
        myDatePicker.minimumDate = newDate1;
        
    }
    [self.view bringSubviewToFront:datePickerView];
    [self.view addSubview:datePickerView];
    [datePickerView addSubview:myDatePicker];
    [datePickerView bringSubviewToFront:myDatePicker];
    
    [self setupDoneButton:datePickerView];
    [self setupCancelButton:datePickerView];
    
}

-(void)setupDoneButton:(UIView *)view           // setting done button
{
    UIButton *doneButton = [[UIButton alloc]init];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self
                   action:@selector(onDoneTap:)forControlEvents:UIControlEventTouchUpInside];
    doneButton.frame = CGRectMake(self.view.frame.size.width -80, 3, 70 , 40);
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:doneButton];
    
}

-(void)setupCancelButton:(UIView *)view             // setting cancel button
{
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(onCancelTap:)forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake( 20, 3, 70 , 40);
    [view addSubview:cancelButton];
    
}

#pragma mark done button touch handler

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

}

-(void)removeDatePicker1 {              // removing date picker
    
    [datePickerView removeFromSuperview];
    [myDatePicker removeFromSuperview];
    datePickerView =nil;
    myDatePicker  = nil;
}


-(void)setDateOnLabel:(NSString *)dateAndTime               // setting date on label
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
    
    [desiredTextField setText:dateTimeString];
    
}


-(NSString *)getDatePickerTimeStr           // get string from date
{
    NSDateFormatter *dateSelected = [[NSDateFormatter alloc]init];
    dateSelected.dateFormat = @"MM/dd/YYYY";
    NSString *time =[dateSelected stringFromDate:dob];
    return time;
}

-(void)onCancelTap:(id)sender               // on cancel tap
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
