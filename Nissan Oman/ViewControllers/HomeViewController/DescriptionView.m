//
//  DescriptionView.m
//  Nissan Oman
//
//  Created by Tripta Garg on 15/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "DescriptionView.h"
#import "Constants.h"

@implementation DescriptionView
{
    UIView *baseView;
    UILabel *label;
    UIImageView *imgView;
    NSString *title;
}

-(id)initWithFrame:(CGRect)frame WithTitle:(NSString *)titleVal
{
    if(self = [super initWithFrame:frame])
    {
        title = titleVal;
        [self drawButtons];
        return self;
    }
    return nil;
}

-(void)drawButtons
{
    baseView = [[UIView alloc]initWithFrame:self.frame];
    [baseView setBackgroundColor:appGrayColor];
    [self addSubview:baseView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, .8*self.frame.size.width, .7*self.frame.size.height)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.center = CGPointMake(baseView.frame.size.width/2, baseView.frame.size.height/2);
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:label];
    
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(label.frame.size.width + label.frame.origin.x + 5, 0, 20, 20)];
    imgView.center = CGPointMake(imgView.center.y, baseView.frame.size.height/2);
    imgView.image = [UIImage imageNamed:@"arrow_icon.png"];
    [baseView addSubview:imgView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
