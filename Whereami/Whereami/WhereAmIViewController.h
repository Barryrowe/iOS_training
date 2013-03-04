//
//  WhereAmIViewController.h
//  WhereAmI
//
//  Created by Admin on 3/4/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereAmIViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>

@end
