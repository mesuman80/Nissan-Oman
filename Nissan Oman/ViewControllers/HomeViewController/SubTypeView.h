//
//  SubTypeView.h
//  Nissan Oman
//
//  Created by Tripta Garg on 12/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SubTypeView : UIView<UITableViewDataSource, UITableViewDelegate>

@property NSArray *dictionaryArray;;
@property NSArray *vehicleArr;
@property UIViewController *parentViewController;

@end
