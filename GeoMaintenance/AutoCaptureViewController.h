//
//  AutoCaptureViewController.h
//  GeoMaintenance
//
//  Created by Steven Van der merwe on 2013/06/09.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "MenuItem.h"
@interface AutoCaptureViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *captureImageButton;

@property (strong, nonatomic) IBOutlet MKMapView *mapViewLocation;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (strong,nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@property (strong,nonatomic) id detailItem;
@property (strong,nonatomic) UIImagePickerController *imagePickerController;
- (IBAction)captureImagePressed:(id)sender;

@end
