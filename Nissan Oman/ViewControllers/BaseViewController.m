//
//  BaseViewController.m
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize upperLogo,bottomBanner;
@synthesize backgroundDimView,viewHeight,viewWidth,navigationHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets  = NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.view autoresizesSubviews];
    [self.navigationController.navigationBar setBarTintColor:buttonBackgroundColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:titleFont size:18.0f], NSFontAttributeName, nil]];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    navigationHeight = self.navigationController.navigationBar.frame.size.height + 10;
 //   [self setBackgoundImage];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackgoundImage{
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
//    self.view.backgroundColor = [UIColor clearColor];
//    self.view.layer.contents = (__bridge id _Nullable)(([UIImage imageNamed:@"background.png"].CGImage));
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
//    [backgroundView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
//    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:backgroundView];
    self.view.backgroundColor = [UIColor redColor];
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
