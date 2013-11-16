//
//  GeoAnnotation.h
//  GeoMaintenance
//
//  Created by Steven Van der merwe on 2013/06/09.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface GeoAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d;

@end


