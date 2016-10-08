//
//  ShowroomViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 15/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "ShowroomViewController.h"
#import "WebService.h"
#import "Common.h"
#import "Constants.h"
#import "MapViewController.h"


@interface ShowroomViewController ()<UITextFieldDelegate,CustomWebServiceDelegate,UITableViewDelegate, UITableViewDataSource>

@end

@implementation ShowroomViewController
{
    CGFloat yCordinate;
    BOOL isFirstTime;
    UITextField *texfield;
    NSMutableArray *dataArr;
    UITableView *tableView;
    UIButton *submitButton;
    NSArray *arrOfDict;
    NSDictionary *dictSelected;
    CGFloat tableCellHeight;
   
    
    NSMutableArray *offerVehicleNameArray;
    NSMutableArray *offerDescriptionArray;
    
    NSString *vehicleName;
    NSString *offerDescription;
}
@synthesize arrVal;

#pragma mark view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [[NSMutableArray alloc]init];
    offerVehicleNameArray = [[NSMutableArray alloc]init];
    offerDescriptionArray = [[NSMutableArray alloc]init];
    tableCellHeight = 30;
    isFirstTime = YES;

    
    if(self.isBarShown)
    {
        [self.navigationController setNavigationBarHidden:NO];
    }
   

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self addTitle];
        [self getData];
    }
    
    if(self.isBarShown)
    {
        [self.navigationController setNavigationBarHidden:NO];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES];
    }
}

#pragma mark ui rendering

-(void)addTitle                 // add title
{
    yCordinate = self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 250, 30)];
    label.text = [arrVal objectAtIndex:0];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height +3;
    [self addTextField];
    [self addSubmitButton];
}
-(void)addTextField             // add search text field
{
    texfield = [[UITextField  alloc] initWithFrame:
                CGRectMake(0, yCordinate, self.view.frame.size.width*.90f, 40)];
    texfield.center = CGPointMake(screenWidth/2, texfield.center.y );
    [texfield setFont:[UIFont boldSystemFontOfSize:10]];
    [texfield setBackgroundColor:[UIColor whiteColor]];
    texfield.textColor = [UIColor blackColor];
    [texfield setTextAlignment:NSTextAlignmentLeft];
    //Placeholder text is displayed when no text is typed
    texfield.placeholder = [arrVal objectAtIndex:1];
    
    texfield.clipsToBounds = YES;
    texfield.layer.borderColor = [[UIColor blackColor]CGColor];
    texfield.layer.borderWidth=1.0;
    texfield.delegate = self;
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    texfield.leftView = leftView;
    texfield.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:texfield];
    
    yCordinate += texfield.frame.size.height + 15;

}
-(void)addSubmitButton              // add submit button
{
    submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, yCordinate, self.view.frame.size.width*.90f, 35)];
    [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    submitButton.backgroundColor = buttonRedColor;
    submitButton.center = CGPointMake(screenWidth/2, submitButton.center.y );
    [submitButton setEnabled:NO];
    [self.view addSubview:submitButton];
    [submitButton addTarget:self action:@selector(submitRequest:) forControlEvents:UIControlEventTouchUpInside];
    yCordinate += submitButton.frame.size.height;
}

#pragma mark submit button touch handler

-(void)submitRequest:(id)sender
{
    if([[arrVal objectAtIndex:2]isEqualToString:@"currentOffers"])
    {
        [self addLabel];
    }
    else
    {
        MapViewController *viewController = [[MapViewController alloc]init];
        viewController.dict = dictSelected;
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController pushViewController:viewController animated:YES];
    }
   
}

#pragma Textfield delegate implementation
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
     [self addTableView];
}

#pragma mark get data

-(void)getData
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    
    if([[arrVal objectAtIndex:2]isEqualToString:@"showroomAddress"])        // for showroom
    {
        webService.serviceName = @"showroomAddress";
        [webService getShowroomAddress];
    }
    else if([[arrVal objectAtIndex:2]isEqualToString:@"serviceCentre"])     // for service centre
    {
        webService.serviceName = @"serviceCentre";
        [webService getServiceCentre];
    }
    else if([[arrVal objectAtIndex:2]isEqualToString:@"genuinePart"])           // for grnuinr part
    {
        webService.serviceName = @"genuinePart";
        [webService getGenuinePart];
    }
    else if([[arrVal objectAtIndex:2]isEqualToString:@"bodyShop"])              // for body shop
    {
        webService.serviceName = @"bodyShop";
        [webService getBodyShop];
    }
    else if([[arrVal objectAtIndex:2]isEqualToString:@"currentOffers"])         // for current offers
    {
        webService.serviceName = @"currentOffers";
        [webService getCurrentOffers];
    }
   

}

