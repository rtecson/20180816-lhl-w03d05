//
//  ViewController.m
//  LocationsDemo
//
//  Created by Roland Tecson on 2018 August 16.
//  Copyright © 2018 MoozX Internet Ventures. All rights reserved.
//

#import "ViewController.h"
@import CoreLocation;
@import MapKit;
#import "MyAnnotation.h"

@interface ViewController () <CLLocationManagerDelegate,MKMapViewDelegate>

// MARK: - IBOutlets
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

// MARK: - Private properties
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 20;
    self.locationManager.delegate = self;

    [self.locationManager requestWhenInUseAuthorization];

    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.mapType = MKMapTypeStandard; //MKMapTypeHybridFlyover;

    [self.mapView registerClass:[MKMarkerAnnotationView class] forAnnotationViewWithReuseIdentifier:@"myAnnotation"];

    MyAnnotation *annotation = [[MyAnnotation alloc] init];
    annotation.title = @"Something weird here";
    annotation.subtitle = @"I dunno what";
    annotation.coordinate = CLLocationCoordinate2DMake(40.6892656, -74.0466891);

    [self.mapView addAnnotation:annotation];
}

// MARK: - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"**** Authorization status: %d", status);
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"**** Manager failed: %@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"**** Updated locations %@", locations);
    CLLocation *loc = locations[0];
    [self.mapView setRegion:MKCoordinateRegionMake(loc.coordinate,
                                                   MKCoordinateSpanMake(0.2, 0.2))
                   animated:YES];
}

// MARK: - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MyAnnotation class]]) {
        MKMarkerAnnotationView *marker = (MKMarkerAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation" forAnnotation:annotation];

        marker.markerTintColor = [UIColor purpleColor];
        marker.glyphText = annotation.title;
        marker.titleVisibility = MKFeatureVisibilityVisible;
        marker.animatesWhenAdded = YES;

        return marker;
    }

    return nil;
}

@end
