//
//  ExteriorViewController.h
//  Nissan Oman
//
//  Created by Tripta Garg on 27/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "TabbarBaseViewController.h"

@interface ExteriorViewController : TabbarBaseViewController

@property NSString *titleName;
@property NSArray *interiorDataArray;
@property NSArray *exteriorDataArray;

@property UIButton *exteriorBtn;
@property UIButton *interiorBtn;

@property BOOL isexteriorSelected;
@property BOOL isinteriorSelected;

@end
