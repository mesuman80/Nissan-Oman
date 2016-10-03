//
//  BaseViewController.m
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIScrollViewDelegate>

@end

@implementation BaseViewController


@synthesize backgroundDimView,viewHeight,viewWidth,navigationHeight;

- (void)viewDidLoad {               // setting basic ui of view controller
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets  = NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.view autoresizesSubviews];
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:titleFont size:18.0f], NSFontAttributeName, nil]];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initialiseVariables];
    
    navigationHeight = self.navigationController.navigationBar.frame.size.height + 10;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Initialization
-(void)initialiseVariables{                     // initialise data variables
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    utility = [[Utility alloc]init];
    sharePreferenceUtil = [SharePreferenceUtil getInstance];
    webService = [[WebService alloc]init];
    //    userData = [sharePreferenceUtil getCustomObjectFromDefaultsWithKey:kN_UserData];
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
