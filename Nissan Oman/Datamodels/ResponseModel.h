//
//  ResponseModel.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResponseModel : NSObject

@property NSString *status;
@property NSString *errorMessage;
@property NSDictionary *results;
@property NSArray *resultsArray;

@end
