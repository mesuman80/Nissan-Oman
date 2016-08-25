//
//  InternetConnection.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@protocol InternetConnectionDelegate <NSObject>
-(void)isInternetConnection:(BOOL)connection;

@end


@interface InternetConnection : NSObject
@property id<InternetConnectionDelegate>delegate;
-(void)removeObserver;
-(BOOL)connectionStatus;
+(InternetConnection *)sharedInstance;


@end

