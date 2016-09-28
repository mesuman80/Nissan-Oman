//
//  SpecificationTableViewCell.h
//  Nissan Oman
//
//  Created by Tripta Garg on 28/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecificationData.h"

@interface SpecificationTableViewCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)configureCell:(SpecificationData *)data withWidth:(CGFloat)cellWidth;

@property BOOL isSelected;
@end
