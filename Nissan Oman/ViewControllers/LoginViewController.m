//
//  LoginViewController.m
//  Nissan Oman
//
//  Created by Sakshi on 26/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupDefaultBackgound];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupDefaultBackgound{
    BaseViewController *baseViewController = [[BaseViewController alloc] init];
    [baseViewController setBackgoundImage];
    
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
