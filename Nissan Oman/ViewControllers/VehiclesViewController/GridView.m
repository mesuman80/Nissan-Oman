//
//  GridView.m
//  Nissan Oman
//
//  Created by Tripta Garg on 27/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "GridView.h"

@implementation GridView
{
    NSString *imageName;
    NSString *carName;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame withData:(NSArray *)array
{
    if(self = [super initWithFrame:frame])
    {
        self.frame = frame;
        self.backgroundColor = [UIColor blackColor];
        carName = [array objectAtIndex:0];
        imageName = [array objectAtIndex:1];
        return self;
    }
    
    return self;
}

#pragma mark gridview rendering

-(void)drawGridView
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, self.frame.size.width - 40, .5*self.frame.size.height)];
    imgView.contentMode = UIViewContentModeScaleToFill;
    imgView.image = [UIImage imageNamed:imageName];
    imgView.center = CGPointMake(self.frame.size.width/2, imgView.center.y);
    [self addSubview:imgView];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imgView.frame.size.height + imgView.frame.origin.y + 10, 80, 10)];
    label.text = carName;
    label.textColor = [UIColor whiteColor];
    label.center = CGPointMake(self.frame.size.width/2, label.center.y);
    label.font = [UIFont boldSystemFontOfSize:10.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

@end
