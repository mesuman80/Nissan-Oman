//
//  VehicleDescriptionViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 12/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "VehicleDescriptionViewController.h"
#import "WebService.h"
#import "DescriptionView.h"

@interface VehicleDescriptionViewController ()<CustomWebServiceDelegate>

@end

@implementation VehicleDescriptionViewController
{
    NSDictionary *dataDictionary;
    CGFloat yVal;
    NSMutableArray *stringArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    stringArr = [[NSMutableArray alloc]initWithObjects:@"OVERVIEW",@"EXTERIOIR",@"EXTERIOR",@"PERFORMANCE",@"SAFETY",@"COLOR AND TRIM",@"VERSALITY",@"SPECIFICATION",@"GALLERY",@"TECHNOLOGY", nil];
   // stringArr = @[@"OVERVIEW",@"EXTERIOIR",@"EXTERIOR",@"PERFORMANCE",@"SAFETY",@"COLOR AND TRIM",@"VERSALITY",@"SPECIFICATION",@"GALLERY",@"TECHNOLOGY"];
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
    yVal = self.yCordinate + 2;
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, yVal, self.view.frame.size.width, .23*self.view.frame.size.height)];
    baseView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:baseView];
    yVal += baseView.frame.size.height + 10;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 100, 100)];
    NSURL *url = [NSURL URLWithString:[dataDictionary valueForKey:@"overview_image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
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
    
    [self drawButtons];
    
}

-(void)drawButtons
{
    int xx      = 0;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, yVal, self.view.frame.size.width, .4*self.view.frame.size.height)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    
    CGFloat yPos = 0;
    for(int i=0; i<10; i++)
    {
        DescriptionView *view = [[DescriptionView alloc]initWithFrame:CGRectMake(xx, yPos,self.view.frame.size.width/2 - 5, .06*self.view.frame.size.height) WithTitle:([stringArr objectAtIndex:i])];
        
        xx += view.frame.size.width +10;
        if(i %2 != 0) {
            xx = 0;
            yPos += view.frame.size.height + 5;
            
        }
        //else yVal += view.frame.size.height + 5;
       // [view setBackgroundColor:[UIColor orangeColor]];
        [scrollView addSubview:view];
       

    }
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, yPos, scrollView.frame.size.width, .1*scrollView.frame.size.height)];
    [btn setBackgroundColor:buttonRedColor];
    [btn setTitle:@"REQUEST A BROCHURE" forState:UIControlStateNormal];
    
    [scrollView addSubview:btn];
    
    [scrollView setContentSize:CGSizeMake(0, scrollView.frame.size.height *.15f + scrollView.frame.origin.y)];
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
