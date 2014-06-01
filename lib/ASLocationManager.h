//
//  ASLocationService.h
//  ASMapView
//
//  Created by Hasan on 5/1/14.
//  Copyright (c) 2014 AssembleLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^ASLocationCompletion)(CLLocation* location);

@interface ASLocationManager : NSObject

/**
 Fetch the user's location when available and the completion is passed the location.
 
 The completion block will only be called once with the user's location.
 */
-(void) userLocationWithCompletion:(ASLocationCompletion)completion;

/**
 Keep fetching the user's location when available and the completion is passed the location.
 */
-(void) streamUserLocationToDelegate:(ASLocationCompletion)delegate withCompletion:(void(^)(NSString* blockId))completion;

/**
 Stop streaming the user's location for the given blockId
 */
-(void) stopStreamingUserLocationForBlockWithId:(NSString*)blockId;


+(ASLocationManager*) sharedInstance;

@end
