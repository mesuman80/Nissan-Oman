//
//  AddressAnnotation.m
//  Nissan Oman
//
//  Created by Tripta Garg on 19/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation

- (NSString *)subtitle{
    return nil;
}

- (NSString *)title{
    return _title;
}

- (CLLocationCoordinate2D)coordinate{
    return _coordinate;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c{
    _coordinate = c;
    return self;
}

@end
