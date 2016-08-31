//
//  LoginBaseviewViewController.h
//  Nissan Oman
//
//  Created by Sakshi on 30/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginBaseviewViewController : UIViewController<UIScrollViewDelegate>{
    Utility *utility;
    SharePreferenceUtil *sharePreferenceUtil;
    WebService *webService;
    UserData *userData;
    
    int yy,margin;
}

@property UIImageView *upperLogo;
@property UIScrollView *scrollView;
@property UIView *backgroundDimView;
@property float viewWidth, viewHeight, navigationHeight;
@property CGFloat y;

-(void)setBackgoundImage;
-(void)setUpperLogo;
-(void)setupForScrollView;


@end
