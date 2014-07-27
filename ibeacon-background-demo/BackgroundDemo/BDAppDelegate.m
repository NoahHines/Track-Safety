//
//  BDAppDelegate.m
//  BackgroundDemo
//
//  Created by David G. Young on 11/6/13.
//  Copyright (c) 2013 RadiusNetworks. All rights reserved.
//

#import "BDAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>


@implementation BDAppDelegate
{
    CLLocationManager *_locationManager;
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"applicationDidFinishLaunching");
    
    [GMSServices provideAPIKey:@"AIzaSyCATGL-5asHQfkkEO9TaQJNmPrsEcRjs9w"];

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    CLBeaconRegion *region;

    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] identifier: @"region1"];
    region.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region];
    [_locationManager stopRangingBeaconsInRegion:region];
    //[_locationManager startRangingBeaconsInRegion:region];

    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] major: 1 minor: 2 identifier: @"region2"];
    region.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region];
    [_locationManager stopRangingBeaconsInRegion:region];
    //[_locationManager startRangingBeaconsInRegion:region];
    
    // This location manager will be used to notify the user of region state transitions when the app has been previously terminated.
    //_locationManager = [[CLLocationManager alloc] init];
    //_locationManager.delegate = self;
    

    
    
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];

    if(state == CLRegionStateInside) {
        NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
        notification.alertBody = [NSString stringWithFormat:@"Train approaching highway-rail crossing! Stay off the tracks!"];
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        

    }
    else if(state == CLRegionStateOutside) {
        NSLog(@"locationManager didDetermineState OUTSIDE for %@", region.identifier);
        notification.alertBody = [NSString stringWithFormat:@"You are outside region %@", region.identifier];
    }
    else {
        NSLog(@"locationManager didDetermineState OTHER for %@", region.identifier);
    }

    
    
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    // I commented out the line below because otherwise you see this every second in the logs
    // NSLog(@"locationManager didRangeBeacons");
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"applicationWillTerminate");
}

@end