#pragma mark connection delegates

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict            // connection error case
{
    
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict          // connection success case
{
    if([[arrVal objectAtIndex:2]isEqualToString:@"showroomAddress"])
    {
        arrOfDict = [dict valueForKey:@"showroom_address"];         // for showroom
        int i = 0;
        for(NSDictionary *dict in arrOfDict)
        {
            NSString *str1 = [dict valueForKey:@"showroom_branch"];
            NSString *str2 = [dict valueForKey:@"showroom_address"];
            NSString *name = [NSString stringWithFormat:@"%@-%@",str1,str2];
            
            i++;
            
            [dataArr addObject:name];
        }

    }
    else if([[arrVal objectAtIndex:2]isEqualToString:@"serviceCentre"])         // for service centre
    {
        arrOfDict = (NSArray *)dict;
        int i = 0;
        for(NSDictionary *dict in arrOfDict)
        {
            NSString *str1 = [dict valueForKey:@"showroom_branch"];
            NSString *str2 = [dict valueForKey:@"showroom_address"];
            NSString *name = [NSString stringWithFormat:@"%@-%@",str1,str2];
            
            i++;
            
            [dataArr addObject:name];
        }

    }
    
    else if([[arrVal objectAtIndex:2]isEqualToString:@"genuinePart"])           // for genuine part
    {
        arrOfDict = (NSArray *)dict;
        int i = 0;
        for(NSDictionary *dict in arrOfDict)
        {
            NSString *str1 = [dict valueForKey:@"showroom_branch"];
            NSString *str2 = [dict valueForKey:@"showroom_address"];
            NSString *name = [NSString stringWithFormat:@"%@-%@",str1,str2];
            
            i++;
            
            [dataArr addObject:name];
        }
    }
    else if([[arrVal objectAtIndex:2]isEqualToString:@"bodyShop"])          // for bodyshop
    {
        arrOfDict = (NSArray *)dict;
        int i = 0;
        for(NSDictionary *dict in arrOfDict)
        {
            NSString *str1 = [dict valueForKey:@"showroom_branch"];
            NSString *str2 = [dict valueForKey:@"showroom_address"];
            NSString *name = [NSString stringWithFormat:@"%@-%@",str1,str2];
            
            i++;
            
            [dataArr addObject:name];
        }
    }
    
    else if([[arrVal objectAtIndex:2]isEqualToString:@"currentOffers"])         // for current offers
    {
        NSArray *arr = [dict valueForKey:@"current_offers"];
        
        for(NSDictionary *dict1 in arr)
        {
            NSArray *arrList = [dict1 valueForKey:@"offer_list"];
            NSLog(@"arrList = %@",arrList);
            NSDictionary *dict2 = [arrList objectAtIndex:0];
            
            [offerVehicleNameArray addObject:[dict2 valueForKey:@"vehicle_name"]];
            [offerDescriptionArray addObject:[dict2 valueForKey:@"offer"]];
            
             [dataArr addObject:[dict2 valueForKey:@"vehicle_name"]];
            
        }
        
        
    }
    
}

#pragma mark ui rendering

-(void)addLabel         // add label
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate + 20, self.view.frame.size.width*.90f, 100)];
    NSString *str = [NSString stringWithFormat:@"Vehicle Name: %@ \n\n Offer: %@",vehicleName,offerDescription];
    label.text =str;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = appGrayColor;
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    //[label sizeToFit];
    [self.view addSubview:label];

}

-(void)addTableView         // add tableview
{
    if(!tableView)
    {
        CGFloat tableHeight;
        if(dataArr.count > 6)
        {
           tableHeight = .40*self.view.frame.size.height;
        }
        else
        {
            
            tableHeight = tableCellHeight *dataArr.count;
        }
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(3, texfield.frame.origin.y + texfield.frame.size.height -2, texfield.frame.size.width - 6, tableHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:1.0];
        tableView.delegate = self;
        tableView.center = CGPointMake(screenWidth/2, tableView.center.y );
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.dataSource = self;
        
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        tableView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        
        [Common addBorderToUiView:tableView withBorderWidth:1.0f cornerRadius:0 Color:[UIColor lightGrayColor]];
    }
   
    [self.view addSubview:tableView];
}

#pragma mark tableView Delegaes implementation

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Value rows");
    return dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentifierForReadReceipt = @"cellIdentifier";
    UITableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifierForReadReceipt];
    if(tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                     tableCellIdentifierForReadReceipt];
    }
    tableCell.textLabel.text =[dataArr objectAtIndex:indexPath.row];
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
    
    if([[arrVal objectAtIndex:2]isEqualToString:@"currentOffers"])
    {
        vehicleName = [offerVehicleNameArray objectAtIndex:indexPath.row];
        offerDescription = [offerDescriptionArray objectAtIndex:indexPath.row];
        
        NSString *name = [dataArr objectAtIndex:indexPath.row];
        texfield.text = name;
        [texfield endEditing:YES];
        [submitButton setEnabled:YES];
        
        dictSelected = [arrOfDict objectAtIndex:indexPath.row];
        [tableView removeFromSuperview];
    }
    else
    {
        NSString *name = [dataArr objectAtIndex:indexPath.row];
        texfield.text = name;
        [texfield endEditing:YES];
        [submitButton setEnabled:YES];
        
        dictSelected = [arrOfDict objectAtIndex:indexPath.row];
        [tableView removeFromSuperview];
        

    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
