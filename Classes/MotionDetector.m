//
//  MotionDetector.m
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "MotionDetector.h"
#import "Signaller.h"
#import "Vector.h"

static double const UPDATE_INTERVAL = 1.0/30.0;
static double const MOVEMENT_LIMIT = 0.35;

@implementation MotionDetector

- (id)init:(Signaller *)theSignaller {
    if (!(self = [super init])) { return nil; }
    
    signaller = theSignaller;
    startVector = [[Vector alloc] init];
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:UPDATE_INTERVAL];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
    return self;
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    Vector *currentVector = [self toVector: acceleration];
    if ([startVector isZero]) {
        [startVector release];
        startVector = currentVector;
        [startVector retain];
    } else if ([startVector distanceFrom:currentVector] > MOVEMENT_LIMIT) {
	    [signaller returnFromZen];
    }
    [currentVector release];
}

- (void) becomingZen { 
    [startVector release];
    startVector = [[Vector alloc] init];
}

- (void) returningFromZen { }

- (Vector *) toVector:(UIAcceleration *) acceleration
{
    return [[Vector alloc] initWithValues:acceleration.x :acceleration.y :acceleration.z];
}

-(void) dealloc 
{
    [startVector release];
    [super dealloc];
}

@end
