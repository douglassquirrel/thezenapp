//
//  VisibleTimer.m
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "VisibleTimer.h"

static NSString * const UPDATE_FORMAT = @"You zenned for %@";

@implementation VisibleTimer

-(id) init:(UILabel *)theTimerOutput
{
    if (!(self = [super init])) { return nil; }
    timerOutput = theTimerOutput;
    return self;
}

-(void) timerUpdated:(NSString *)zenTimeString
{
    timerOutput.text = [NSString stringWithFormat: UPDATE_FORMAT, zenTimeString];
}

@end
