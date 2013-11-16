//
//  MenuItem.m
//  GeoMaintenance
//
//  Created by Steven Van der merwe on 2013/06/09.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem
@synthesize label = _label;
@synthesize shortLabel = _shortLabel;
@synthesize segueIdentifier = _segueIdentifier;


-(id)initWithLabel:(NSString *)label :(NSString *)shortLabel :(NSString *)segueIdentifier
{
    self = [super init];
    self.label = label;
    self.shortLabel = shortLabel;
    self.segueIdentifier = segueIdentifier;
    return self;
}

@end
