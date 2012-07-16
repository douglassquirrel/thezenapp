//
//  ZenRecords.h
//  zen
//
//  Created by Douglas Squirrel on 05/07/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerListener.h"

@interface ZenRecords : NSObject <TimerListener>
{    
    @private
    NSMutableArray *records;
}

-(id) init;
-(int) count;
-(id) recordAt:(int) index;

@end
