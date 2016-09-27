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
#import "GalleryViewController.h"
#import "SubDescriptionViewController.h"
#import "OverviewViewController.h"
#import "ExteriorViewController.h"
#import "ColorViewController.h"

@interface VehicleDescriptionViewController ()<CustomWebServiceDelegate>

@end

@implementation VehicleDescriptionViewController
{
    NSDictionary *dataDictionary;
    CGFloat yVal;
    NSMutableArray *stringArr;
    BOOL isFirstTime;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstTime = YES;
    stringArr = [[NSMutableArray alloc]initWithObjects:@"OVERVIEW",@"EXTERIOIR",@"INTERIOR",@"PERFORMANCE",@"SAFETY",@"COLOR AND TRIM",@"VERSATILITY",@"SPECIFICATION",@"GALLERY",@"TECHNOLOGY", nil];
   // stringArr = @[@"OVERVIEW",@"EXTERIOIR",@"EXTERIOR",@"PERFORMANCE",@"SAFETY",@"COLOR AND TRIM",@"VERSALITY",@"SPECIFICATION",@"GALLERY",@"TECHNOLOGY"];
    [self.navigationController setNavigationBarHidden:NO];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self getDescription];
    }
    
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
        view.tag = i;
        xx += view.frame.size.width +10;
        if(i %2 != 0) {
            xx = 0;
            yPos += view.frame.size.height + 5;
            
        }
        [view setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btntouched:)];
        [view addGestureRecognizer:gesture];
        //else yVal += view.frame.size.height + 5;
       // [view setBackgroundColor:[UIColor orangeColor]];
        [scrollView addSubview:view];
       

    }
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, yPos, scrollView.frame.size.width, .1*scrollView.frame.size.height)];
    [btn setBackgroundColor:buttonRedColor];
    [btn setTitle:@"REQUEST A BROCHURE" forState:UIControlStateNormal];
    
    [scrollView addSubview:btn];
    
    yPos += btn.frame.size.height + 5;
    
    [scrollView setContentSize:CGSizeMake(0, yPos)];
}


-(void)btntouched:(UITapGestureRecognizer *)sender
{
    UIView *view = (UIView *)sender.view;
    if(view.tag == 0)
    {
        NSString *overview = [dataDictionary valueForKey:@"vehicle_overview"];
        NSString *image = [dataDictionary valueForKey:@"overview_image"];

        [self.navigationController setNavigationBarHidden:NO];
        OverviewViewController *controller =[[OverviewViewController alloc]init];
        controller.dataArray = @[[dataDictionary valueForKey:@"vehicle_name"],@"PEFORMANCE",image,overview];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    if(view.tag == 1)
    {
        [self.navigationController setNavigationBarHidden:NO];
        
        ExteriorViewController *controller =[[ExteriorViewController alloc]init];
        controller.titleName = [dataDictionary valueForKey:@"vehicle_name"];
        controller.exteriorDataArray = [dataDictionary valueForKey:@"exterior"];
        controller.interiorDataArray = [dataDictionary valueForKey:@"interior"];

        controller.isexteriorSelected = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    if(view.tag == 2)
    {
        [self.navigationController setNavigationBarHidden:NO];
        
        ExteriorViewController *controller =[[ExteriorViewController alloc]init];
        controller.titleName = [dataDictionary valueForKey:@"vehicle_name"];
        controller.interiorDataArray = [dataDictionary valueForKey:@"interior"];
        controller.exteriorDataArray = [dataDictionary valueForKey:@"exterior"];

        controller.isinteriorSelected = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
    }

    if(view.tag == 3)
    {
        NSArray *arr = [dataDictionary valueForKey:@"performance"];
        [self.navigationController setNavigationBarHidden:NO];
        SubDescriptionViewController *controller =[[SubDescriptionViewController alloc]init];
        controller.dataArray = @[[dataDictionary valueForKey:@"vehicle_name"],@"PEFORMANCE",arr];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    if(view.tag == 4)
    {
        NSArray *arr = [dataDictionary valueForKey:@"safty"];
        [self.navigationController setNavigationBarHidden:NO];
        SubDescriptionViewController *controller =[[SubDescriptionViewController alloc]init];
        controller.dataArray = @[[dataDictionary valueForKey:@"vehicle_name"],@"SAFETY",arr];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    if(view.tag == 5)
    {
        NSArray *arr = [dataDictionary valueForKey:@"color_trim"];
        [self.navigationController setNavigationBarHidden:NO];
        ColorViewController *controller =[[ColorViewController alloc]init];
        controller.dataArray = @[[dataDictionary valueForKey:@"vehicle_name"],@"BODY COLOR",arr];
        [self.navigationController pushViewController:controller animated:YES];
        
    }

    if(view.tag == 6)
    {
        NSArray *arr = [dataDictionary valueForKey:@"versatility"];
        [self.navigationController setNavigationBarHidden:NO];
        SubDescriptionViewController *controller =[[SubDescriptionViewController alloc]init];
        controller.dataArray = @[[dataDictionary valueForKey:@"vehicle_name"],@"VERSATILITY",arr];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    
    if(view.tag == 8)
    {
       // [self.navigationController setNavigationBarHidden:NO];
        NSArray *arr = [dataDictionary valueForKey:@"gallery"];
        GalleryViewController *controller = [[GalleryViewController alloc]init];
        controller.title = [dataDictionary valueForKey:@"vehicle_name"];
        controller.dataArray = arr;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if(view.tag == 9)
    {
        NSArray *arr = [dataDictionary valueForKey:@"technology"];
        [self.navigationController setNavigationBarHidden:NO];
        SubDescriptionViewController *controller =[[SubDescriptionViewController alloc]init];
        controller.dataArray = @[[dataDictionary valueForKey:@"vehicle_name"],@"TECHNOLOGY",arr];
        [self.navigationController pushViewController:controller animated:YES];
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
