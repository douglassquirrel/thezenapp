//
//  Vector.m
//  zen
//
//  Created by Douglas Squirrel on 17/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "Vector.h"

@implementation Vector

-(id) init
{
    if (!(self = [super init])) { return nil; }
    x=y=z=0;
    return self;
}

-(id) initWithValues:(double)in_x :(double)in_y :(double)in_z
{
    if (!(self = [super init])) { return nil; }
    x=in_x; y=in_y; z=in_z;
    return self;
}

-(BOOL) isZero { return (x==0 && y==0 && z==0); }
-(double) abs { return sqrt(x*x + y*y + z*z); }
-(Vector *) differenceFrom: (Vector *) other { 
    return [[Vector alloc] initWithValues:(x-other->x) :(y-other->y) : (z-other->z)];
}
-(double) distanceFrom: (Vector *) other { 
    Vector *difference = [[self differenceFrom:other] autorelease];
    return [difference abs]; 
}

@end
