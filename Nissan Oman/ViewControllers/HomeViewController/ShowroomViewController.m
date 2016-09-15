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

@interface ShowroomViewController ()<UITextFieldDelegate,CustomWebServiceDelegate,UITableViewDelegate, UITableViewDataSource>

@end

@implementation ShowroomViewController
{
    CGFloat yCordinate;
    UITextField *texfield;
    NSMutableArray *dataArr;
    UITableView *tableView;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [[NSMutableArray alloc]init];
    [self addTitle];
    [self.navigationController setNavigationBarHidden:NO];

    // Do any additional setup after loading the view.
}

-(void)addTitle
{
    yCordinate = self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 200, 30)];
    label.text = @"SHOWROOM LOCATOR";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height +3;
    [self addTextField];
    [self addSubmitButton];
}
-(void)addTextField
{
    texfield = [[UITextField  alloc] initWithFrame:
                CGRectMake(0, yCordinate, self.view.frame.size.width*.85f, 40)];
    texfield.center = CGPointMake(screenWidth/2, texfield.center.y );
    [texfield setFont:[UIFont boldSystemFontOfSize:12]];
    [texfield setBackgroundColor:[UIColor whiteColor]];
    texfield.textColor = [UIColor blackColor];
    [texfield setTextAlignment:NSTextAlignmentCenter];
    //Placeholder text is displayed when no text is typed
    texfield.placeholder = @"SELECT BRANCH";
    
    texfield.clipsToBounds = YES;
    texfield.layer.borderColor = [[UIColor blackColor]CGColor];
    texfield.layer.borderWidth=1.0;
    texfield.delegate = self;
    [self.view addSubview:texfield];
    
    yCordinate += texfield.frame.size.height + 15;

}
-(void)addSubmitButton
{
    UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, yCordinate, self.view.frame.size.width*.85f, 40)];
    [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    submitButton.backgroundColor = buttonRedColor;
    submitButton.center = CGPointMake(screenWidth/2, submitButton.center.y );

    [self.view addSubview:submitButton];
    [submitButton addTarget:self action:@selector(submitRequest:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)submitRequest:(id)sender
{
    
}
#pragma Textfield delegate implementation
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(dataArr.count == 0)
    {
         [self getShowroomBranchData];
    }
   else
   {
       [self addTableView];
   }
}

-(void)getShowroomBranchData
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"showroomAddress";
    [webService getShowroomAddress];

}

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict
{
    
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict
{
   NSArray *arrOfDict = [dict valueForKey:@"showroom_address"];
    int i = 0;
    for(NSDictionary *dict in arrOfDict)
    {
        NSString *name = [dict valueForKey:@"showroom_address"];
    
        i++;
        
        [dataArr addObject:name];
    }
    [self addTableView];
}


-(void)addTableView
{
    if(!tableView)
    {
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(3, texfield.frame.origin.y + texfield.frame.size.height -2, texfield.frame.size.width - 6, .2*self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.center = CGPointMake(screenWidth/2, tableView.center.y );
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.dataSource = self;
        [Common addBorderToUiView:tableView withBorderWidth:1.0f cornerRadius:0 Color:[UIColor lightGrayColor]];
    }
   
    [self.view addSubview:tableView];
}

#pragma Mark tableView Delegaes implementation

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Value rows");
    return dataArr.count;
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
    tableCell.textLabel.text =[dataArr objectAtIndex:indexPath.row];
    tableCell.textLabel.textColor = [UIColor blackColor];
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
    NSString *name = [dataArr objectAtIndex:indexPath.row];
    texfield.text = name;
    [texfield endEditing:YES];
    
    [tableView removeFromSuperview];
    
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
