//
//  FeedbackViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 23/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "FeedbackViewController.h"
#import "WebService.h"
#import "Common.h"


@interface FeedbackViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,CustomWebServiceDelegate>

@end

@implementation FeedbackViewController
{
    CGFloat yCordinate;
    NSArray *arrVal;
    NSMutableArray *dataFieldArr;
    UIButton *submitButton;
    UITextView *activeField;
    UITextView *previousTextField;
    NSArray *carDictArr;
    NSMutableArray *modelArray;
    CGFloat tableCellHeight;
    UITableView *tableView;
    NSDictionary *showRoomDict;
    UITextView *desiredView;

}

#pragma mark view life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    arrVal = @[@"CUSTOMER NAME",@"SELECT CAR MODEL",@"FEEDBACK"];
    dataFieldArr = [[NSMutableArray alloc]init];
    modelArray = [[NSMutableArray alloc]init];
    tableCellHeight = 30;
    [self getVehicleDropDown];
    [self addTitle];
    [self addSubTitle];
    [self drawForm];
    // Do any additional setup after loading the view.
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

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict        // connection error case
{
    
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict          // connection success case
{
    if([[dict valueForKey:@"serviceName"]isEqualToString:@"vehicleDropdown"])       // for vehicle
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
    else  if([[dict valueForKey:@"serviceName"]isEqualToString:@"feedback"])        // for feedback
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self showAlertView:nil WithMessage:@"Your Feedback is successfully submitted."];
        
    }
    
}

#pragma mark ui rendering

-(void)addTitle             // add title
{
    yCordinate =  25 + self.navigationController.navigationBar.frame.size.height;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 200, 30)];
    label.text = @"FEEDBACK";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:22.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 20;
}

-(void)addSubTitle              // add subtitle
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 20)];
    label.text = @"SHARE YOUR FEEDBACKS/REVIEWS";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:17.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 20;
    
}

-(void)drawForm                 // draw form
{
    for(int i=0; i<arrVal.count; i++)
    {
        UITextView *texView = [[UITextView  alloc] initWithFrame:
                                 CGRectMake(0, yCordinate, self.view.frame.size.width*.90f, 40)];
        texView.center = CGPointMake(screenWidth/2, texView.center.y );
        [texView setFont:[UIFont boldSystemFontOfSize:10]];
        [texView setBackgroundColor:[UIColor whiteColor]];
        texView.textColor = [UIColor grayColor];
        [texView setTextAlignment:NSTextAlignmentLeft];
        //Placeholder text is displayed when no text is typed
        texView.text = [arrVal objectAtIndex:i];
        texView.layer.borderColor = [[UIColor blackColor]CGColor];
        texView.layer.borderWidth=1.0;
        texView.delegate = self;
        [self.view addSubview:texView];
        texView.tag = i;
        texView.returnKeyType = UIReturnKeyDefault;
        
        if(i == 0 || i== 1)
        {
            [texView setScrollEnabled:NO];
        }
        else
        {
            texView.frame = CGRectMake(0, yCordinate, self.view.frame.size.width*.90f, 100);
            texView.center = CGPointMake(screenWidth/2, texView.center.y );

        }
        
       // [texView setContentInset:UIEdgeInsetsMake(0, 0, -10,-10)];
       texView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        yCordinate += texView.frame.size.height + 3;
        
        [dataFieldArr addObject:texView];
    }
    
    yCordinate += 7;
    [self addSubmitButton];
    
    
}

-(void)addSubmitButton          // add submit button
{
    submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, yCordinate, self.view.frame.size.width*.90f, 35)];
    [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    submitButton.backgroundColor = buttonRedColor;
    submitButton.center = CGPointMake(screenWidth/2, submitButton.center.y );
    [self.view addSubview:submitButton];
    [submitButton addTarget:self action:@selector(submitRequest:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark submit button touch handler

-(void)submitRequest:(id)sender
{
    if([self isValidate])
    {
        WebService *webService = [[WebService alloc]init];
        webService.customWebServiceDelegate = self;
        NSArray *arr = @[@"car_model",@"name",@"feedback"];
        NSMutableArray *dataArr = [[NSMutableArray alloc]init];
        for(UITextField *textField in dataFieldArr)
        {
            NSString *str = textField.text;
            if(textField.tag == 1)
            {
                [dataArr addObject:[showRoomDict valueForKey:@"vehicle_id"]];
            }
           
            else
            {
                [dataArr addObject:str];
            }
            
            
        }
        
        NSDictionary *dict = @{
                               [arr objectAtIndex:0] : [dataArr objectAtIndex:1],
                               [arr objectAtIndex:1] : [dataArr objectAtIndex:0],
                               [arr objectAtIndex:2] : [dataArr objectAtIndex:2]
                               };
        webService.serviceName = @"feedback";
        [webService requestFeedback:dict];
    }
}


#pragma mark check validation

-(BOOL)isValidate{
    
    for(UITextView *textField in dataFieldArr)
    {
        NSString *str = textField.text;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(str.length >0)
        {
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

#pragma Textfield delegate implementation
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    if(textView.tag == 1 )
    {
        [textView resignFirstResponder];
        desiredView = textView;
        [self addTableView:textView];
        return NO;
        
    }
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    activeField = textView;
    if(textView.textColor == [UIColor grayColor])
    {
        textView.text = nil;
        textView.textColor = [UIColor blackColor];
    }
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


-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    previousTextField = textView;
    
    if(textView.text.length == 0)
    {
        textView.text = [arrVal objectAtIndex:textView.tag];
        textView.textColor = [UIColor grayColor];
    }
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    NSRange bottom = NSMakeRange(textView.text.length -1, 1);
    [textView scrollRangeToVisible:bottom];
    
    if(textView.tag == 0)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS_FOR_NAME] invertedSet];
        
        NSString *filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [text isEqualToString:filtered];
    }

    

    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    [textView scrollRangeToVisible:NSMakeRange(textView.text.length - 1,1)];
    
}

#pragma mark add tableview


-(void)addTableView:(UITextView *)texfield
{
    [activeField resignFirstResponder];
    if(!tableView)
    {
        CGFloat tableHeight;
        if(texfield.tag == 1)
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
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(3, texfield.frame.origin.y + texfield.frame.size.height -2, texfield.frame.size.width - 6, tableHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:1.0];
        tableView.delegate = self;
        tableView.center = CGPointMake(screenWidth/2, tableView.center.y );
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.dataSource = self;
        [Common addBorderToUiView:tableView withBorderWidth:1.0f cornerRadius:0 Color:[UIColor lightGrayColor]];
    }
    // [scrollView setScrollEnabled:NO];
    [self.view addSubview:tableView];
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

#pragma mark tableView Delegaes implementation


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    
    tableCell.textLabel.text =[modelArray objectAtIndex:indexPath.row];
    
    
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
    
    name = [modelArray objectAtIndex:indexPath.row];
    showRoomDict = [carDictArr objectAtIndex:indexPath.row];
    
    desiredView.text = name;
    [desiredView resignFirstResponder];
    desiredView.textColor = [UIColor blackColor];
    [desiredView endEditing:YES];
    
    [tableView removeFromSuperview];
    tableView = nil;
    
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
