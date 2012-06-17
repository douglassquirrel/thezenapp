//
//  ZenState.m
//  zen
//
//  Created by Douglas Squirrel on 15/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "Signaller.h"
#import "Sound.h"

@implementation Signaller

-(id) init
{
    if (!(self = [super init])) { return nil; }
    listeners = [[NSMutableSet alloc] init];
    return self;
}

-(void) addListener:(id)listener
{
    [listeners addObject:listener];
}

-(void) becomeZen
{
    if (TRUE == zenning) { return; }
    zenning = TRUE;
    for (id listener in listeners) { [listener becomingZen]; }
}

-(void) returnFromZen
{
    if (FALSE == zenning) { return; }
    zenning = FALSE;
    for (id listener in listeners) { [listener returningFromZen]; }
}

-(void) dealloc
{
    [listeners release];
    [super dealloc];
}

@end
