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
}
@synthesize parentViewController;

-(id)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5f ];
        [self addTableView];
        return self;
    }
    return nil;
}

-(void)addTableView
{
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, .35*self.frame.size.height,self.frame.size.width - 20, .5*self.frame.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    [self addSubview:tableView];
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
    [tableCell configureCell:[self.dictionaryArray objectAtIndex:indexPath.row] ];
    tableCell.backgroundColor = [UIColor clearColor];
    return tableCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Types";
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    return label;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

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
