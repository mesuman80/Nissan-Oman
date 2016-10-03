//
//  AdventureParkViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 22/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "AdventureParkViewController.h"
#import "Constants.h"
#import "Common.h"
#import "WebService.h"

@interface AdventureParkViewController ()<UITextFieldDelegate,CustomWebServiceDelegate,UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>

@end

@implementation AdventureParkViewController
{
    BOOL isFirstTime;
    CGFloat yValue;
    NSMutableArray *carArray;
    NSMutableArray *showRoomArray;
    NSMutableArray *arrOfDict;
    UITableView *tableView;
    UITextField *activeField;
    UIScrollView *scrollView;
    CGFloat yVal;
    UITextField *previousTextField;
    UIButton *submitButton;

   
    NSMutableArray *dataFieldArr;
    
    NSDictionary *showRoomDict;
    NSArray *carDictArr;
    NSDictionary *carDict;
    
    UIView *datePickerView;
    UIDatePicker *myDatePicker;
    NSDate *dob;
    UITextField *desiredField;
    Utility *utility;

}
@synthesize arrVal;

#pragma mark life cycle service

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    utility = [[Utility alloc]init];
    arrOfDict = [[NSMutableArray alloc]init];
    carArray = [[NSMutableArray alloc]init];
    showRoomArray = [[NSMutableArray alloc]init];
    dataFieldArr = [[NSMutableArray alloc]init];
    isFirstTime = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackgroundTap)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    
    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addKeyBoardNotification];
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self getVehicleDropDown];
        [self getShowroomBranchData];
        [self addTitle];
        [self drawLogoVal];
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

#pragma mark gesture implementation

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

#pragma mark view rendering functions

-(void)addTitle
{
    yValue = self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yValue, 250, 30)];
    label.text = @"ADVENTURE PARK";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:22.0f];
    [self.view addSubview:label];
    
    yValue += label.frame.size.height +3;
}

-(void)drawLogoVal
{
    //bottombar.png
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, yValue, 150, 30)];
    imgView.image = [UIImage imageNamed:@"bottombar.png"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.center = CGPointMake(self.view.frame.size.width/2, imgView.center.y);
    [self.view addSubview:imgView];
    
    yValue += imgView.frame.size.height + 10;
}

-(void)drawForm
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, yValue, screenWidth, screenHeight - yValue- 70)];
    [scrollView setUserInteractionEnabled:YES];
    [scrollView setScrollEnabled:YES];
    [self.view addSubview:scrollView];
    yVal = 0;;
    for(int i=1; i<arrVal.count; i++)
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
    
    yVal += 10;
    [self addSubmitButton];
    
    [scrollView setContentSize:CGSizeMake(0, yVal)];
    
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

#pragma mark Submit buttob click functionality


-(void)submitRequest:(id)sender
{
    if([self isValidate])                       // Form validation
    {
        WebService *webService = [[WebService alloc]init];
        webService.customWebServiceDelegate = self;
        NSArray *arr = @[@"name",@"showroom_id",@"email",@"phone",@"test_drive_date"];
        NSMutableArray *dataArr = [[NSMutableArray alloc]init];
        for(UITextField *textField in dataFieldArr)
        {
            NSString *str = textField.text;
            if(textField.tag == 4)
            {
                [dataArr addObject:[showRoomDict valueForKey:@"showroom_id"]];
            }
            else if(textField.tag == 1)
            {
                [dataArr addObject:[carDict valueForKey:@"vehicle_id"]];
                
            }
            else
            {
                [dataArr addObject:str];
            }
            
            
        }
        
        NSDictionary *dict = @{
                               [arr objectAtIndex:0] : [dataArr objectAtIndex:0],
                               [arr objectAtIndex:1] : [dataArr objectAtIndex:3],
                               [arr objectAtIndex:2] : [dataArr objectAtIndex:2],
                               [arr objectAtIndex:3] : [dataArr objectAtIndex:1],
                               [arr objectAtIndex:4] : [dataArr objectAtIndex:4]
                               };
        webService.serviceName = @"adventurePark";
        [webService requestAdventurePark:dict];
    }
}

#pragma mark check the validation of textfields

-(BOOL)isValidate{
    for(UITextField *textField in dataFieldArr)
    {
        NSString *str = textField.text;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];        // removing blanck space if any
        if(str.length >0)
        {
            if(textField.tag == 2)                  // checking phn number validation
            {
                if(![utility NSStringIsValidPhoneNum:textField.text])
                {
                    [self showAlertView:@"Error" WithMessage:@"Please enter Valid Phone Number"];
                    
                    return NO;
                }
            }
            if(textField.tag == 3)                  // checking email validation
            {
                if(![utility NSStringIsValidEmail:textField.text])
                {
                    [self showAlertView:@"Error" WithMessage:@"Please enter Valid Email address"];
                    
                    return NO;
                }
            }
        }
        else
        {
            [self showAlertView:@"Error" WithMessage:@"Please enter all required fields"];
            return NO;
        }
    }
    
    
    return YES;
}


-(void)showAlertView:(NSString *)title WithMessage:(NSString *)msg          //showing alert view
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

-(void)getShowroomBranchData                // web service calling for showroom
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"showroomAddress";
    [webService getShowroomAddress];
    
}

