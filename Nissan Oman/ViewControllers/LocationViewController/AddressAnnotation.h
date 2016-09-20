//
//  AddressAnnotation.h
//  Nissan Oman
//
//  Created by Tripta Garg on 19/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
}

@property (nonatomic, retain) NSString *title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c;


@end
