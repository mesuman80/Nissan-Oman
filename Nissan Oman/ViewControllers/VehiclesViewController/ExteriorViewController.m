//
//  ExteriorViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 27/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "ExteriorViewController.h"

@interface ExteriorViewController ()

@end

@implementation ExteriorViewController
{
    CGFloat yCordinate;
    BOOL isFirstTime;
    UIScrollView *interiorScrollView;
    UIScrollView *exteriorScrollView;
    Utility *utility;

}
@synthesize interiorDataArray, exteriorDataArray,titleName,interiorBtn,exteriorBtn,isinteriorSelected,isexteriorSelected;

#pragma mark view life cycle methods

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
        [self drawButtons];
        [utility showHUD];
        if(isinteriorSelected)
        {
            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(drawInteriorScrollView) userInfo:nil repeats:NO];
           // [self drawInteriorScrollView];
        }
        else
        {
             [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(drawExteriorScrollView) userInfo:nil repeats:NO];
           // [self drawExteriorScrollView];
        }
    }
}

#pragma mark ui rendering

-(void)addTitle                     // add title
{
    yCordinate =  self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 30)];
    label.text = titleName;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 5;
}

-(void)drawInteriorScrollView                   // adding interiro scroll view
{

    interiorScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,yCordinate, self.view.frame.size.width , .50f*self.view.frame.size.height)];
    //[horScrollView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:interiorScrollView];
    interiorScrollView.pagingEnabled = YES;
    NSArray *arr = interiorDataArray;
    
    CGFloat xpos = 10;
    for(NSDictionary *dict in arr)
    {
        NSString *str = [dict valueForKey:@"image"];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(xpos,0, interiorScrollView.frame.size.width - 20, interiorScrollView.frame.size.height *.45)];
        //imgView.image = [UIImage imageNamed:str];
        
        NSURL *url = [NSURL URLWithString:str];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        //imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.image = img;
        
        [interiorScrollView addSubview: imgView];
        interiorScrollView.showsHorizontalScrollIndicator = NO;
        
        NSString *text = [dict valueForKey:@"text"];
        UILabel *headingLabel = [[UILabel alloc]init];
        headingLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        NSString *headingStr = text;
        headingLabel.text = headingStr;
        headingLabel.textColor = [UIColor grayColor];
        
        headingLabel.numberOfLines = 0;
        headingLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize maximumLabelSize = CGSizeMake(interiorScrollView.frame.size.width - 20, CGFLOAT_MAX);
        
        
        CGRect textRect = [headingStr boundingRectWithSize:maximumLabelSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                attributes:@{NSFontAttributeName:headingLabel.font}
                                                   context:nil];
        

        
       /* CGSize displayValueSize = [text sizeWithFont:headingLabel.font
                                   constrainedToSize:CGSizeMake(interiorScrollView.frame.size.width -20, CGFLOAT_MAX)
                                       lineBreakMode:NSLineBreakByWordWrapping]; */
        
        headingLabel.frame = CGRectMake(xpos, imgView.frame.size.height + 2, interiorScrollView.frame.size.width - 20, textRect.size.height + 10);
        headingLabel.numberOfLines = 0;
        
        
        
        [interiorScrollView addSubview:headingLabel];
        
        xpos += interiorScrollView.frame.size.width;

}
    [interiorScrollView setContentSize:CGSizeMake(xpos, interiorScrollView.frame.size.height)];
    [utility hideHUD];

}

