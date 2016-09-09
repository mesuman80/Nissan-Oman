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
#import "LocationViewController.h"
#import "VehiclesViewController.h"
#import "Constants.h"
#import "Common.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController
{
    UIView *subview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [[self tabBar] setBackgroundColor:[UIColor blackColor]];
   // [[UITabBar appearance] setBackgroundColor:[UIColor blackColor]];
    [self tabBar].barStyle  = UIBarStyleDefault;
  //  [[self tabBar] setOpaque:YES];
    [self tabBar].tintColor = [UIColor whiteColor];
    [self drawTabbar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawTabbar
{
    
    CGRect frame = CGRectMake(0.0, 0.0, [self tabBar].frame.size.width, [self tabBar].frame.size.height);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.8f ]];
    [[self tabBar] addSubview:v];
    
    subview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height)];
    subview.backgroundColor = [UIColor redColor];
    [[self tabBar]addSubview:subview];
    
    
    HomeViewController  *homeViewController = [[HomeViewController alloc]init];
    homeViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"homeicon.png"] tag:0];
    
    UINavigationController *homeNavigationController=[[UINavigationController alloc]initWithRootViewController:homeViewController];
    
    LocationViewController  *locationViewController = [[LocationViewController alloc]init];
    locationViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"location_icon.png"] tag:1];
    UINavigationController *locationNavigationController=[[UINavigationController alloc]initWithRootViewController:locationViewController];
    
    
    VehiclesViewController  *vehiclesViewController = [[VehiclesViewController alloc]init];
    vehiclesViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"crossover_icon.png"] tag:2];
    UINavigationController *vehicleNavigationController=[[UINavigationController alloc]initWithRootViewController:vehiclesViewController];
    
    CallViewController  *callViewController = [[CallViewController alloc]init];
    callViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"call.png"] tag:3];
    UINavigationController *callNavigationController=[[UINavigationController alloc]initWithRootViewController:callViewController];
    
    NSArray *myViewControllers = [[NSArray alloc] initWithObjects:homeNavigationController,
                                  locationNavigationController,vehicleNavigationController,callNavigationController,nil];
    
    [self setViewControllers:myViewControllers];
    [self setSelectedIndex:0];
    
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

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag == 0)
    {
      /*  UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height)];
        v.backgroundColor = [UIColor redColor];
        [[self tabBar]addSubview:v]; */
        subview.frame = CGRectMake(0, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height);
        
    }
    
    else if(item.tag == 1)
    {
       /* UIView *v = [[UIView alloc]initWithFrame:CGRectMake([self tabBar].frame.size.width *.25f, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height)];
        v.backgroundColor = [UIColor redColor];
        [[self tabBar]addSubview:v]; */
        subview.frame = CGRectMake([self tabBar].frame.size.width *.25f, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height);

        
    }
    else if(item.tag == 2)
    {
      /*  UIView *v = [[UIView alloc]initWithFrame:CGRectMake([self tabBar].frame.size.width *.5f, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height)];
        v.backgroundColor = [UIColor redColor];
        [[self tabBar]addSubview:v];*/
        subview.frame = CGRectMake([self tabBar].frame.size.width *.5f, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height);

        
    }
    else if(item.tag == 3)
    {
      /*  UIView *v = [[UIView alloc]initWithFrame:CGRectMake([self tabBar].frame.size.width *.75f, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height)];
        v.backgroundColor = [UIColor redColor];
        [[self tabBar]addSubview:v]; */
        subview.frame = CGRectMake([self tabBar].frame.size.width *.75f, 0, [self tabBar].frame.size.width *.25f, [self tabBar].frame.size.height);

        
    }
    
    NSLog(@"item val = %@", item);
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
