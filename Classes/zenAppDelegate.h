//
//  zenAppDelegate.h
//  zen
//
//  Created by Douglas Squirrel on 21/04/2012.
//  Copyright 2012 TheZenApp, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class zenViewController;

@interface zenAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    zenViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet zenViewController *viewController;

@end

