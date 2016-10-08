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

#pragma mark view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitle];
    [self addSubTitle];
    [self addButton];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark ui rendering

-(void)addTitle                     // add title
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

-(void)addSubTitle                  // add subtitle
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

-(void)addButton                    // add call button
{
    UIButton *callButton = [[UIButton alloc]initWithFrame:CGRectMake(0, yCordinate, self.view.frame.size.width*.90f, 40)];
    [callButton setTitle:@"CALL" forState:UIControlStateNormal];
    callButton.backgroundColor = buttonRedColor;
    callButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    callButton.center = CGPointMake(screenWidth/2, callButton.center.y );
    
    [self.view addSubview:callButton];
    [callButton addTarget:self action:@selector(callTollFree:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark toll free implementation


-(void)callTollFree:(id)sender
{
    NSString *phnNum = [NSString stringWithFormat:@"%@%@",@"tel:",TollfreeNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phnNum]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
