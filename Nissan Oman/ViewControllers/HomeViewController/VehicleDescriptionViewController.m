//
//  VehicleDescriptionViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 12/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "VehicleDescriptionViewController.h"
#import "WebService.h"

@interface VehicleDescriptionViewController ()<CustomWebServiceDelegate>

@end

@implementation VehicleDescriptionViewController
{
    NSDictionary *dataDictionary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDescription];
}

-(void)getDescription
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"vehicleDescription";
    [webService getVehicleDescription:self.vehicleID];

}

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict
{
    
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict
{
    dataDictionary = dict;
    [self addDescriptionView];
}

-(void)addDescriptionView
{
    [self drawVehicleView];
}

-(void)drawVehicleView
{
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, self.yCordinate + 2, self.view.frame.size.width, .23*self.view.frame.size.height)];
    baseView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:baseView];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 120, 120)];
    NSURL *url = [NSURL URLWithString:[dataDictionary valueForKey:@"overview_image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    imgView.center = CGPointMake(baseView.frame.size.width *.25f, baseView.frame.size.height/2);

    imgView.image = img;
    [baseView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 70)];
    label.text = [dataDictionary valueForKey:@"vehicle_name"];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.center = CGPointMake(baseView.frame.size.width *.75f, baseView.frame.size.height/2);
    
    [baseView addSubview:label];
    
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
