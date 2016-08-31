//
//  LoginBaseviewViewController.m
//  Nissan Oman
//
//  Created by Sakshi on 30/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "LoginBaseviewViewController.h"

@interface LoginBaseviewViewController ()<UIScrollViewDelegate>

@end

@implementation LoginBaseviewViewController

@synthesize upperLogo,y,scrollView;
@synthesize backgroundDimView,viewHeight,viewWidth,navigationHeight;

- (void)viewDidLoad {
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
    [self setupForScrollView];
    [self setBackgoundImage];
    [self setUpperLogo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackgoundImage{
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [backgroundView setFrame:CGRectMake(0, 0, viewWidth,viewHeight*1.3)];
    backgroundView.contentMode = UIViewContentModeScaleToFill;
    [scrollView addSubview:backgroundView];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma Initialization
-(void)initialiseVariables{
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    utility = [[Utility alloc]init];
    sharePreferenceUtil = [SharePreferenceUtil getInstance];
    webService = [[WebService alloc]init];
    //    userData = [sharePreferenceUtil getCustomObjectFromDefaultsWithKey:kN_UserData];
}

-(void)setUpperLogo{
    upperLogo = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth/2-ScreenWidthFactor*40,ScreenHeightFactor*40, ScreenWidthFactor*80, ScreenHeightFactor*80)];
    [upperLogo setImage:[UIImage imageNamed:@"login_logo.png"]];
    [scrollView addSubview:upperLogo];
    y = upperLogo.frame.origin.y+upperLogo.frame.size.height+ScreenHeightFactor*20;
}

-(void)setupForScrollView{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    [scrollView setContentOffset:CGPointZero];
    [self.view addSubview:scrollView];
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
