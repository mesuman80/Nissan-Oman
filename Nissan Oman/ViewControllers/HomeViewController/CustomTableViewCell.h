//
//  CustomTableViewCell.h
//  Nissan Oman
//
//  Created by Tripta Garg on 09/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)configureCell:(NSDictionary *)dict;
@end
