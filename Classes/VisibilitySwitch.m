//
//  VisibilitySwitch.m
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "VisibilitySwitch.h"

static int const TEMPORARY_TAG = 314;

@interface VisibilitySwitch()
-(BOOL) isTemporary:(UIView *)view;
@end

@implementation VisibilitySwitch

-(id) init:(UIView *)theView
{
    if (!(self = [super init])) { return nil; }
    mainView = theView;
    return self;
}

-(void) becomingZen
{
    NSArray *subviews = [mainView subviews];
    for (UIView *view in subviews) 
    {
        if ([self isTemporary:view]) { [view removeFromSuperview]; }
        else                         { [view setHidden:TRUE];      }
    }
}

-(void) returningFromZen
{
    NSArray *subviews = [mainView subviews];
    for (UIView *view in subviews) { [view setHidden:FALSE]; }
}

-(BOOL) isTemporary:(UIView *)view
{
    if (view.tag == TEMPORARY_TAG) { return TRUE; } else { return FALSE; }
}

@end
