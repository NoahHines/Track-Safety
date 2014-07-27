//
//  BDViewController.m
//  BackgroundDemo
//
//  Created by David G. Young on 11/6/13.
//  Copyright (c) 2013 RadiusNetworks. All rights reserved.
//

#import "BDViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface BDViewController () {

    GMSMapView *mapView_;


    
}

@end

@implementation BDViewController {
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    



    CLLocationDegrees currentLatitude = 41.258734;
    CLLocationDegrees currentLongitude = -95.934933;
    
    /*INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                       timeout:10.0
                          delayUntilAuthorized:YES  // This parameter is optional, defaults to NO if omitted
                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                            CLLocationDegrees currentLatitude = currentLocation.coordinate.latitude;
                                            CLLocationDegrees currentLongitude = currentLocation.coordinate.longitude;
                                             if (status == INTULocationStatusSuccess) {
                                                 NSLog(@"Location request timed out. Current Location:\n%@", currentLocation);
                                                 // Request succeeded, meaning achievedAccuracy is at least the requested accuracy, and
                                                 // currentLocation contains the device's current location.
                                             }
                                             else if (status == INTULocationStatusTimedOut) {
                                                 // Wasn't able to locate the user with the requested accuracy within the timeout interval.
                                                 // However, currentLocation contains the best location available (if any) as of right now,
                                                 // and achievedAccuracy has info on the accuracy/recency of the location in currentLocation.
                                             }
                                             else {
                                                 // An error occurred, more info is available by looking at the specific status returned.
                                             }
                                         }];
    
    
    */
    

    

    

    NSData *responseData = [[NSData alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource: @"json_array" withExtension:@"json"]];
   
    NSError *error = NULL;
    //NSData* data = [yourJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    NSArray *resultArray = [json objectForKey:@"ns"];//resultArray contains array type objects...
    //NSLog(@"%@", resultArray[0][0]);
    
    /*for (int i = 0; i < [resultArray count]; i++) {
        NSLog(@"%@",resultArray[i][0]);
    }*/
    
    
    // Position the camera at 0,0 and zoom level 1.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentLatitude
                                                            longitude:currentLongitude
                                                                 zoom:15];
    
    
    // Create the GMSMapView with the camera position.
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    
    for(int i=0;i<[resultArray count];i++)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([resultArray[i][1] doubleValue],[resultArray[i][2] doubleValue]);
        

        
        marker.title = resultArray[i][0];
        marker.snippet = @"Union Pacific";
        marker.map = mapView_;
    }
    
    // Set the controller view to be the MapView.
    self.view = mapView_;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
