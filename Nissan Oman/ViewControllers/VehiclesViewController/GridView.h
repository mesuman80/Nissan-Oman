//
//  GridView.h
//  Nissan Oman
//
//  Created by Tripta Garg on 27/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridView : UIView

-(id)initWithFrame:(CGRect)frame withData:(NSArray *)array;
-(void)drawGridView;
@end
