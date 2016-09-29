//
//  MapViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 16/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface MapViewController ()<GMSMapViewDelegate>
{
   
}

@end

@implementation MapViewController
{
    //MKMapView *mapView;
    NSString *_returnAddress;
    BOOL isFirstTime;
    GMSMapView *mapView;
    GMSMarker *marker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    //[self addMapView];
    isFirstTime = YES;
    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [self showLocation];
    if(isFirstTime)
    {
        isFirstTime = NO;
        //[self updateMap];
        [self mapIntegration];
    }
    
}

#pragma mark MAPS
-(void)mapIntegration
{
    [GMSServices provideAPIKey:GoogleiOSMapKeyScheme];
    
    NSString *latStr = [self.dict valueForKey:@"latitude"];
    double latdouble = [latStr doubleValue];
    
    NSString *longStr = [self.dict valueForKey:@"longitude"];
    double longdouble = [longStr doubleValue];

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latdouble longitude:longdouble zoom:12];
    
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) camera:camera];
    
    
    // mapView.settings.compassButton = YES;
    mapView.myLocationEnabled = YES;
    
    
    mapView.settings.myLocationButton = YES;
    mapView.delegate=self;
    
    
    marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    // marker.position = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    marker.appearAnimation = kGMSMarkerAnimationPop;
   // marker.icon = [UIImage imageNamed: isiPhoneiPad(@"default-marker.png")];
   marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
    NSString *str1 = [self.dict valueForKey:@"showroom_branch"];
    NSString *str2 = [self.dict valueForKey:@"showroom_address"];
    
    marker.snippet = str2;
    marker.title = str1;
    marker.map = mapView;
    [mapView setSelectedMarker:marker];
    
    [self.view addSubview:mapView];
    
    //[animateArray addObject:mapView];
    
    [self Searchplace];
    
    
}


-(void)Searchplace
{
    // -(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    //    if(searchLoc.length==0)
    //    {
    //        [self contractMapView];
    //        return;
    //    }
    
    NSString *latStr = [self.dict valueForKey:@"latitude"];
    double latdouble = [latStr doubleValue];
    
    NSString *longStr = [self.dict valueForKey:@"longitude"];
    double longdouble = [longStr doubleValue];

    
    CLLocationCoordinate2D center;
    center.latitude = latdouble;
    center.longitude = longdouble;
    [mapView animateToLocation:CLLocationCoordinate2DMake(latdouble, longdouble)];
    marker.position=CLLocationCoordinate2DMake(latdouble,longdouble);
    //mapView.camera= CLLocationCoordinate2DMake(latitude, longitude);
    
    //return center;
    
}

- (void)mapView:(GMSMapView *)mapView1
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
   
    
}


- (void)mapView:(GMSMapView *)mapView1 willMove:(BOOL)gesture {
    //[mapView1 clear];
}

- (void)mapView:(GMSMapView *)mapView1
idleAtCameraPosition:(GMSCameraPosition *)cameraPosition {
    id handler = ^(GMSReverseGeocodeResponse *response, NSError *error) {
        if (error == nil) {
            //            GMSReverseGeocodeResult *result = response.firstResult;
            //            GMSMarker *marker1 = [GMSMarker markerWithPosition:cameraPosition.target];
            //            marker1.title = result.lines[0];
            //            marker1.snippet = result.lines[1];
            //            marker1.map = mapView1;
            //            mapView1.myLocationEnabled = YES;
        }
    };
    //[geocoder_ reverseGeocodeCoordinate:cameraPosition.target completionHandler:handler];
}


-(BOOL)didTapMyLocationButtonForMapView:(GMSMapView *)mapView1{
    NSLog(@"You tapped at my location button ");
    
    NSString *latStr = [self.dict valueForKey:@"latitude"];
    double latdouble = [latStr doubleValue];
    
    NSString *longStr = [self.dict valueForKey:@"longitude"];
    double longdouble = [longStr doubleValue];
    
    CLLocationCoordinate2D target =
    CLLocationCoordinate2DMake(latdouble, longdouble);
    
    [mapView1 animateToLocation:target];
    
    mapView1.selectedMarker = nil;
    marker.position= target;
    
    NSString *str1 = [self.dict valueForKey:@"showroom_branch"];
    NSString *str2 = [self.dict valueForKey:@"showroom_address"];
    NSString *name = [NSString stringWithFormat:@"%@-%@",str1,str2];
    
    marker.snippet = name;
    
    return true;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"]) {
        //        CLLocation *location1 = [object myLocation];
        //        //...
        //        NSLog(@"Location, %@,", location1);
        //
        //        CLLocationCoordinate2D target =
        //        CLLocationCoordinate2DMake(location1.coordinate.latitude, location1.coordinate.longitude);
        //
        //        [mapView animateToLocation:target];
        //        [mapView animateToZoom:17];
    }
}

-(BOOL)mapView:(GMSMapView *)mapView1 didTapMarker:(GMSMarker *)markerTapped {
    
   
    NSString *latStr = [self.dict valueForKey:@"latitude"];
    double latdouble = [latStr doubleValue];
    
    NSString *longStr = [self.dict valueForKey:@"longitude"];
    double longdouble = [longStr doubleValue];

    CLLocationCoordinate2D target =
    CLLocationCoordinate2DMake(latdouble, longdouble);
    
    
    
    [mapView1 animateToLocation:target];
    
    marker.position= target;
    
    NSString *str1 = [self.dict valueForKey:@"showroom_branch"];
    NSString *str2 = [self.dict valueForKey:@"showroom_address"];
    //NSString *name = [NSString stringWithFormat:@"%@-%@",str1,str2];
    
    marker.snippet = str2;
    marker.title = str1;
    [mapView setSelectedMarker:marker];

    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)addMapView
 {
 mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
 mapView.showsBuildings = YES;
 mapView.mapType = MKMapTypeStandard;
 [self.view addSubview:mapView];
 
 }*/

/*-(void)updateMap
{
    MKCoordinateRegion region;
    NSString *latStr = [self.dict valueForKey:@"latitude"];
    double latdouble = [latStr doubleValue];
   
    NSString *longStr = [self.dict valueForKey:@"longitude"];
    double longdouble = [longStr doubleValue];
 
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
*/
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
