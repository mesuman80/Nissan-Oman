//
//  GalleryViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 24/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "GalleryViewController.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController
{
    CGFloat yCordinate;
    
    
}
@synthesize title,dataArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addTitle];
    [self addSubTitle];
     [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(addScrollView) userInfo:nil repeats:NO];
    
   // [self addScrollView];

}
-(void)addTitle
{
    yCordinate =  self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 30)];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 20;
}

-(void)addSubTitle
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 20)];
    label.text = @"SWIPE IMAGES TO SEE";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:17.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 50;
    
}

-(void)addScrollView
{
    UIScrollView *horScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,yCordinate, self.view.frame.size.width , .20f*self.view.frame.size.height)];
    //[horScrollView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:horScrollView];
    horScrollView.pagingEnabled = YES;
    NSArray *arr = dataArray;
    
    CGFloat xpos = 10;
    for(NSDictionary *dict in arr)
    {
        NSString *str = [dict valueForKey:@"image"];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(xpos,0, horScrollView.frame.size.width - 20, horScrollView.frame.size.height)];
       //imgView.image = [UIImage imageNamed:str];
        
        NSURL *url = [NSURL URLWithString:str];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.image = img;
        
        [horScrollView addSubview: imgView];
        xpos += horScrollView.frame.size.width;
        horScrollView.showsHorizontalScrollIndicator = NO;
    }
    [horScrollView setContentSize:CGSizeMake(xpos, horScrollView.frame.size.height)];
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
