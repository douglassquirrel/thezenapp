//
//  TouchSensor.h
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "ZenningListener.h"

@interface TouchSensor : NSObject <ZenningListener>

{
    @private
    BOOL sensitised;
}

-(void) process:(NSSet *)touches forView:(UIView *)view;
-(void) becomingZen;
-(void) returningFromZen;

@end
