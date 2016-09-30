//
//  CustomTextField.m
//  Nissan Oman
//
//  Created by Sakshi on 29/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "CustomTextField.h"

@interface CustomTextField () <UITextFieldDelegate>

@end

@implementation CustomTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.layer setBorderWidth:1.0];
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
        UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,30,ScreenHeightFactor*50)];
        leftView.backgroundColor = [UIColor clearColor];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark draw placeholder in textfield

- (void)drawPlaceholderInRect:(CGRect)rect
{
    UIColor *colour = [UIColor whiteColor];
    
    if ([self.placeholder respondsToSelector:@selector(drawInRect:withAttributes:)]) {
        // iOS7 and later
        NSDictionary *attributes = @{NSForegroundColorAttributeName: colour, NSFontAttributeName: [UIFont systemFontOfSize:12]};
        CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
        [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];
    }
    else {
        // iOS 6
        [colour setFill];
        [self.placeholder drawInRect:rect withFont:[UIFont systemFontOfSize:12] lineBreakMode:NSLineBreakByTruncatingTail alignment:self.textAlignment];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
