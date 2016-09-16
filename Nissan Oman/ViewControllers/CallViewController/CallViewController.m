//
//  CallViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 08/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "CallViewController.h"

@interface CallViewController ()

@end

@implementation CallViewController
{
    CGFloat yCordinate;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitle];
    [self addSubTitle];
    [self addButton];
    // Do any additional setup after loading the view.
}


-(void)addTitle
{
    yCordinate = self.yCordinate + 100;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 250, 30)];
    label.text = @"CALL NISSAN TOLL FREE";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height +3;
}

-(void)addSubTitle
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 200, 20)];
    label.text = @"80050011";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 10;
    
}

-(void)addButton
{
    UIButton *callButton = [[UIButton alloc]initWithFrame:CGRectMake(0, yCordinate, self.view.frame.size.width*.85f, 40)];
    [callButton setTitle:@"CALL" forState:UIControlStateNormal];
    callButton.backgroundColor = buttonRedColor;
    callButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    callButton.center = CGPointMake(screenWidth/2, callButton.center.y );
    
    [self.view addSubview:callButton];
    [callButton addTarget:self action:@selector(callTollFree:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)callTollFree:(id)sender
{
    NSString *phnNum = [NSString stringWithFormat:@"%@%@",@"tel:",TollfreeNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phnNum]];
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
