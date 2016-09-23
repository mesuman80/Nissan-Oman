//
//  SettingView.m
//  Nissan Oman
//
//  Created by Tripta Garg on 15/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "SettingView.h"
#import "AboutUsViewController.h"
#import "FeedbackViewController.h"

@implementation SettingView
{
    NSArray *dataArr;
    UITableView *tableView;
}
@synthesize rootController;

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.5f]];
        [self setElements];
        return self;
    }
    return nil;
}

-(void)setElements
{
    dataArr = @[@"FEEDBACK",@"CALL NISSAN TOLL FREE",@"ABOUT US",@"SETTINGS"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width, 60)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(.22*view.frame.size.width, 60,.78*self.frame.size.width, self.frame.size.height ) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];

    
    [self addSubview:tableView];
    
   /* [self setDelegate:self];
    [self setDataSource:self];
    self.scrollEnabled=NO;
    self.backgroundColor=[UIColor whiteColor];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero]; */
}

#pragma mark Table view delegates!

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return screenHeight*.08;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuTableCell";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [dataArr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0)
    {
        [rootController.navigationController setNavigationBarHidden:NO];
        FeedbackViewController *controller = [[FeedbackViewController alloc]init];
        [rootController.navigationController pushViewController:controller animated:YES];
    }
    else if(indexPath.row == 1)
    {
        NSString *phnNum = [NSString stringWithFormat:@"%@%@",@"tel:",TollfreeNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phnNum]];
    }
   else  if(indexPath.row == 2)
    {
        [rootController.navigationController setNavigationBarHidden:NO];
        AboutUsViewController *webPage = [[AboutUsViewController alloc]initWithWebString:@"Loyalty Program" withUrl:ADVENTUREPARKPAGE];
        [rootController.navigationController pushViewController:webPage animated:YES];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
