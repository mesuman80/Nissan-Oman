//
//  ColorViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 27/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "ColorViewController.h"
#import "Common.h"

@interface ColorViewController ()

@end

@implementation ColorViewController

{
    CGFloat yCordinate;
    BOOL isFirstTime;
    UIImageView *imgView ;
}

@synthesize dataArray;

#pragma mark view life cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    
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
        
        [self addImageView];
        [self addColorView];
    }
}

#pragma mark ui rendering

-(void)addTitle                             // add title
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

-(void)addSubTitle                          // add subtitle
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

-(void)addImageView                         // add imageview
{
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, yCordinate, self.view.frame.size.width - 40, .3*self.view.frame.size.height)];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    NSArray *arr = [dataArray objectAtIndex:2];
    NSDictionary *dict = [arr objectAtIndex:0];
    
    
    NSURL *url = [NSURL URLWithString:[dict valueForKey:@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    imgView.image =img;
    imgView.center = CGPointMake(self.view.frame.size.width/2, imgView.center.y);
    [self.view addSubview:imgView];
    yCordinate += imgView.frame.size.height;
    
 
}
-(void)addColorView                 // add color view in different shades
{
    NSArray *arr = [dataArray objectAtIndex:2];
    CGFloat xPos = .1*self.view.frame.size.width;
    CGFloat yPos = .65*self.view.frame.size.height;
    int i=0;
    for(NSDictionary *dict in arr)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(xPos, yPos, 40, 40)];
        [self.view addSubview:view];
        view.layer.borderWidth =1.0f;
        view.layer.borderColor = [[UIColor orangeColor]CGColor];
        view.backgroundColor = [Common colorWithHexString:[dict valueForKey:@"color"] withAlpha:1.0f];
        view.tag = i;
        xPos += view.frame.size.width + 10;
        if(i%4 != 0 && i%4 != 1 && i%4 != 2)
        {
            xPos = .1*self.view.frame.size.width;
            yPos += view.frame.size.height + 10;
        }
        i++;
        [view setUserInteractionEnabled:YES];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(colorSelected:)];
        [view addGestureRecognizer:gesture];
    }
}

#pragma mark color button touch implementation

-(void)colorSelected:(UITapGestureRecognizer *)gesture
{
    UIView *view = gesture.view;
    NSArray *arr = [dataArray objectAtIndex:2];
    NSDictionary *dict = [arr objectAtIndex:view.tag];
    
    
    NSURL *url = [NSURL URLWithString:[dict valueForKey:@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    imgView.image =img;

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
