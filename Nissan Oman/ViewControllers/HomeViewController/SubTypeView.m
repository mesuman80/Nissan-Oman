//
//  SubTypeView.m
//  Nissan Oman
//
//  Created by Tripta Garg on 12/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "SubTypeView.h"
#import "CustomTableViewCell.h"
#import "VehicleDescriptionViewController.h"

@implementation SubTypeView
{
    UITableView *tableView;
    CGFloat tableCellHeight;
}
@synthesize parentViewController;

-(id)initWithFrame:(CGRect)frame withDictionaryArray:(NSArray *)array;
{
    if(self == [super initWithFrame:frame])
    {
        self.dictionaryArray = array;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5f ];
        tableCellHeight = 50.0f;
        [self addTableView];
        return self;
    }
    return nil;
}

-(void)addTableView
{
    CGFloat tableHeight ;
    if(self.dictionaryArray.count >4)
    {
        tableHeight = tableCellHeight *4;
    }
    else
    {
        tableHeight = tableCellHeight *self.dictionaryArray.count;
    }
    
    CGFloat baseviewHeight = tableHeight + 50;
       // baseviewHeight = 200;
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(10, .35*self.frame.size.height, self.frame.size.width - 20, baseviewHeight)];
    [baseView setBackgroundColor:[UIColor whiteColor]];
    baseView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:baseView];
    
    UILabel *titleLabel  = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, baseView.frame.size.width - 10, 45)];
    titleLabel.backgroundColor = buttonRedColor;
    titleLabel.text = @"Types";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:titleLabel];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 50,baseView.frame.size.width - 10, tableHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    [baseView addSubview:tableView];
}

#pragma Mark tableView Delegaes implementation

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Value rows");
    return self.dictionaryArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Index pathn =%li" , indexPath.row);
    static NSString *tableCellIdentifierForReadReceipt = @"cellIdentifier";
    CustomTableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifierForReadReceipt];
    if(tableCell == nil) {
        tableCell = [[CustomTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                     tableCellIdentifierForReadReceipt];
    }
    [tableCell configureCell:[self.dictionaryArray objectAtIndex:indexPath.row] withWidth:tableView.frame.size.width];
    tableCell.backgroundColor = [UIColor clearColor];
    return tableCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

/*-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Types";
    label.backgroundColor = buttonRedColor;
    label.textColor = [UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    return label;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
} */

-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected pathn =%li" , indexPath.row);
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    VehicleDescriptionViewController *vehicleDescriptionViewController = [[VehicleDescriptionViewController alloc]init];
    NSDictionary *dict = [self.vehicleArr objectAtIndex:indexPath.row];
    vehicleDescriptionViewController.vehicleID = [dict valueForKey:@"vehicle_id"];
    [parentViewController.navigationController pushViewController:vehicleDescriptionViewController animated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}


@end
