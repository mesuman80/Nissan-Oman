//
//  TabbarBaseViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 08/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "TabbarBaseViewController.h"

@interface TabbarBaseViewController ()

@end

@implementation TabbarBaseViewController

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
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 80, 80)];
    imgView.image = [UIImage imageNamed:@"app_icon.png"];
    [self.view addSubview:imgView];
    
}

-(void)drawSettingButton
{
    UIButton *settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25, 20, 20)];
    settingBtn.center = CGPointMake(self.view.frame.size.width *.9f, settingBtn.center.y);
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"setting_icon.png"] forState:UIControlStateNormal];
    [self.view addSubview:settingBtn];
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
