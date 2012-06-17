//
//  Colourist.m
//  zen
//
//  Created by Douglas Squirrel on 17/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "Colourist.h"

static int const TEMPORARY_TAG = 314;

@implementation Colourist

-(id) init 
{
    if (!(self = [super init])) { return nil; }
    [self doColoursWithBase: [UIColor colorWithRed:1.0 green:0.431 blue:0.718 alpha:0.18]];
    return self;
}

-(void) doColoursWithBase: (UIColor *)theBaseColour
{
    [baseColour release]; [textColour release]; [highlightedColour release]; [fadingColour release];
    
    baseColour = theBaseColour; 
    textColour = [self textColourFor: baseColour]; 
    UIColor *complement = [self complementOf: baseColour];
    highlightedColour = [self opaqueVersionOf: complement];
    fadingColour = complement;
    
    [baseColour retain]; [textColour retain]; [highlightedColour retain]; [fadingColour retain];
}

-(void) applyColoursTo:(UIView *) theView
{
    if ([theView isKindOfClass:[UILabel class]]) 
    {
        UILabel *label = (UILabel *) theView;
        [label setTextColor: textColour];
    } else if ([theView isKindOfClass:[UIButton class]]) 
    {
        UIButton *button = (UIButton *) theView;
        [button setTitleColor: textColour forState:UIControlStateNormal];
        [[button layer] setBorderColor: textColour.CGColor];
        [button setTitleColor: highlightedColour forState:UIControlStateHighlighted];
    } else if (TEMPORARY_TAG == theView.tag) 
    {
        [theView setBackgroundColor:fadingColour];
    } else
    {
        [theView setBackgroundColor:baseColour];
    }
    
    NSArray *subviews = [theView subviews];
    for (UIView *view in subviews) { [self applyColoursTo: view]; }
}

-(UIColor *) textColourFor: (UIColor *) colour
{
    CGFloat hue, saturation, brightness, alpha;
    [colour getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]; 
    
    return (brightness < 0.5) ? [UIColor whiteColor] : [UIColor blackColor];
}

-(UIColor *) complementOf: (UIColor *) colour
{
    CGFloat hue, saturation, brightness, alpha;
    [colour getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]; 
    
    hue += 0.5; if (hue > 1.0) { hue -= 1.0; }
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

-(UIColor *) opaqueVersionOf: (UIColor *) colour
{
    
    CGFloat hue, saturation, brightness, alpha;
    [colour getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

-(void) logColour:(UIColor *) color 
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSLog(@"Color components: %f,%f,%f,%f", components[0], components[1], components[2], components[3]);
}

-(void) dealloc {
    [baseColour        release];
    [textColour        release];
    [highlightedColour release];
    [fadingColour      release];
    [super dealloc];
}

@end
