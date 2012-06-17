//
//  Timer.h
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZenningListener.h"

@interface Timer : NSObject <ZenningListener>

{
    @private
    NSMutableSet *listeners;
    int start_time;
}
-(id) init;
-(void) addListener:(id)listener;

@end
