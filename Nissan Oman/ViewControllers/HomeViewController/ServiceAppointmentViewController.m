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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
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

-(void) keyboardWillShow:(NSNotification *)note
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

-(void) keyboardWillHide:(NSNotification *)note
{
    NSLog(@"KeyBoard wiil Hide");
    UIEdgeInsets contentInsets=UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    //[doneView removeFromSuperview];
}

-(void)removeAllNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)gerServiceCentreData
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"serviceCentre";
    [webService getServiceCentre];

}

-(void)getVehicleDropDown
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"vehicleDropdown";
    [webService getVehicleDropDown];
    
}

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict
{
    
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict
{
    if([dict isKindOfClass:[NSArray class]])
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
        if([[dict valueForKey:@"serviceName"]isEqualToString:@"vehicleDropdown"])
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
        else if([[dict valueForKey:@"serviceName"]isEqualToString:@"serviceAppointment"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            [self showAlertView:nil WithMessage:@"Your request for Service Appointment is successfully submitted."];
            
        }
       
    }
    
  /*  if([[dict valueForKey:@"serviceName"]isEqualToString:@"vehicleDropdown"])
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
    else
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

    }*/
}




-(void)addTitle
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

-(void)addSubTitle
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




-(void)drawForm
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
    
    [scrollView setContentSize:CGSizeMake(0, yVal + 50)];
    
}

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

-(BOOL)isValidate{
    /* NSString *carModel;
     NSString *firstName;
     NSString *lastName;
     NSString *poBox;
     NSString *pc;
     NSString *showRoom;
     NSString *email;
     NSString *phone; */
    for(UITextField *textField in dataFieldArr)
    {
        NSString *str = textField.text;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(str.length >0)
        {
            if(textField.tag == 10)
            {
                if(![self NSStringIsValidEmail:textField.text])
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


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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


#pragma Textfield delegate implementation
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    if(previousTextField)
    {
        [previousTextField resignFirstResponder];
        previousTextField = nil;
    }
    
    if(textField.tag == 3 || textField.tag == 5 || textField.tag == 7)
    {
        [textField resignFirstResponder];
        
        [self addTableView:textField];
        
    }
    if(textField.tag == 2 || textField.tag == 6)
    {
        if(previousTextField)
        {
            [previousTextField resignFirstResponder];
            previousTextField = nil;
        }
        else
        {
            [textField resignFirstResponder];
        }
        [self openDatePicker];
        
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
    return YES;
}




-(void)addTableView:(UITextField *)texfield
{
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
                tableHeight = .4*self.view.frame.size.height;
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
    if ([touch.view isDescendantOfView:tableView]) {
        
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}

#pragma Mark tableView Delegaes implementation


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Value rows");
    
    if(activeField.tag == 3)
    {
        return serviceCentreArray.count;
    }
   else  if(activeField.tag == 7)
    {
        return timeArray.count;
    }
    
    return modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Index pathn =%li" , indexPath.row);
    static NSString *tableCellIdentifierForReadReceipt = @"cellIdentifier";
    UITableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifierForReadReceipt];
    if(tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                     tableCellIdentifierForReadReceipt];
    }
    
    if(activeField.tag == 3)
    {
        tableCell.textLabel.text =[serviceCentreArray objectAtIndex:indexPath.row];
    }
    else if(activeField.tag == 7)
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
    NSLog(@"selected pathn =%li" , indexPath.row);
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    NSString *name;
    
    //if(self.formType == RequestTypeQuote)
    //{
    if(activeField.tag == 7)
    {
        name = [timeArray objectAtIndex:indexPath.row];
        
    }
    else if(activeField.tag == 3)
    {
        name = [serviceCentreArray objectAtIndex:indexPath.row];
        carDict = [arrOfDict objectAtIndex:indexPath.row];
        
    }
    
    else
    {
        name = [modelArray objectAtIndex:indexPath.row];
        showRoomDict = [carDictArr objectAtIndex:indexPath.row];
    }
    
    activeField.text = name;
    [activeField resignFirstResponder];
    [activeField endEditing:YES];
    
    [tableView removeFromSuperview];
    tableView = nil;
   // [scrollView setScrollEnabled:YES];

    
    // }
    
    
    
}

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
        
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:currentDate];
        
        
        NSDate *newDate = [calendar dateFromComponents: components];
        // [myDatePicker setMinimumDate:newDate];
        
        
        myDatePicker.datePickerMode = UIDatePickerModeDate;
        myDatePicker.backgroundColor = [UIColor whiteColor];
        [myDatePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
        
        datePickerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        
        
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


-(void)setDateOnLabel:(NSString *)dateAndTime
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
    CGSize size = [dateTimeString sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
    CGSize stringsize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    //or whatever font you're using
    
    [activeField setText:dateTimeString];
    
}


-(NSString *)getDatePickerTimeStr
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
