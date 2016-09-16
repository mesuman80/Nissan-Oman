//
//  CustomTableViewCell.m
//  Nissan Oman
//
//  Created by Tripta Garg on 09/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
{
    UIView *baseView;
    UILabel *textLabel;
    UIImageView *iconImgView;
    UIImageView *rightArrImgView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 2)];
       // baseView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:.8f ];
        baseView.backgroundColor = appGrayColor;
        [self.contentView addSubview:baseView];
        
        iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 30, 30)];
        [baseView addSubview:iconImgView];
        
        
        textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont systemFontOfSize:12.0f];
        [baseView addSubview:textLabel];
        
        rightArrImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        [baseView addSubview:rightArrImgView];
        
        
    }
    return self;
    
}

- (void)configureCell:(NSDictionary *)dict
{
    iconImgView.image = [UIImage imageNamed:[dict valueForKey:@"image"]];
    iconImgView.center = CGPointMake(iconImgView.center.x, baseView.frame.size.height/2);
    
    textLabel.text = [dict valueForKey:@"text"];
    CGSize size =[textLabel.text sizeWithAttributes:@{NSFontAttributeName : textLabel.font}];
    [textLabel setFrame:CGRectMake(50, 0, size.width, size.height+3)];
    textLabel.center = CGPointMake(textLabel.center.x, baseView.frame.size.height/2);
    
    
    rightArrImgView.image = [UIImage imageNamed:@"arrow_icon_gray"];
    rightArrImgView.center = CGPointMake(baseView.frame.size.width *.90f, baseView.frame.size.height/2);
    
    
}


@end