-(void)drawExteriorScrollView               // drawing exterior scrollview
{
    exteriorScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,yCordinate, self.view.frame.size.width , .50f*self.view.frame.size.height)];
    //[horScrollView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:exteriorScrollView];
    exteriorScrollView.pagingEnabled = YES;
    NSArray *arr = exteriorDataArray;
    
    CGFloat xpos = 10;
    
    for(NSDictionary *dict in arr)
    {
        
        CGFloat imgHeight = exteriorScrollView.frame.size.height*.45;
        
        NSString *text = [dict valueForKey:@"text"];
        UILabel *headingLabel = [[UILabel alloc]init];
        headingLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        NSString *headingStr = text;
        headingLabel.text = headingStr;
        headingLabel.textColor = [UIColor grayColor];
        
        headingLabel.numberOfLines = 0;
        headingLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize maximumLabelSize = CGSizeMake(exteriorScrollView.frame.size.width - 20, CGFLOAT_MAX);
        
        
        CGRect textRect = [headingStr boundingRectWithSize:maximumLabelSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                attributes:@{NSFontAttributeName:headingLabel.font}
                                                   context:nil];
        

        
       /* CGSize displayValueSize = [text sizeWithFont:headingLabel.font
                                   constrainedToSize:CGSizeMake(exteriorScrollView.frame.size.width -20, CGFLOAT_MAX)
                                       lineBreakMode:NSLineBreakByWordWrapping]; */
        
        headingLabel.frame = CGRectMake(xpos, imgHeight + 5, exteriorScrollView.frame.size.width - 20, textRect.size.height + 10);
        headingLabel.numberOfLines = 0;
        
        [exteriorScrollView addSubview:headingLabel];
        
        
        NSString *str = [dict valueForKey:@"image"];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(xpos,0, exteriorScrollView.frame.size.width - 20, imgHeight)];
        //imgView.image = [UIImage imageNamed:str];
        
        NSURL *url = [NSURL URLWithString:str];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        // imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.image = img;
        
        [exteriorScrollView addSubview: imgView];
        
        exteriorScrollView.showsHorizontalScrollIndicator = NO;
        
        
       
        
         xpos += exteriorScrollView.frame.size.width;
    }
    [exteriorScrollView setContentSize:CGSizeMake(xpos, exteriorScrollView.frame.size.height)];
    [utility hideHUD];
}


-(void)drawButtons              // adding bottom buttons
{
    exteriorBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, .8*self.view.frame.size.height, .4*self.view.frame.size.width, 40)];
    [exteriorBtn setBackgroundColor:appGrayColor];
    [exteriorBtn setTitle:@"EXTERIOR" forState:UIControlStateNormal];
    [exteriorBtn addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exteriorBtn];
    exteriorBtn.tag = 0;
    
    if(isexteriorSelected)
    {
        exteriorBtn.backgroundColor = buttonRedColor;
    }
    
    
    interiorBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - .4*self.view.frame.size.width - 20, .8*self.view.frame.size.height, .4*self.view.frame.size.width, 40)];
    [interiorBtn setBackgroundColor:appGrayColor];
    [interiorBtn setTitle:@"INTERIOR" forState:UIControlStateNormal];
    [interiorBtn addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    interiorBtn.tag = 1;
    if(isinteriorSelected)
    {
        interiorBtn.backgroundColor = buttonRedColor;
    }

    [self.view addSubview:interiorBtn];

}

#pragma mark touch handler of bottom buttons

-(void)btnTouched:(UIButton *)sender
{
    if(sender.tag == 0)                         // for exterior button
    {
        exteriorBtn.backgroundColor = buttonRedColor;
        interiorBtn.backgroundColor = appGrayColor;
        if(sender.isSelected)
        {
            
        }
        else
        {
            if(!exteriorScrollView)
            {
                //[self drawExteriorScrollView];
                 [utility showHUD];
                 [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(drawExteriorScrollView) userInfo:nil repeats:NO];
            }
            else
            {
                [utility hideHUD];
                exteriorScrollView.alpha = 1.0f;
            }
            interiorScrollView.alpha = 0.0f;
        }
    }
    else                                                    // for interior button
    {
        exteriorBtn.backgroundColor = appGrayColor;
        interiorBtn.backgroundColor = buttonRedColor;
        if(sender.isSelected)
        {
            
        }
        else
        {
            if(!interiorScrollView)
            {
                //[self drawInteriorScrollView];
                 [utility showHUD];
                 [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(drawInteriorScrollView) userInfo:nil repeats:NO];
            }
            else
            {
                [utility hideHUD];
                interiorScrollView.alpha = 1.0f;
            }
            exteriorScrollView.alpha = 0.0f;
        }

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
