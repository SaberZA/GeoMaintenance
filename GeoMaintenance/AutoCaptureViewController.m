//
//  AutoCaptureViewController.m
//  GeoMaintenance
//
//  Created by Steven Van der merwe on 2013/06/09.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "AutoCaptureViewController.h"
#import "GeoAnnotation.h"


@interface AutoCaptureViewController ()

@end

@implementation AutoCaptureViewController
@synthesize imagePickerController = _imagePickerController;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize mapViewLocation = _mapViewLocation;

-(void)setDetailItem:(id)detailItem
{
    if (_detailItem != detailItem) {
        _detailItem = detailItem;
    }
    
    [self configureView];
    
    // -- Might be needed for iPad
//    if (self.masterPopoverController != nil) {
//        [self.masterPopoverController dismissPopoverAnimated:YES];
//    }
    
}

-(void)configureView
{
    if (self.detailItem) {
        self.title = [(MenuItem *)self.detailItem shortLabel];
        //self.submitButton.titleLabel.text = [self.detailItem shortLabel];
    }
}

- (void)takePhoto:(id)sender
{
    // Lazily allocate image picker controller
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        
        // If our device has a camera, we want to take a picture, otherwise, we just pick from
        // photo library
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [_imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        }else
        {
            [_imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        
        // image picker needs a delegate so we can respond to its messages
        [_imagePickerController setDelegate:self];
    }
    // Place image picker on the screen
    [self presentModalViewController:_imagePickerController animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    [self dismissModalViewControllerAnimated:YES]; //Do this first!!
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //image = [ImageHelpers imageWithImage:image scaledToSize:CGSizeMake(480, 640)];
    NSLog(@"Saving image...");
    [self.imageView setImage:image];
}

-(void)startLocationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        //_locationManager.distanceFilter = 1000;
        _locationManager.delegate = self;
        //Deprecated in ios6.0 - purpose is now located in the info.plist under the key NSLocationUsageDescription
        //_locationManager.purpose
    }
    
    [_locationManager startUpdatingLocation];
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
//        [self parseXmlWithLocation:nil];
    }
}

//ios 6.0 method
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    //CLLocation *oldLocation = [locations objectAtIndex:1];
    NSLog(@"latitude %+.6f, longitude %+.6f, accuracy %1.2f, time %d"
          , newLocation.coordinate.latitude
          , newLocation.coordinate.longitude
          , newLocation.horizontalAccuracy
          , abs([newLocation.timestamp timeIntervalSinceNow]));
    
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 10.0) return;
    
    if (newLocation.horizontalAccuracy < 0) return;
    
    if (self.currentLocation == nil && newLocation.horizontalAccuracy <= _locationManager.desiredAccuracy) {
        self.currentLocation = newLocation;
        [self displaycurrentLocation];
//        [self reverseGeocode:newLocation];
//        [self parseXmlWithLocation:newLocation];
        
        [self stopLocationManager];
    }
}

-(void)displaycurrentLocation
{
    // 1
    CLLocationCoordinate2D zoomLocation;
    //    zoomLocation.latitude = -29.6167;//39.281516;
    //    zoomLocation.longitude= 30.3833;//-76.580806;
    NSLog(@"latitude: %3.2f",self.currentLocation.coordinate.latitude);
    NSLog(@"longitude: %3.2f",self.currentLocation.coordinate.longitude);
    zoomLocation.latitude = self.currentLocation.coordinate.latitude;
    zoomLocation.longitude = self.currentLocation.coordinate.longitude;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    //    MKCoordinateRegion viewRegion = MKCoordinateForMapPoint([MKMapPointMake(zoomLocation.latitude, zoomLocation.longitude)]);
    //    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(zoomLocation, MKCoordinateSpanMake(zoomLocation.latitude, zoomLocation.longitude));
    // 3
    [self.mapViewLocation setRegion:viewRegion animated:YES];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = zoomLocation.latitude;
    coordinate.longitude = zoomLocation.longitude;
    //    MyLocation *annotation = [[MyLocation alloc] initWithName:crimeDescription address:address coordinate:coordinate] ;
    
    
    GeoAnnotation *annotation = [[GeoAnnotation alloc] initWithCoordinate:coordinate];    
    annotation.title = @"Test Geo Location";
    [self.mapViewLocation addAnnotation:annotation];
    
//    EventAnnotation *annotation = [[EventAnnotation alloc] initWithCoordinate:coordinate];
//    annotation.title = @"TestEvent";
//    [_mapViewLocation addAnnotation:annotation];
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    if ([error code] != kCLErrorLocationUnknown) {
//        [self parseXmlWithLocation:nil];
        [self stopLocationManager];
    }
}

//0741961763
-(void)stopLocationManager
{
    [self.locationManager stopUpdatingLocation];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self startLocationManager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)captureImagePressed:(id)sender {
    // -- Uses photo picker and not camera
    [self takePhoto:self];
    
    
}


@end
