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

#pragma mark view life cycle

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

#pragma mark settinf map to given city

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

#pragma mark mapview delegates

- (void)mapView:(GMSMapView *)mapView1 didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}


- (void)mapView:(GMSMapView *)mapView1 willMove:(BOOL)gesture {
    //[mapView1 clear];
}

- (void)mapView:(GMSMapView *)mapView1 idleAtCameraPosition:(GMSCameraPosition *)cameraPosition
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
