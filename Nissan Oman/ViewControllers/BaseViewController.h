//
//  BaseViewController.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UIScrollViewDelegate>{
    Utility *utility;
    SharePreferenceUtil *sharePreferenceUtil;
    WebService *webService;
    UserData *userData;
    
    int yy,margin;
}

@property UIView *backgroundDimView;
@property float viewWidth, viewHeight, navigationHeight;
@property CGFloat y;

@end
