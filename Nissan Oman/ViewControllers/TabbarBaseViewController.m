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
    SettingView *view;
    int counter;
    UIButton *settingBtn;
}

@synthesize yCordinate;

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
   // yCordinate = 25 + self.navigationController.navigationBar.frame.size.height;
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20,yCordinate , 80, 80)];
   // UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 80, 80)];
    imgView.image = [UIImage imageNamed:@"app_icon.png"];
    [self.view addSubview:imgView];
    
   
}

-(void)drawSettingButton
{
    settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, yCordinate + 5, 20, 20)];
    settingBtn.center = CGPointMake(self.view.frame.size.width *.9f, settingBtn.center.y);
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"setting_icon.png"] forState:UIControlStateNormal];
    [self.view addSubview:settingBtn];
    [settingBtn addTarget:self action:@selector(settingBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
     yCordinate += imgView.frame.size.height + 10;
}

-(void)settingBtnTouched:(id)sender
{
    counter ++;
    CGFloat yval = settingBtn.frame.origin.y + settingBtn.frame.size.height + 5;
    if(!view)
    {
        view = [[SettingView alloc]initWithFrame:CGRectMake(imgView.frame.size.width + imgView.frame.origin.x+ 10,  yval,self.view.frame.size.width- (imgView.frame.size.width + imgView.frame.origin.x), self.view.frame.size.height - yval)];
        view.backgroundColor = [UIColor whiteColor];
        //  [self.view addSubview:view];
    }
    
    if(counter %2 != 0)
    {
        view.center = CGPointMake(2*self.view.frame.size.width, view.center.y);
        [UIView animateWithDuration:0.9f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.view addSubview:view];
            view.center = CGPointMake(.67*self.view.frame.size.width, view.center.y);
        } completion:^(BOOL finished) {
            
        }];

    }
    
    else
    {
        [UIView animateWithDuration:0.9f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.center = CGPointMake(2*self.view.frame.size.width, view.center.y);
        } completion:^(BOOL finished) {
            [view removeFromSuperview];

        }];
    }
    

    
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
