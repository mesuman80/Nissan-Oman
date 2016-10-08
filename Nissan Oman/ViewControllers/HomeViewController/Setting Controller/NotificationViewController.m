//
//  NotificationViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 24/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController
{
    CGFloat yCordinate;
    UIButton *radiobutton1;
    UIButton *radiobutton2;
    UIButton *radiobutton3;
    UIButton *submitButton;
}

#pragma mark view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addTitle];
    [self addSubTitle];
    [self addButtons];
    [self addSubmitButton];
    
    // Do any additional setup after loading the view.
}

#pragma mark ui rendering

-(void)addTitle                 // add title
{
    yCordinate =  self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 30)];
    label.text = @"NOTIFICATION PREFERENCES";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 20;
}

-(void)addSubTitle              // add subtitle
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 20)];
    label.text = @"TURN ON NOTIFICATION";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:17.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 20;
    
}

-(void)addButtons               // adding radio buttons
{
    radiobutton1 = [[UIButton alloc] initWithFrame:CGRectMake(.30*self.view.frame.size.width,yCordinate,20,20)];
    [radiobutton1 setTag:0];
    
    //[radiobutton1 setTitle:@"Female" forState:UIControlStateSelected];
    [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"Radio_button_off.png"] forState:UIControlStateNormal];
    [radiobutton1 setBackgroundImage:[UIImage imageNamed:@"Radio_button_on.png"] forState:UIControlStateSelected];
    [radiobutton1 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *yesLabel=[[UILabel alloc]init];
    yesLabel.textColor=[UIColor blackColor];
    NSString *str = @"ALL UPDATES";
    CGSize displayValueSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    yesLabel.font=[UIFont systemFontOfSize:15.0f];
    yesLabel.text=str;
    yesLabel.tag = 0;
    yesLabel.frame=CGRectMake(radiobutton1.frame.size.width + radiobutton1.frame.origin.x + 5,yCordinate + 3,displayValueSize.width,displayValueSize.height);
    [yesLabel sizeToFit];
    [self.view addSubview:yesLabel];
    
    [yesLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(radiobuttonSelected1:)];
    [yesLabel addGestureRecognizer:gesture0];
    
    yCordinate += yesLabel.frame.size.height + 12;
    
    
    
    
    radiobutton2 = [[UIButton alloc] initWithFrame:CGRectMake(.30*self.view.frame.size.width,yCordinate,20,20)];
    [radiobutton2 setTag:1];
    [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"Radio_button_off.png"] forState:UIControlStateNormal];
    [radiobutton2 setBackgroundImage:[UIImage imageNamed:@"Radio_button_on.png"] forState:UIControlStateSelected];
    [radiobutton2 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *noLabel=[[UILabel alloc]init];
    noLabel.textColor=[UIColor blackColor];
    NSString *str1 = @"IMPORTANT UPDATES";
    CGSize displayValueSize1 = [str1 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    noLabel.font=[UIFont systemFontOfSize:15.0f];
    noLabel.text=str1;
    noLabel.tag = 1;
    noLabel.frame=CGRectMake(radiobutton2.frame.size.width + radiobutton2.frame.origin.x + 5,yCordinate + 3,displayValueSize1.width,displayValueSize1.height);
    [noLabel sizeToFit];
    [self.view addSubview:noLabel];
    
    [noLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(radiobuttonSelected1:)];
    [noLabel addGestureRecognizer:gesture1];
    
    
    [self.view addSubview:radiobutton1];
    [self.view addSubview:radiobutton2];
    
    yCordinate += noLabel.frame.size.height + 12;
    
    
    
    radiobutton3 = [[UIButton alloc] initWithFrame:CGRectMake(.30*self.view.frame.size.width,yCordinate,20,20)];
    [radiobutton3 setTag:2];
    [radiobutton3 setBackgroundImage:[UIImage imageNamed:@"Radio_button_off.png"] forState:UIControlStateNormal];
    [radiobutton3 setBackgroundImage:[UIImage imageNamed:@"Radio_button_on.png"] forState:UIControlStateSelected];
    [radiobutton3 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label3=[[UILabel alloc]init];
    label3.textColor=[UIColor blackColor];
    NSString *str3 = @"OFFERS ONLY";
    label3.tag = 2;
    CGSize displayValueSize3 = [str3 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    label3.font=[UIFont systemFontOfSize:15.0f];
    label3.text=str3;
    label3.frame=CGRectMake(radiobutton3.frame.size.width + radiobutton3.frame.origin.x + 5,yCordinate + 3,displayValueSize3.width,displayValueSize3.height);
    [label3 sizeToFit];
    [self.view addSubview:label3];
    
    [label3 setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(radiobuttonSelected1:)];
    [label3 addGestureRecognizer:gesture2];

    
    
    [self.view addSubview:radiobutton1];
    [self.view addSubview:radiobutton2];
    [self.view addSubview:radiobutton3];
    
    yCordinate += noLabel.frame.size.height + 20;
    
}

#pragma mark radio button touch handler

-(void)radiobuttonSelected:(id)sender{
    switch ([sender tag]) {
        case 0:
            if([radiobutton1 isSelected]==YES)
            {
               // [radiobutton1 setSelected:NO];
               // [radiobutton2 setSelected:YES];
            }
            else{
                [radiobutton1 setSelected:YES];
                [radiobutton2 setSelected:NO];
                [radiobutton3 setSelected:NO];
            }
            
            break;
        case 1:
            if([radiobutton2 isSelected]==YES)
            {
               // [radiobutton2 setSelected:NO];
               // [radiobutton1 setSelected:YES];
            }
            else
            {
                [radiobutton2 setSelected:YES];
                [radiobutton1 setSelected:NO];
                [radiobutton3 setSelected:NO];
            }
            break;
        case 2:
            if([radiobutton3 isSelected]==YES)
            {
                // [radiobutton2 setSelected:NO];
                // [radiobutton1 setSelected:YES];
            }
            else
            {
                [radiobutton3 setSelected:YES];
                [radiobutton1 setSelected:NO];
                [radiobutton2 setSelected:NO];
            }
            
            break;
        default:
            break;
    }
    
}

#pragma mark radio button gesture handler

-(void)radiobuttonSelected1:(UITapGestureRecognizer *)sender{
    UILabel *label = (UILabel *)sender.view;
    switch ([label tag]) {
        case 0:
            if([radiobutton1 isSelected]==YES)
            {
                // [radiobutton1 setSelected:NO];
                // [radiobutton2 setSelected:YES];
            }
            else{
                [radiobutton1 setSelected:YES];
                [radiobutton2 setSelected:NO];
                [radiobutton3 setSelected:NO];
            }
            
            break;
        case 1:
            if([radiobutton2 isSelected]==YES)
            {
                // [radiobutton2 setSelected:NO];
                // [radiobutton1 setSelected:YES];
            }
            else
            {
                [radiobutton2 setSelected:YES];
                [radiobutton1 setSelected:NO];
                [radiobutton3 setSelected:NO];
            }
            break;
        case 2:
            if([radiobutton3 isSelected]==YES)
            {
                // [radiobutton2 setSelected:NO];
                // [radiobutton1 setSelected:YES];
            }
            else
            {
                [radiobutton3 setSelected:YES];
                [radiobutton1 setSelected:NO];
                [radiobutton2 setSelected:NO];
            }
            
            break;
        default:
            break;
    }
    
}

-(void)addSubmitButton              // adding submit button
{
    submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, yCordinate, self.view.frame.size.width*.90f, 35)];
    [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    submitButton.backgroundColor = buttonRedColor;
    submitButton.center = CGPointMake(screenWidth/2, submitButton.center.y );
    [self.view addSubview:submitButton];
    [submitButton addTarget:self action:@selector(submitRequest:) forControlEvents:UIControlEventTouchUpInside];
    yCordinate += submitButton.frame.size.height + 3;
}

#pragma mark submit button touch handler


-(void)submitRequest:(id)sender
{
    
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
