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
    UILabel *label;
    UIImageView *imgView;
    NSString *title;
}

-(id)initWithFrame:(CGRect)frame WithTitle:(NSString *)titleVal
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:appGrayColor];
        title = titleVal;
        [self drawButtons];
        return self;
    }
    return nil;
}

-(void)drawButtons
{
   
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, .6*self.frame.size.width, .7*self.frame.size.height)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    label.text = title;
    label.font = [UIFont systemFontOfSize:10.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(label.frame.size.width + label.frame.origin.x + 5, 0, 10, 10)];
    imgView.center = CGPointMake(imgView.center.x, self.frame.size.height/2);
    imgView.image = [UIImage imageNamed:@"arrow_icon.png"];
    [self addSubview:imgView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
