//
//  zenViewController.m
//  zen
//
//  Created by Douglas Squirrel on 21/04/2012.
//  Copyright 2012 TheZenApp, Ltd. All rights reserved.
//

#import <Twitter/Twitter.h>
#import "zenViewController.h"

@implementation zenViewController

AVAudioPlayer *audioPlayer;
int start_time;
double start_accel[3] = {0.0, 0.0, 0.0};
NSString *formatted_last_zen_time = nil;
bool timing = FALSE;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (FALSE == timing) { return; }
    
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = obj;
        CGPoint touchPoint = [touch locationInView:self.view];
        
        UIView *touchView = [[UIView alloc] init];
        touchView.tag = 314;
        [touchView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.5 alpha:0.5]];
        touchView.frame = CGRectMake(touchPoint.x-75, touchPoint.y-75, 150, 150);
        touchView.layer.cornerRadius = 75;
        [self.view addSubview:touchView];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        touchView.alpha = 0.0f;
        [UIView commitAnimations];
        [touchView release];
    }];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self end_zen_if_timing];
}

//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//	[self end_zen_if_timing];
//}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self end_zen_if_timing];
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    double x = acceleration.x; double y = acceleration.y; double z = acceleration.z;
    if (0.0 == start_accel[0] && 0.0 == start_accel[1] && 0.0 == start_accel[2]) {
        start_accel[0] = x; start_accel[1] = y; start_accel[2] = z;
    } else if ([self moved:x :y :z]) {
	    [self end_zen_if_timing];
    }
}

- (IBAction) restart:(id) sender {
	[self reset];
}

- (IBAction) tweet:(id) sender { 
    if ([TWTweetComposeViewController canSendTweet])
    {        
        NSString *tweet  = [NSString stringWithFormat: @"I just zenned for %@ with @thezenapp (http://thezenapp.com) - \"nothing\" has never felt so good!", 
                            formatted_last_zen_time];
            
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText: tweet];
        [self presentModalViewController:tweetSheet animated:YES];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] 
                                      initWithTitle: @"The ZenApp Master says"                                                             
                                      message: @"Twitter both is and is not, but it definitely is not here."                                                          
                                      delegate: self                                              
                                      cancelButtonTitle: @"OK"                                                   
                                      otherButtonTitles: nil];
        [alertView show];
    }
}

- (void) stopping:(NSNotification *) notification  {
    [self end_zen_if_timing];
}

- (bool) moved:(double) x :(double) y :(double) z {
    return (fabs(x - start_accel[0]) > 0.2 || 
            fabs(y - start_accel[1]) > 0.2 || 
            fabs(z - start_accel[2]) > 0.2);
}

- (int) time_since:(int) start_time {
	int now = [[NSDate date] timeIntervalSince1970];
	return now - start_time;
}

- (void) record_zen_time {
    [formatted_last_zen_time release];
    int zen_time_in_seconds = [self time_since:start_time];
	formatted_last_zen_time = [[NSString alloc] initWithFormat:@"%02d:%02d", zen_time_in_seconds/60, zen_time_in_seconds%60];
}

- (void) remove_touch_circles {
    NSArray *subviews = [self.view subviews];
    for (UIView *view in subviews) {
        if (314 == view.tag) {
            [view removeFromSuperview];
        }
    }
}
- (void) reset {
	timerOutput.text = @"";
	[restartButton setHidden:YES];
    [tweetButton   setHidden:YES];
	if (audioPlayer != nil) { audioPlayer.currentTime = 0; [audioPlayer play]; }
	timing = TRUE;
	start_time = [[NSDate date] timeIntervalSince1970];
    start_accel[0] = start_accel[1] = start_accel[2] = 0;
    [self remove_touch_circles];
}

- (void) end_zen_if_timing {
    if (TRUE == timing) {
        [self record_zen_time];
        timerOutput.text = [NSString stringWithFormat: @"You zenned for %@", formatted_last_zen_time];
        [restartButton setHidden:NO];
        [tweetButton   setHidden:NO];
        if (audioPlayer != nil) { [audioPlayer stop]; }
        timing = FALSE;
    }
}

- (void)viewDidLoad {
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/30.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
									      selector:@selector(stopping:)
										  name:UIApplicationWillResignActiveNotification
										  object:nil];
	
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/waves.mp3", [[NSBundle mainBundle] resourcePath]]];
	NSError *error;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	audioPlayer.numberOfLoops = -1;
    
    [self.view setMultipleTouchEnabled:YES];
	
	[self reset];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { return YES; }

- (void)viewDidUnload { [self end_zen_if_timing]; }

//////// HOUSEKEEPING REQUIRED BY APPLE
- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }
- (void)dealloc { [super dealloc]; }

@end
