//
//  TabbarViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 08/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "TabbarViewController.h"
#import "HomeViewController.h"
#import "CallViewController.h"
#import "VehiclesViewController.h"
#import "Constants.h"
#import "Common.h"
#import "ShowroomViewController.h"
#import "VehicleCategeoryViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController
{
    UIView *subview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tabBar].barStyle  = UIBarStyleDefault;
    [self tabBar].tintColor = [UIColor whiteColor];
     self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, 0, 0);
    [self drawTabbar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tabbar drawing

-(void)drawTabbar
{
    
    CGRect frame = CGRectMake(0.0, 0.0, [self tabBar].frame.size.width, [self tabBar].frame.size.height);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8f ]];
    [[self tabBar] addSubview:v];
    
    subview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height)];
    subview.backgroundColor = buttonRedColor;
    [[self tabBar]addSubview:subview];
    
    
    HomeViewController  *homeViewController = [[HomeViewController alloc]init];         // for home view
    homeViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"homeicon.png"] tag:0];
    
    UINavigationController *homeNavigationController=[[UINavigationController alloc]initWithRootViewController:homeViewController];
    
    ShowroomViewController  *locationViewController = [[ShowroomViewController alloc]init];     // for location view
    locationViewController.arrVal = @[@"SHOWROOM LOCATOR",PlaceholderSelectBranch,@"showroomAddress"];

    locationViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"location_icon.png"] tag:1];
    UINavigationController *locationNavigationController=[[UINavigationController alloc]initWithRootViewController:locationViewController];
    [locationNavigationController setNavigationBarHidden: NO];

    
    [self.navigationController setNavigationBarHidden:NO];
    VehicleCategeoryViewController  *vehiclesViewController = [[VehicleCategeoryViewController alloc]init]; // for vehicle view
    vehiclesViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"crossover_icon.png"] tag:2];
    UINavigationController *vehicleNavigationController=[[UINavigationController alloc]initWithRootViewController:vehiclesViewController];
    [vehicleNavigationController setNavigationBarHidden: NO];
    
    CallViewController  *callViewController = [[CallViewController alloc]init];  // for toll free call view
    callViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"call.png"] tag:3];
    UINavigationController *callNavigationController=[[UINavigationController alloc]initWithRootViewController:callViewController];
    
    NSArray *myViewControllers = [[NSArray alloc] initWithObjects:homeNavigationController,
                                  locationNavigationController,vehicleNavigationController,callNavigationController,nil];
    
    [self setViewControllers:myViewControllers];
    [self setSelectedIndex:0];
    
    
    
    // for vertical bars
    
    UIView *verticalView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, [self tabBar].frame.size.height)];
    verticalView1.backgroundColor = [UIColor whiteColor];
    [[self tabBar]addSubview:verticalView1];
    
    UIView *verticalView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, [self tabBar].frame.size.height)];
    verticalView2.backgroundColor = [UIColor whiteColor];
    [[self tabBar]addSubview:verticalView2];
    
    UIView *verticalView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, [self tabBar].frame.size.height)];
    verticalView3.backgroundColor = [UIColor whiteColor];
    [[self tabBar]addSubview:verticalView3];
    
    verticalView1.center = CGPointMake([self tabBar].frame.size.width*.25f, verticalView1.center.y);
    verticalView2.center = CGPointMake([self tabBar].frame.size.width*.5f, verticalView2.center.y);
    verticalView3.center = CGPointMake([self tabBar].frame.size.width*.75f, verticalView3.center.y);
    
   
    
}

#pragma mark tabbar click implementation

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item // if tab bar item selected
{
    if(item.tag == 0)
    {
        subview.frame = CGRectMake(0, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height);
    }
    
    else if(item.tag == 1)
    {
        subview.frame = CGRectMake([self tabBar].frame.size.width *.25f, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height);
        
    }
    else if(item.tag == 2)
    {
        subview.frame = CGRectMake([self tabBar].frame.size.width *.5f, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height);

    }
    else if(item.tag == 3)
    {
        subview.frame = CGRectMake([self tabBar].frame.size.width *.75f, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height);

    }
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
