//
//  EventAnnotation.m
//  Events
//
//  Created by Steven Van der merwe on 2013/05/01.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "EventAnnotation.h"


@implementation EventAnnotation
@synthesize label = _label;
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
