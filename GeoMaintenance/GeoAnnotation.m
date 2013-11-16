//
//  GeoAnnotation.m
//  GeoMaintenance
//
//  Created by Steven Van der merwe on 2013/06/09.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "GeoAnnotation.h"

@implementation GeoAnnotation 
@synthesize coordinate = _coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate{
    _coordinate = coordinate;
    return self;
}

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
    //	[self init];
	self.title = ttl;
	self.coordinate = c2d;
	return self;
}

@end
