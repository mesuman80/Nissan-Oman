//
//  SpecificationViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 28/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "SpecificationViewController.h"
#import "SpecificationTableViewCell.h"
#import "SpecificationData.h"

@interface SpecificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SpecificationViewController
{
    CGFloat yCordinate;
    BOOL isFirstTime;
    UITableView *tableView;
    CGFloat tableCellHeight;
    NSMutableArray *dataFilledArray;
}

@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    tableCellHeight = 50;
    isFirstTime = YES;
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(isFirstTime)
    {
        isFirstTime = NO;
        dataFilledArray = [[NSMutableArray alloc]init];
        for(int i=0; i<dataArray.count; i++)
        {
            NSDictionary *dict = [dataArray objectAtIndex:i];
            SpecificationData *data = [[SpecificationData alloc]init];
            data.heading = [dict valueForKey:@"heading"];
            data.subHeading = [dict valueForKey:@"subHeading"];
            data.isSelected = NO;
            
            [dataFilledArray addObject:data];
        }
        
        
        [self addTitle];
        [self addTableView];
    }
}

-(void)addTitle
{
    yCordinate =  self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 30)];
    label.text = @"SPECIFICATION";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 5;
}

-(void)addTableView
{
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, yCordinate,self.view.frame.size.width - 20, .6*self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma Mark tableView Delegaes implementation

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Value rows");
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentifierForReadReceipt = @"cellIdentifier";
    SpecificationTableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifierForReadReceipt];
    if(tableCell == nil) {
        tableCell = [[SpecificationTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                     tableCellIdentifierForReadReceipt];
    }
    [tableCell configureCell:[dataFilledArray objectAtIndex:indexPath.row] withWidth:tableView.frame.size.width ];
    tableCell.backgroundColor = [UIColor clearColor];
    return tableCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*SpecificationTableViewCell *cell = [tableView1 cellForRowAtIndexPath:indexPath];
    if(cell)
    {
        if(!cell.isSelected)
        {
            tableCellHeight = 50;
        }
    } */
   
    SpecificationData *data = [dataFilledArray objectAtIndex:indexPath.row];
    if(data.isSelected ) {
        return tableCellHeight;
    }
    else {
        return  50;
    }
    
    return 50;
}



-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    
    SpecificationData *data = [dataFilledArray objectAtIndex:indexPath.row];
    
    if(data.isSelected)
    {
        data.isSelected = NO;
        tableCellHeight = 50;
    }
    else
    {
        data.isSelected = YES;
       CGFloat height =  [self calculateCellHeightWithText:data.subHeading];
        tableCellHeight = height + 13 + 50;
    }
    
    for(int i=0;i<dataFilledArray.count; i++)
    {
        if(i != indexPath.row)
        {
            SpecificationData *data = [dataFilledArray objectAtIndex:i];
            data.isSelected = NO;
        }
        
    }
   
    [tableView reloadData];
}

-(CGFloat)calculateCellHeightWithText:(NSString *)text
{
    CGSize displayValueSize = [text sizeWithFont:[UIFont systemFontOfSize: 12.0f]
                               constrainedToSize:CGSizeMake(tableView.frame.size.width - 20, CGFLOAT_MAX)
                                   lineBreakMode:NSLineBreakByWordWrapping];
    
    return displayValueSize.height;
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
