//
//  WhereAmIViewController.m
//  WhereAmI
//
//  Created by Admin on 3/4/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "WhereAmIViewController.h"
#import "WhereAmIMapPoint.h"

@interface WhereAmIViewController (){
        CLLocationManager *_locationManager;
}

@property (nonatomic, strong) IBOutlet MKMapView *worldView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UITextField *locationTitleField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *mapTypeToggle;


- (void) findLocation;
- (void) foundLocation:(CLLocation *)loc;

- (IBAction) toggleMapType:(id)sender;
@end

@implementation WhereAmIViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        _locationManager = [[CLLocationManager alloc] init];
        
        [_locationManager setDistanceFilter:50.0];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //[_locationManager startUpdatingLocation];
    }
    return self;
}

//Controller Interface Implementations
- (void) viewDidLoad{
    [[self worldView] setShowsUserLocation:YES];
    [[self worldView] setMapType:MKMapTypeStandard];
}

- (void) findLocation{
    [_locationManager startUpdatingLocation];
    [[self activityIndicator] startAnimating];
    [[self locationTitleField] setHidden:YES];
}

- (void) foundLocation:(CLLocation *)loc{
    CLLocationCoordinate2D coord = [loc coordinate];
    WhereAmIMapPoint *mp = [[WhereAmIMapPoint alloc] initWithCoordinate:coord
                                                                   title:[_locationTitleField text]];
    [[self worldView] addAnnotation:mp];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500, 500);
    [[self worldView] setRegion:region animated:YES];
    
    [[self locationTitleField] setText:@""];
    [[self activityIndicator] stopAnimating];
    [[self locationTitleField] setHidden:NO];
    [_locationManager stopUpdatingLocation];
}

- (IBAction) toggleMapType:(id)sender{
    int index = [_mapTypeToggle selectedSegmentIndex];
    
    if(index == 0){
        [[self worldView] setMapType:MKMapTypeStandard];
    }else if(index == 1){
        [[self worldView] setMapType:MKMapTypeHybrid];
    }else{
        [[self worldView] setMapType:MKMapTypeSatellite];
    }
}

//
//UITextFieldDelegate Implementation
//  
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self findLocation];
    [textField resignFirstResponder];
    
    return YES;
}

//CLLocationManagerDelegate Implementation
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    if(t < -180){
        return;
    }
    [self foundLocation:newLocation];
    NSLog(@"Location is: %@", newLocation);
    NSLog(@"Heading is: %@", [manager heading]);
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Could not find location: %@", error);
}

- (void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"New Heading: %@", newHeading);
}

- (BOOL) locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager{
    return YES;
}

//Map View Delegate Implementation
- (void ) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [[self worldView] setRegion:region animated:YES];
}

- (void) dealloc{
    [_locationManager setDelegate:nil];
}
@end
