//
//  SettingView.m
//  Nissan Oman
//
//  Created by Tripta Garg on 15/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "SettingView.h"

@implementation SettingView
{
    NSArray *dataArr;
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setElements];
        return self;
    }
    return nil;
}

-(void)setElements
{
    dataArr = @[@"FEEDBACK",@"CALL NISSAN TOLL FREE",@"ABOUT US",@"SETTINGS"];
    [self setDelegate:self];
    [self setDataSource:self];
    self.scrollEnabled=NO;
    self.backgroundColor=[UIColor whiteColor];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}

#pragma mark Table view delegates!

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return screenHeight*.08;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [dataArr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 1)
    {
        NSString *phnNum = [NSString stringWithFormat:@"%@%@",@"tel:",TollfreeNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phnNum]];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
