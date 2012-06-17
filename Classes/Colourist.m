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
    
    [self registerColourDefault];
    UIColor *startColour = [self getPreferredColour];
    
    [self doColoursWithBase: startColour];
    return self;
}

-(void) registerColourDefault
{
    NSDictionary *defaultBaseColour = [self serialize:[UIColor colorWithHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0]];
    NSDictionary *newDefault = [NSDictionary dictionaryWithObjectsAndKeys:defaultBaseColour, @"baseColour", nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:newDefault];
    [defaults synchronize];
    NSLog(@"baseColour stored as: %@", [defaults objectForKey:@"baseColour"]);
}

-(UIColor *) getPreferredColour
{
    return [self deserialize:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"baseColour"]];
}

-(void) updatePreferredColour:(UIColor *)colour {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *serializedColour = [self serialize:colour];
    [defaults setObject:serializedColour forKey:@"baseColour"];
    [defaults synchronize];
}

-(NSDictionary *) serialize: (UIColor *)colour
{
    CGFloat hue, saturation, brightness, alpha;
    [colour getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithDouble:hue],        @"hue", 
                [NSNumber numberWithDouble:saturation], @"saturation",
                [NSNumber numberWithDouble:brightness], @"brightness",
                [NSNumber numberWithDouble:alpha],      @"alpha",      nil];
}

-(UIColor *) deserialize: (NSDictionary *)serializedColour {    
    float hue        = [(NSNumber *)[serializedColour objectForKey:@"hue"]        floatValue];
    float saturation = [(NSNumber *)[serializedColour objectForKey:@"saturation"] floatValue];
    float brightness = [(NSNumber *)[serializedColour objectForKey:@"brightness"] floatValue];
    float alpha      = [(NSNumber *)[serializedColour objectForKey:@"alpha"]      floatValue];
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}
     
-(void) doColoursWithBase: (UIColor *)theBaseColour
{
    [baseColour release]; [textColour release]; [highlightedColour release]; [fadingColour release];
    
    baseColour = theBaseColour; 
    textColour = [self textColourFor: baseColour]; 
    UIColor *complement = [self complementOf: baseColour];
    highlightedColour = [self opaqueVersionOf: complement];
    fadingColour = complement;
    
    [self updatePreferredColour:baseColour];
    
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
    
    if (brightness < 0.05 || brightness > 0.95) {
        hue=saturation=brightness=0.5;
    } else {
        hue += 0.5; if (hue > 1.0) { hue -= 1.0; }
    }
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

-(UIColor *) opaqueVersionOf: (UIColor *) colour
{
    
    CGFloat hue, saturation, brightness, alpha;
    [colour getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

-(void) dealloc {
    [baseColour        release];
    [textColour        release];
    [highlightedColour release];
    [fadingColour      release];
    [super dealloc];
}

@end
