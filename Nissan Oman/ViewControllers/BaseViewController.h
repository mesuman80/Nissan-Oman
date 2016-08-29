//
//  BaseViewController.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property UIImageView *upperLogo;
@property UIImageView *bottomBanner;
@property UIView *backgroundDimView;
@property float viewWidth, viewHeight, navigationHeight;


-(void)setBackgoundImage;
-(void)setUpperLogo:(UIImageView *)upperLogo;
-(void)setBottomBanner:(UIImageView *)bottomBanner;
@end
