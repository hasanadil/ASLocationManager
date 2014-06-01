//
//  ASLocationService.m
//  ASMapView
//
//  Created by Hasan on 5/1/14.
//  Copyright (c) 2014 AssembleLabs. All rights reserved.
//

#import "ASLocationManager.h"

@interface ASLocationManager() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (atomic, assign) BOOL isLocating;

/**
 Serial queue for adding location requests to internal storage
 */
@property (nonatomic, strong) dispatch_queue_t locationOperationsQueue;

/**
 Blocks which are awaiting for the user's location
 */
@property (nonatomic, strong) NSMutableSet *locationRequests;

@end

@implementation ASLocationManager

-(id) init {
    self = [super init];
    if (self) {
        _locationRequests = [NSMutableSet set];
        
        _locationOperationsQueue = dispatch_queue_create("com.assemblelabs.locationOperations", DISPATCH_QUEUE_SERIAL);
        
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        _isLocating = NO;
    }
    return self;
}

-(void) userLocationWithCompletion:(ASLocationCompletion)completion
{
    __weak typeof(self) me = self;
    dispatch_async(self.locationOperationsQueue, ^{
        
        [me.locationRequests addObject:[completion copy]];
        
        if (!me.isLocating) {
            [me.locationManager startUpdatingLocation];
            [me setIsLocating:YES];
        }
    });
}

/*
 Note: LocationManager calls the delegate on the main thread
 */
-(void) locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    __weak typeof(self) me = self;
    dispatch_async(self.locationOperationsQueue, ^{
        
        if ([me.locationRequests count] == 0) {
            [me.locationManager stopUpdatingLocation];
            me.isLocating = NO;
        }
        else {
            NSArray* currentLocationRequests = [me.locationRequests copy];
            [me.locationRequests removeAllObjects];
            
            [currentLocationRequests enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ASLocationCompletion completion = (ASLocationCompletion)obj;
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(newLocation);
                });
            }];
        }
    });
}

+(ASLocationManager*) sharedInstance
{
    static ASLocationManager* _locationManager;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _locationManager = [[ASLocationManager alloc] init];
    });
    return _locationManager;
}

@end























