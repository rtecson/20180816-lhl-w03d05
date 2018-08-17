//
//  MyAnnotation.h
//  LocationsDemo
//
//  Created by Roland Tecson on 2018 August 16.
//  Copyright © 2018 MoozX Internet Ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface MyAnnotation : NSObject <MKAnnotation>

// MARK: - Public properties
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy,nullable) NSString *title;
@property (nonatomic,copy,nullable) NSString *subtitle;

@end
