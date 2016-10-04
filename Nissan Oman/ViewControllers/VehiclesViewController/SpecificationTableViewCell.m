//
//  SpecificationTableViewCell.m
//  Nissan Oman
//
//  Created by Tripta Garg on 28/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "SpecificationTableViewCell.h"

@implementation SpecificationTableViewCell
{
    UIView *baseView;
    UILabel *textLabel;
    UILabel *rightLabel;
    
    UILabel *subHeadingLabel;;
}
@synthesize isSelected;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 48)];
        // baseView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:.8f ];
        baseView.backgroundColor = appGrayColor;
        [self.contentView addSubview:baseView];
        
    
        textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont systemFontOfSize:12.0f];
        [baseView addSubview:textLabel];
        
        subHeadingLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        subHeadingLabel.backgroundColor = [UIColor clearColor];
        subHeadingLabel.textAlignment = NSTextAlignmentLeft;
        subHeadingLabel.textColor = [UIColor grayColor];
        subHeadingLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:subHeadingLabel];

        
        rightLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.textAlignment = NSTextAlignmentLeft;
        rightLabel.textColor = [UIColor grayColor];
        rightLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [self.contentView addSubview:rightLabel];
       // rightArrImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        //[baseView addSubview:rightArrImgView];
        
        
    }
    return self;
    
}

- (void)configureCell:(SpecificationData *)data withWidth:(CGFloat)cellWidth
{
    
    baseView.frame = CGRectMake(0, 0, cellWidth, 48);
    textLabel.text = data.heading;
    [baseView setBackgroundColor:appGrayColor];
    
    CGSize size =[textLabel.text sizeWithAttributes:@{NSFontAttributeName : textLabel.font}];
    [textLabel setFrame:CGRectMake(10, 0, size.width, size.height+3)];
    textLabel.center = CGPointMake(textLabel.center.x, baseView.frame.size.height/2);
    
    
    rightLabel.frame = CGRectMake(cellWidth-30, 0, 20, 20);
    rightLabel.text = @"+";
    [rightLabel setTextColor:[UIColor whiteColor]];
    rightLabel.center = CGPointMake(rightLabel.center.x, baseView.frame.size.height/2);

    
    //rightArrImgView.image = [UIImage imageNamed:@"arrow_icon.png"];
    //rightArrImgView.center = CGPointMake(baseView.frame.size.width *.95f, baseView.frame.size.height/2);
    
    if(data.isSelected)
    {
        [baseView setBackgroundColor:buttonRedColor];
        
        subHeadingLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        NSString *headingStr = data.subHeading;
        subHeadingLabel.text = headingStr;
        subHeadingLabel.numberOfLines = 0;
        subHeadingLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize maximumLabelSize = CGSizeMake(cellWidth - 20, CGFLOAT_MAX);
        
        
        CGRect textRect = [headingStr boundingRectWithSize:maximumLabelSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                              attributes:@{NSFontAttributeName:subHeadingLabel.font}
                                                 context:nil];
        
        
       // CGSize displayValueSize = [headingStr sizeWithFont:subHeadingLabel.font
       //                            constrainedToSize:CGSizeMake(cellWidth - 20, CGFLOAT_MAX)
         //                              lineBreakMode:NSLineBreakByWordWrapping];
        
        subHeadingLabel.frame = CGRectMake(10, baseView.frame.size.height + 2, cellWidth - 20, textRect.size.height + 10);
        

         [self.contentView addSubview:subHeadingLabel];
        
         rightLabel.text = @"-";

    }
    else
    {
         rightLabel.text = @"+";
        [baseView setBackgroundColor:appGrayColor];
        [subHeadingLabel removeFromSuperview];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
