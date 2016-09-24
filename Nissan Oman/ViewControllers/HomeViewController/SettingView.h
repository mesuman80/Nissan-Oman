//
//  SettingView.h
//  Nissan Oman
//
//  Created by Tripta Garg on 15/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingView : UIView<UITableViewDelegate, UITableViewDataSource>
@property UIViewController *rootController;
@property     UITableView *tableView;
@end
