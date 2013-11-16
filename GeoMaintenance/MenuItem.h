//
//  MenuItem.h
//  GeoMaintenance
//
//  Created by Steven Van der merwe on 2013/06/09.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject

@property (strong,nonatomic) NSString *label;
@property (strong,nonatomic) NSString *shortLabel;

@property (strong,nonatomic) NSString *segueIdentifier;


-(id)initWithLabel:(NSString *)label :(NSString *)shortLabel :(NSString *)segueIdentifier;
@end
