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
int start;
NSString *formatted_last_zen_time = nil;
bool timing = FALSE;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self end_zen_if_timing];
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

- (int) time_since:(int) start_time {
	int now = [[NSDate date] timeIntervalSince1970];
	return now - start_time;
}

- (void) record_zen_time {
    [formatted_last_zen_time release];
    int zen_time_in_seconds = [self time_since:start];
	formatted_last_zen_time = [[NSString alloc] initWithFormat:@"%02d:%02d", zen_time_in_seconds/60, zen_time_in_seconds%60];
}

- (void) reset {
	timerOutput.text = @"";
	[restartButton setHidden:YES];
    [tweetButton   setHidden:YES];
	if (audioPlayer != nil) { audioPlayer.currentTime = 0; [audioPlayer play]; }
	timing = TRUE;
	start = [[NSDate date] timeIntervalSince1970];
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

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
									      selector:@selector(stopping:)
										  name:UIApplicationWillResignActiveNotification
										  object:nil];
	
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/waves.mp3", [[NSBundle mainBundle] resourcePath]]];
	NSError *error;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	audioPlayer.numberOfLoops = -1;
	
	[self reset];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[self end_zen_if_timing];
}

- (void)dealloc {
    [super dealloc];
}

@end
