//
//  MapViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 16/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "AddressAnnotation.h"

@interface MapViewController ()
{
    NSString *_returnAddress;
    BOOL isFirstTime;
}

@end

@implementation MapViewController
{
    MKMapView *mapView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self addMapView];
    isFirstTime = YES;
    // Do any additional setup after loading the view.
}

-(void)addMapView
{
    mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mapView.showsBuildings = YES;
    mapView.mapType = MKMapTypeStandard;
    [self.view addSubview:mapView];
    
 }
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [self showLocation];
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self updateMap];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateMap
{
    MKCoordinateRegion region;
    NSString *latStr = [self.dict valueForKey:@"latitude"];
    double latdouble = [latStr doubleValue];
   
    NSString *longStr = [self.dict valueForKey:@"longitude"];
    double longdouble = [longStr doubleValue];
    
  /*  region.center.latitude = latdouble;
    region.center.longitude = longdouble;
   // [mapView setRegion:region animated:YES];
    
   
    
    CLLocationCoordinate2D  ctrpoint;
    ctrpoint.latitude = latdouble;
    ctrpoint.longitude = longdouble;
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:ctrpoint];
    addAnnotation.title = [self.dict valueForKey:@"showroom_address"];

    [mapView addAnnotation:addAnnotation];
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(latdouble, longdouble);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 0, 0)];
    [mapView setRegion:adjustedRegion animated:YES]; */
    
    CLLocationCoordinate2D  location;
    location.latitude = latdouble; // change to your coordinate latitude
    location.longitude = longdouble; // change to your coordinate longitude
    
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
    addAnnotation.title = [self.dict valueForKey:@"showroom_address"];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.002;     // 0.0 is min value u van provide for zooming
    span.longitudeDelta= 0.002;
    
   // region.span=span;
    region.center =location;     // to locate to the center
    [mapView addAnnotation:addAnnotation];
   // [mapView setRegion:region animated:TRUE];
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(location, 500, 500)];
    [mapView setRegion:adjustedRegion animated:YES];
    [mapView regionThatFits:adjustedRegion];

    

}

/*- (void)getGeoInformations {
    // #2 - This will be called during view did load.
    NSLog(@"Inside getGeoInformations");
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
   
    //
    
    [geoCoder geocodeAddressString:@"Delhi" completionHandler:^(NSArray* placemarks, NSError* error){
        // This is called later, at some point after view did load is called.
        NSLog(@"Inside completionHandler.");
        
        if(error) {
            NSLog(@"Error");
            return;
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        NSArray *lines = placemark.addressDictionary[@"FormattedAddressLines"];
        NSString *str_latitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.latitude];
        NSString *str_longitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.longitude];
        NSString *returnAddress = [NSString stringWithFormat:@" %@, %@, %@", lines, str_latitude, str_longitude];
        
        
        MKCoordinateRegion region;
        region.center.latitude = str_latitude.integerValue;
        region.center.longitude = str_longitude.integerValue;
        [mapView setRegion:region animated:YES];
        
        // #4 - Now we have the return address, so we can pass it to the load method.
       // [self loadGeoInformations:returnAddress];
    }];
    
    // #3 - Anything here will be called during view did load, but BEFORE the completion handler of the geocoding process is called.
    NSLog(@"This is called third.");
}

- (void)loadGeoInformations:(NSString*)returnAddress {
    // #5 - this will be called last, some time after view did load is done.
    _returnAddress = returnAddress;
    NSLog(@"Inside load geo informations with return address: %@", _returnAddress);
} */



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
