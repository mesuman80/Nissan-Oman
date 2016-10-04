//
//  OverviewViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 27/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "OverviewViewController.h"

@interface OverviewViewController ()

@end

@implementation OverviewViewController
{
    CGFloat yCordinate;
    BOOL isFirstTime;
    Utility *utility;
}

@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    utility = [[Utility alloc]init];
    isFirstTime = YES;
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self addTitle];
        [self addSubTitle] ;
        [utility showHUD];
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(drawImageView) userInfo:nil repeats:NO];
        //[self drawImageView];
       // [self drawOverView];
    }
}

-(void)addTitle
{
    yCordinate =  self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 30)];
    label.text = [dataArray objectAtIndex:0];;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 5;
}

-(void)addSubTitle
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 20)];
    label.text = [dataArray objectAtIndex:1];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:17.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height;
    
}

-(void)drawImageView
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, yCordinate, self.view.frame.size.width - 40, .3*self.view.frame.size.height)];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    NSURL *url = [NSURL URLWithString:[dataArray objectAtIndex:2]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    imgView.image =img;
    imgView.center = CGPointMake(self.view.frame.size.width/2, imgView.center.y);
    [self.view addSubview:imgView];
    yCordinate += imgView.frame.size.height;
    
    [self drawOverView];
}

-(void)drawOverView
{
    UILabel *headingLabel = [[UILabel alloc]init];
    headingLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    NSString *headingStr = [dataArray objectAtIndex:3];
     headingLabel.text = headingStr;
    headingLabel.textColor = [UIColor grayColor];
    CGSize displayValueSize = [headingLabel.text sizeWithFont:headingLabel.font
                                            constrainedToSize:CGSizeMake(self.view.frame.size.width - 20, CGFLOAT_MAX)
                                                lineBreakMode:NSLineBreakByWordWrapping];
    
    headingLabel.frame = CGRectMake(16, yCordinate, self.view.frame.size.width - 20, displayValueSize.height + 10);
   headingLabel.numberOfLines = 0;
    [self.view addSubview:headingLabel];
    
    [utility hideHUD];


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
