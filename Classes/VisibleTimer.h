//
//  VisibleTimer.h
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerListener.h"

@interface VisibleTimer : NSObject <TimerListener>

{
    @private
    UILabel *timerOutput;
}

-(id) init:(UILabel *)timerOutput;

@end
