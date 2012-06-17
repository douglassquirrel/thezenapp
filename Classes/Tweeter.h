//
//  Tweeter.h
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import "TimerListener.h"

@interface Tweeter : NSObject <TimerListener>

{
    @private
    UIViewController * parentView;
    NSString *zenTimeString;
}

-(id) init:(UIViewController *) theParentView;
-(BOOL) canTweet;
-(void) tweet;
-(void) timerUpdated:(NSString *)zenTimeString;

@end
