//
//  zenViewController.h
//  zen
//
//  Created by Douglas Squirrel on 21/04/2012.
//  Copyright 2012 TheZenApp, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface zenViewController : UIViewController {
	IBOutlet UILabel *timerOutput;
	IBOutlet UIButton *restartButton;
	IBOutlet UIButton *tweetButton;
}

- (IBAction) restart:(id) sender;
- (IBAction) tweet:(id) sender;

@end

