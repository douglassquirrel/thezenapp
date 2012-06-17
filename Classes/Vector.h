//
//  Vector.h
//  zen
//
//  Created by Douglas Squirrel on 17/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vector : NSObject

{ @private double x, y, z; }

-(id) init;
-(id) initWithValues:(double)in_x :(double)in_y :(double)in_z;

-(BOOL) isZero;
-(double) abs;
-(Vector *) differenceFrom: (Vector *) other;
-(double) distanceFrom: (Vector *) other;

@end