-(void)getVehicleDropDown                        // web service calling for vehicle drop down
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"vehicleDropdown";
    [webService getVehicleDropDown];
    
}

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict        // if any error comes
{
    
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict      // delegate for success
{
    if(dict.count == 1)                                         // for showroom success
    {
        arrOfDict = [dict valueForKey:@"showroom_address"];
        int i = 0;
        for(NSDictionary *dict in arrOfDict)
        {
            NSString *name = [dict valueForKey:@"showroom_address"];
            
            i++;
            
            [showRoomArray addObject:name];
        }
        
    }
    
    else
    {
        if([[dict valueForKey:@"serviceName"]isEqualToString:@"vehicleDropdown"])       //for vehicle drop down success
        {
            carDictArr = [dict valueForKey:@"dropDown"];
            int j=0;
            for(NSDictionary *dict in carDictArr)
            {
                NSString *name = [dict valueForKey:@"vehicle_name"];
                
                j++;
                
                [carArray addObject:name];
            }
        }
        
        else if([[dict valueForKey:@"serviceName"]isEqualToString:@"adventurePark"])        //for adventure park success
        {
            [self.navigationController popViewControllerAnimated:YES];
            [self showAlertView:nil WithMessage:@"Your request for Adventure Park is successfully submitted."];
            
        }
        
        //  [self addTableView];
    }
    
}

#pragma Textfield delegate implementation

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 1 || textField.tag == 4)        // If textfield is either name of location
    {
        [textField resignFirstResponder];
        desiredField = textField;
        if(datePickerView)                              // if any datepicker is there, remove it
        {
            [self removeDatePicker1];
        }
        [self addTableView:textField];                  // add tableview
        return NO;
        
    }
    if(textField.tag == 5)                              // if textfield is test drive date
    {
        [textField resignFirstResponder];
        desiredField = textField;
        if(tableView)                                    // if tableview, remove it
        {
            [tableView removeFromSuperview];
            tableView = nil;
        }
        [self openDatePicker];                          // open date picker
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
    if([string isEqualToString:@"\n"])          // for return key
    {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)addTableView:(UITextField *)texfield
{
    [activeField resignFirstResponder];
    if(!tableView)
    {
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(3, texfield.frame.origin.y + texfield.frame.size.height -2, texfield.frame.size.width - 6, .4*self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:1.0];
        tableView.delegate = self;
        tableView.center = CGPointMake(screenWidth/2, tableView.center.y );
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.dataSource = self;
        [Common addBorderToUiView:tableView withBorderWidth:1.0f cornerRadius:0 Color:[UIColor lightGrayColor]];
    }
    
    [scrollView addSubview:tableView];
}

#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:tableView] || [touch.view isDescendantOfView:self.settingView.tableView]) {
        
        return NO;                  // to disable gesture if table view is there
    }
    
    return YES;
}

#pragma Mark tableView Delegaes implementation


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Value rows");
    
    if(desiredField.tag == 1)
    {
        return carArray.count;          // for car model array
    }
    
    return showRoomArray.count;          // for showroom array
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentifierForReadReceipt = @"cellIdentifier";
    UITableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifierForReadReceipt];
    if(tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                     tableCellIdentifierForReadReceipt];
    }
    
    if(desiredField.tag == 1)
    {
        tableCell.textLabel.text =[carArray objectAtIndex:indexPath.row];
    }
    else
    {
        tableCell.textLabel.text =[showRoomArray objectAtIndex:indexPath.row];
    }
    
    tableCell.textLabel.textColor = [UIColor darkGrayColor];
    tableCell.backgroundColor = [UIColor clearColor];
    tableCell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    
    
    return tableCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}



-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    NSString *name;
    
    //if(self.formType == RequestTypeQuote)
    //{
    if(desiredField.tag == 1)               //for car model
    {
        name = [carArray objectAtIndex:indexPath.row];
        carDict = [carDictArr objectAtIndex:indexPath.row];
        
    }
    else                                    // for showroom
    {
        name = [showRoomArray objectAtIndex:indexPath.row];
        showRoomDict = [arrOfDict objectAtIndex:indexPath.row];
    }
    
    desiredField.text = name;
    [desiredField resignFirstResponder];
    [activeField endEditing:YES];
    
    [tableView removeFromSuperview];
    tableView = nil;
    
    
    // }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark datepicker delegate

-(void)openDatePicker
{
    if(activeField)
    {
        [activeField resignFirstResponder];

    }
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

-(void)setupDoneButton:(UIView *)view               // done button ui
{
    UIButton *doneButton = [[UIButton alloc]init];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self
                   action:@selector(onDoneTap:)forControlEvents:UIControlEventTouchUpInside];
    doneButton.frame = CGRectMake(self.view.frame.size.width -80, 3, 70 , 40);
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:doneButton];
    
}

-(void)setupCancelButton:(UIView *)view         // cancel button ui
{
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(onCancelTap:)forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake( 20, 3, 70 , 40);
    [view addSubview:cancelButton];
    
}

-(void)onDoneTap:(id)sender                 // on tap of done button
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

-(void)removeDatePicker1 {                  // remove datepicker
    
    [datePickerView removeFromSuperview];
    [myDatePicker removeFromSuperview];
    datePickerView =nil;
    myDatePicker  = nil;
}


-(void)setDateOnLabel:(NSString *)dateAndTime               // set date on given textfield
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
    //CGSize size = [dateTimeString sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
    //CGSize stringsize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    //or whatever font you're using
    
    [desiredField setText:dateTimeString];
    
}


-(NSString *)getDatePickerTimeStr           // get string form date
{
    NSDateFormatter *dateSelected = [[NSDateFormatter alloc]init];
    dateSelected.dateFormat = @"MM/dd/YYYY";
    NSString *time =[dateSelected stringFromDate:dob];
    return time;
}


-(void)onCancelTap:(id)sender               // on tap of cancel button
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
