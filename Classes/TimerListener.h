//
//  TimerListener.h
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimerListener <NSObject>

-(void) timerUpdated:(NSString *) zenTimeString;

@end
