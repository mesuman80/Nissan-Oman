//
//  RequestFormViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 19/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "RequestFormViewController.h"
#import "Constants.h"
#import "Common.h"
#import "WebService.h"

@interface RequestFormViewController ()<UITextFieldDelegate,CustomWebServiceDelegate,UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>

@end

@implementation RequestFormViewController
{
    BOOL isFirstTime;
    CGFloat yCordinate;
    NSMutableArray *carArray;
    NSMutableArray *showRoomArray;
    NSMutableArray *arrOfDict;
    UITableView *tableView;
    UITextField *activeField;
    UIScrollView *scrollView;
    CGFloat yVal;
    UITextField *previousTextField;
    UIButton *radiobutton1;
    UIButton *radiobutton2;
    UIButton *submitButton;
    NSMutableArray *dataFieldArr;
    NSDictionary *showRoomDict;
    NSArray *carDictArr;
    NSDictionary *carDict;
    UITextField *desiredField;
    Utility *utility;

}
@synthesize arrVal;

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
  //  gesture.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:gesture];
    // Do any additional setup after loading the view.
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
    [self addKeyBoardNotification];
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self getVehicleDropDown];
        [self getShowroomBranchData];
        [self addTitle];
        [self drawForm];
        
        if(self.formType == RequestTypeQuote)
        {
            
        }
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



-(void)addTitle
{
    yCordinate = self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 250, 30)];
    label.text = [arrVal objectAtIndex:0];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:22.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height +3;
}

-(void)drawForm
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, yCordinate, screenWidth, screenHeight - yCordinate- 70)];
    [scrollView setUserInteractionEnabled:YES];
    [scrollView setScrollEnabled:YES];
    [self.view addSubview:scrollView];
   // [scrollView setBackgroundColor:[UIColor redColor]];
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
        
        if([[arrVal objectAtIndex:i] isEqualToString:@"PHONE"])
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
    [self drawSuggestionLabel];
    [self radioButton];
    [self addSubmitButton];
    
    [scrollView setContentSize:CGSizeMake(0,yVal)];

}

