//
//  TabbarBaseViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 08/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "TabbarBaseViewController.h"
#import "SettingView.h"

@interface TabbarBaseViewController ()

@end

@implementation TabbarBaseViewController
{
     UIImageView *imgView;
    
    int counter;
    UIButton *settingBtn;
    CGFloat yValue;
    UIView *baseView;
}

@synthesize yCordinate,settingView;

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self drawLogo];
    [self drawSettingButton];
    // Do any additional setup after loading the view.
}


-(void)drawLogo
{
   if([self.navigationController.navigationBar isHidden])
   {
       yCordinate = 25;
   }
    else
    {
        yCordinate = 25 + self.navigationController.navigationBar.frame.size.height;

    }
    yValue = yCordinate;
    NSLog(@"yCordinate = %f",yCordinate);
   // yCordinate = 25 + self.navigationController.navigationBar.frame.size.height;
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20,yCordinate , 60, 60)];
   // UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 80, 80)];
    imgView.image = [UIImage imageNamed:@"app_icon.png"];
    [self.view addSubview:imgView];
    
   
}



-(void)drawSettingButton
{
    baseView = [[UIView alloc]initWithFrame:CGRectMake(0, yCordinate + 5, 100, 40)];
    baseView.center = CGPointMake(self.view.frame.size.width *.85f, baseView.center.y);
    [self.view addSubview:baseView];
    [baseView setUserInteractionEnabled:YES];
    [baseView setBackgroundColor:[UIColor clearColor]];
    
    
    settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 5, 20, 20)];
    settingBtn.center = CGPointMake(settingBtn.center.x, settingBtn.center.y);
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"setting_icon.png"] forState:UIControlStateNormal];
    [baseView addSubview:settingBtn];
    [settingBtn addTarget:self action:@selector(settingBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
     yCordinate += imgView.frame.size.height + 10;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settingBtnTouched:)];
    [baseView addGestureRecognizer:gesture];
}

-(void)settingBtnTouched:(id)sender
{
    counter ++;
    CGFloat yval = yValue;//settingBtn.frame.origin.y + settingBtn.frame.size.height + 5;
    if(!settingView)
    {
        //view = [[SettingView alloc]initWithFrame:CGRectMake(imgView.frame.size.width + imgView.frame.origin.x+ 10,  yval,self.view.frame.size.width- (imgView.frame.size.width + imgView.frame.origin.x), self.view.frame.size.height - yval)];
        
        
         settingView = [[SettingView alloc]initWithFrame:CGRectMake(0,  yval,self.view.frame.size.width, self.view.frame.size.height - yval)];
        settingView.rootController = self;
        
       // view.backgroundColor = [UIColor whiteColor];
        //  [self.view addSubview:view];
    }
    
    if(counter %2 != 0)
    {
        settingView.center = CGPointMake(2*self.view.frame.size.width, settingView.center.y);
        [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.view addSubview:settingView];
            settingView.center = CGPointMake(self.view.frame.size.width/2, settingView.center.y);
          //  self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];

        } completion:^(BOOL finished) {
            
        }];

    }
    
    else
    {
        [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            settingView.center = CGPointMake(2*self.view.frame.size.width, settingView.center.y);
        } completion:^(BOOL finished) {
            [settingView removeFromSuperview];
            // self.view.backgroundColor = [UIColor whiteColor];

        }];
    }
    
    [self.view bringSubviewToFront:baseView];
     [self.view bringSubviewToFront:imgView];

    
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
