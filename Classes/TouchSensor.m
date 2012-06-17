//
//  TouchSensor.m
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "TouchSensor.h"

static int const TEMPORARY_TAG = 314;
static int const RADIUS = 75;

@implementation TouchSensor

-(id) init:(Colourist *) theColourist {
    if (!(self = [super init])) { return nil; }
    colourist = theColourist;
    return self;
}

-(void) process:(NSSet *)touches forView:(UIView *)view;
{
    if (!sensitised) { return; }
    
    for (UITouch *touch in touches) { 
        CGPoint point = [touch locationInView:view];
        UIView *circle = [self addCircleAt:&point]; 
        [view addSubview: circle];
        [self animate: circle];
        [circle release];
    }
}

-(UIView *) addCircleAt:(CGPoint *) centre
{
    UIView *circle = [[UIView alloc] init];
    circle.tag = TEMPORARY_TAG; 
    [colourist applyColoursTo:circle];
    circle.frame = CGRectMake(centre->x-RADIUS, centre->y-RADIUS, RADIUS*2, RADIUS*2);
    circle.layer.cornerRadius = RADIUS;
    return circle;
}

-(void) animate:(UIView *)circle
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    circle.alpha = 0.0f;
    [UIView commitAnimations];
}

-(void) becomingZen      { sensitised = TRUE; }
-(void) returningFromZen { sensitised = FALSE; }

@end