-(void)drawSuggestionLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yVal, self.view.frame.size.width*.85f, 50)];
    label.text = @"Would you like to receive future product news and announcements from Nissan via e-mail?";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    yVal += label.frame.size.height ;
    [scrollView addSubview:label];
    

    
}
-(void) radioButton{
    
    //radio buttons
    radiobutton1 = [[UIButton alloc] initWithFrame:CGRectMake(.30*scrollView.frame.size.width,yVal,20,20)];
    [radiobutton1 setTag:0];
    
    //[radiobutton1 setTitle:@"Female" forState:UIControlStateSelected];
    [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"Radio_button_off.png"] forState:UIControlStateNormal];
    [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"Radio_button_on.png"] forState:UIControlStateSelected];
    [radiobutton1 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *yesLabel=[[UILabel alloc]init];
    yesLabel.textColor=[UIColor lightGrayColor];
    NSString *str = @"Yes";
    CGSize displayValueSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    yesLabel.font=[UIFont systemFontOfSize:12.0f];
    yesLabel.text=str;
    yesLabel.frame=CGRectMake(.37*scrollView.frame.size.width,yVal + 3,displayValueSize.width,displayValueSize.height);
    [yesLabel sizeToFit];
    [scrollView addSubview:yesLabel];
    
    
    
    
    
    radiobutton2 = [[UIButton alloc] initWithFrame:CGRectMake(.55*scrollView.frame.size.width,yVal,20,20)];
    [radiobutton2 setTag:1];
    [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"Radio_button_off.png"] forState:UIControlStateNormal];
    [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"Radio_button_on.png"] forState:UIControlStateSelected];
    [radiobutton2 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *noLabel=[[UILabel alloc]init];
    noLabel.textColor=[UIColor lightGrayColor];
    NSString *str1 = @"NO";
    CGSize displayValueSize1 = [str1 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    noLabel.font=[UIFont systemFontOfSize:12.0f];
    noLabel.text=str1;
    noLabel.frame=CGRectMake(.62*scrollView.frame.size.width,yVal + 3,displayValueSize1.width,displayValueSize1.height);
    [noLabel sizeToFit];
    [scrollView addSubview:noLabel];
    
    
    [scrollView addSubview:radiobutton1];
    [scrollView addSubview:radiobutton2];
    
    yVal += noLabel.frame.size.height + 10;
}

-(void)radiobuttonSelected:(id)sender{
    switch ([sender tag]) {
        case 0:
            if([radiobutton1 isSelected]==YES)
            {
                [radiobutton1 setSelected:NO];
                [radiobutton2 setSelected:YES];
            }
            else{
                [radiobutton1 setSelected:YES];
                [radiobutton2 setSelected:NO];
            }
            
            break;
        case 1:
            if([radiobutton2 isSelected]==YES)
            {
                [radiobutton2 setSelected:NO];
                [radiobutton1 setSelected:YES];
            }
            else
            {
                [radiobutton2 setSelected:YES];
                [radiobutton1 setSelected:NO];
            }
            
            break;
        default:
            break;
    }
    
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
       if(self.formType == RequestTypeBrochure || self.formType == RequestTypeQuote)
       {
           WebService *webService = [[WebService alloc]init];
           webService.customWebServiceDelegate = self;
           NSArray *arr = @[@"car_model",@"first_name",@"last_name",@"showroom_id",@"email",@"phone"];
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
                                  [arr objectAtIndex:1] : [dataArr objectAtIndex:1],
                                  [arr objectAtIndex:2] : [dataArr objectAtIndex:2],
                                  [arr objectAtIndex:3] : [dataArr objectAtIndex:3],
                                  [arr objectAtIndex:4] : [dataArr objectAtIndex:4],
                                  [arr objectAtIndex:5] : [dataArr objectAtIndex:5]
                                  };
           if(self.formType == RequestTypeBrochure)
           {
               webService.serviceName = @"requestBrochure";
               [webService requestBrochure:dict];

           }
           else if(self.formType == RequestTypeQuote)
           {
               webService.serviceName = @"requestQuote";
               [webService requestQuote:dict];

           }
    }
       
       else if(self.formType == RequestTypeTestDrive)
       {
           WebService *webService = [[WebService alloc]init];
           webService.customWebServiceDelegate = self;
           NSArray *arr = @[@"car_model",@"first_name",@"last_name",@"p_o_box",@"pc",@"showroom_id",@"email",@"phone"];
           NSMutableArray *dataArr = [[NSMutableArray alloc]init];
           for(UITextField *textField in dataFieldArr)
           {
               NSString *str = textField.text;
               if(textField.tag == 6)
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
                                  [arr objectAtIndex:1] : [dataArr objectAtIndex:1],
                                  [arr objectAtIndex:2] : [dataArr objectAtIndex:2],
                                  [arr objectAtIndex:3] : [dataArr objectAtIndex:3],
                                  [arr objectAtIndex:4] : [dataArr objectAtIndex:4],
                                  [arr objectAtIndex:5] : [dataArr objectAtIndex:5],
                                  [arr objectAtIndex:6] : [dataArr objectAtIndex:6],
                                  [arr objectAtIndex:7] : [dataArr objectAtIndex:7]
                                  };
            webService.serviceName = @"requestTestDrive";
           [webService requestTestDrive:dict];
               
        

       }
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
           if(self.formType == RequestTypeBrochure || self.formType == RequestTypeQuote)
           {
               if(textField.tag == 5)
               {
                   if(![utility NSStringIsValidEmail:textField.text])
                   {
                       [self showAlertView:@"Error" WithMessage:@"Please enter Valid Email address"];
                       
                       return NO;
                   }
               }
               if(textField.tag == 6)
               {
                   if(![utility NSStringIsValidPhoneNum:textField.text])
                   {
                       [self showAlertView:@"Error" WithMessage:@"Please enter Valid Phone Number"];
                       
                       return NO;
                   }
               }

           }
           else if(self.formType == RequestTypeTestDrive)
           {
               if(textField.tag == 7)
               {
                   if(![utility NSStringIsValidEmail:textField.text])
                   {
                       [self showAlertView:@"Error" WithMessage:@"Please enter Valid Email address"];
                       
                       return NO;
                   }
               }
               if(textField.tag == 8)
               {
                   if(![utility NSStringIsValidPhoneNum:textField.text])
                   {
                       [self showAlertView:@"Error" WithMessage:@"Please enter Valid Phone Number"];
                       
                       return NO;
                   }
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

-(void)getShowroomBranchData
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"showroomAddress";
    [webService getShowroomAddress];
    
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
    //if()
    if(dict.count == 1)
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
        if([[dict valueForKey:@"serviceName"]isEqualToString:@"vehicleDropdown"])
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
        
        else if([[dict valueForKey:@"serviceName"]isEqualToString:@"requestQuote"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            [self showAlertView:nil WithMessage:@"Your request for Quote is successfully submitted."];

        }
        else if([[dict valueForKey:@"serviceName"]isEqualToString:@"requestBrochure"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            [self showAlertView:nil WithMessage:@"Your request for Brochure is successfully submitted."];

        }
        else if([[dict valueForKey:@"serviceName"]isEqualToString:@"requestTestDrive"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            [self showAlertView:nil WithMessage:@"Your request for Test Drive is successfully submitted."];
            
        }

        //  [self addTableView];
    }

}

#pragma Textfield delegate implementation

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(self.formType == RequestTypeTestDrive)
    {
        if(textField.tag == 1 || textField.tag == 6)
        {
            [textField resignFirstResponder];
            desiredField = textField;
            [self addTableView:textField];
            return NO;
            
        }
    }
    else
    {
        if(textField.tag == 1 || textField.tag == 4)
        {
            [textField resignFirstResponder];
            desiredField = textField;
            [self addTableView:textField];
            return NO;
            
        }
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
    
    if(tableView)
    {
        [tableView removeFromSuperview];
        tableView = nil;
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
    
    if(desiredField.tag == 1)
    {
        return carArray.count;
    }
    
    return showRoomArray.count;
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
    NSLog(@"selected pathn =%li" , indexPath.row);
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    NSString *name;
    
    //if(self.formType == RequestTypeQuote)
    //{
        if(desiredField.tag == 1)
        {
            name = [carArray objectAtIndex:indexPath.row];
            carDict = [carDictArr objectAtIndex:indexPath.row];

        }
        else
        {
            name = [showRoomArray objectAtIndex:indexPath.row];
            showRoomDict = [arrOfDict objectAtIndex:indexPath.row];
        }
        
        desiredField.text = name;
        [desiredField endEditing:YES];
        
        [tableView removeFromSuperview];
        tableView = nil;


   // }
}

- (void)didReceiveMemoryWarning
{
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
