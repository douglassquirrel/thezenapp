//
//  VisibilitySwitch.h
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenningListener.h"

@interface VisibilitySwitch : NSObject <ZenningListener>

{
    @private
    UIView *mainView;
}

-(id) init:(UIView *)view;

@end
