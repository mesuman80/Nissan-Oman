//
//  SubDescriptionViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 26/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "SubDescriptionViewController.h"

@interface SubDescriptionViewController ()<UIScrollViewDelegate>

@end

@implementation SubDescriptionViewController
{
    CGFloat yCordinate;
    UIScrollView *scrollView;
    BOOL isFirstTime;
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
        [self addScrollView];
    }
}


#pragma mark ui rendering

-(void)addTitle         // adding title
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

-(void)addSubTitle                  // adding sub title
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 300, 20)];
    label.text = [dataArray objectAtIndex:1];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:17.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 10;
    
}

-(void)addScrollView                // adding scroll view
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,yCordinate, self.view.frame.size.width , screenHeight - yCordinate)];
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    [self addElements];
   
}

-(void)addElements                  // adding heading and details
{
    NSArray *arr = [dataArray objectAtIndex:2];
    CGFloat initialX = 10;
    CGFloat initialY = 5;

    for(int i = 0; i<arr.count; i++)
    {
        NSDictionary *dict = [arr objectAtIndex:i];
        NSLog(@"dict = %@",dict);
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(initialX, initialY+ 8, 5, 5)] CGPath]];
        [[scrollView layer] addSublayer:circleLayer];
        [circleLayer setFillColor:[[UIColor blackColor] CGColor]];
        

        UILabel *headingLabel = [[UILabel alloc]init];
        headingLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        NSString *headingStr = [dict valueForKey:@"heading"];
        headingLabel.text = headingStr;
        headingLabel.numberOfLines = 0;
        headingLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize maximumLabelSize = CGSizeMake(scrollView.frame.size.width - 20, CGFLOAT_MAX);
        
        
        CGRect textRect = [headingStr boundingRectWithSize:maximumLabelSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                attributes:@{NSFontAttributeName:headingLabel.font}
                                                   context:nil];
        

        
        
        
        /*CGSize displayValueSize = [headingLabel.text sizeWithFont:headingLabel.font
                                            constrainedToSize:CGSizeMake(scrollView.frame.size.width - 20, CGFLOAT_MAX)
                                                lineBreakMode:NSLineBreakByWordWrapping]; */

        headingLabel.frame = CGRectMake(16, initialY, scrollView.frame.size.width - 20, textRect.size.height + 10);
        headingLabel.numberOfLines = 0;
        
        [scrollView addSubview:headingLabel];
        initialY += headingLabel.frame.size.height + 10;
        
        UILabel *subHeadingLabel = [[UILabel alloc]init];
        subHeadingLabel.font = [UIFont systemFontOfSize:8.0f];
        NSString *subHeadingStr = [dict valueForKey:@"subHeading"];
         subHeadingLabel.text = subHeadingStr;
        subHeadingLabel.textColor =[ UIColor grayColor];
        subHeadingLabel.numberOfLines = 0;
        subHeadingLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize maximumLabelSize1 = CGSizeMake(scrollView.frame.size.width - 20, CGFLOAT_MAX);
        
        
        CGRect textRect1 = [subHeadingStr boundingRectWithSize:maximumLabelSize1
                                                   options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                attributes:@{NSFontAttributeName:subHeadingLabel.font}
                                                   context:nil];
        

        
       /* CGSize labelSize = [subHeadingLabel.text sizeWithFont:subHeadingLabel.font
                                    constrainedToSize:CGSizeMake(scrollView.frame.size.width - 20, CGFLOAT_MAX)
                                        lineBreakMode:NSLineBreakByWordWrapping];*/
        
        subHeadingLabel.frame = CGRectMake(16, initialY, scrollView.frame.size.width - 20, textRect1.size.height);
       
        subHeadingLabel.numberOfLines = 0;
        [scrollView addSubview:subHeadingLabel];
        
        initialY += subHeadingLabel.frame.size.height + 5;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, initialY, scrollView.frame.size.width - 20, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [scrollView addSubview:lineView];
        
        initialY += 15;

        

    }
    
    [scrollView setContentSize:CGSizeMake(0, initialY + 30)];
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
