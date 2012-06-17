//
//  Timer.m
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "Timer.h"
#import "TimerListener.h"

@implementation Timer

-(id)init
{
    if (!(self = [super init])) { return nil; }
    listeners = [[NSMutableSet alloc] init];
    return self;
}

-(void) addListener:(id)listener { 
    [listeners addObject:listener]; 
}

-(void) becomingZen
{
    start_time = [[NSDate date] timeIntervalSince1970];
}

-(void) returningFromZen
{
    int now = [[NSDate date] timeIntervalSince1970];
	int zen_time = now - start_time;
    NSString *zenTimeString = [NSString stringWithFormat:@"%02d:%02d", zen_time/60, zen_time%60];
    for (id listener in listeners) { [listener timerUpdated:zenTimeString]; }
}

-(void) dealloc
{
    [listeners release];
    [super dealloc];
}

@end
