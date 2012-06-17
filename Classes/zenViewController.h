//
//  zenViewController.h
//  zen
//
//  Created by Douglas Squirrel on 21/04/2012.
//  Copyright 2012 TheZenApp, Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "ColourPickerViewController.h"
#import "Colourist.h"
#import "MotionDetector.h"
#import "Signaller.h"
#import "Sound.h"
#import "Timer.h"
#import "TouchSensor.h"
#import "Tweeter.h"
#import "VisibilitySwitch.h"
#import "VisibleTimer.h"

@interface zenViewController : UIViewController <ColourPickerDelegate>
{
	IBOutlet UILabel *timerOutput;
	IBOutlet UIButton *restartButton;
	IBOutlet UIButton *tweetButton;
    ColourPickerViewController *colourPickerView;

    @private
    Colourist *colourist;
    MotionDetector *motionDetector;
    Signaller *signaller;
    Sound *sound;
    Timer *timer;
    TouchSensor *touchSensor;
    Tweeter *tweeter;
    VisibilitySwitch *visibilitySwitch;
    VisibleTimer *visibleTimer;
}

- (IBAction) colours:(id) sender;
- (IBAction) tweet:(id) sender;
- (IBAction) zenAgain:(id) sender;

@end

