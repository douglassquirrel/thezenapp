//
//  MotionDetector.h
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vector.h"
#import "Signaller.h"
#import "ZenningListener.h"

@interface MotionDetector : NSObject <UIAccelerometerDelegate, ZenningListener>

{
    @private
    Vector *startVector;
    Signaller *signaller;
}
-(id) init:(Signaller *) theSignaller;

@end
