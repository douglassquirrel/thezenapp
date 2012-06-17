//
//  zenViewController.m
//  zen
//
//  Created by Douglas Squirrel on 21/04/2012.
//  Copyright 2012 TheZenApp, Ltd. All rights reserved.
//

#import "zenViewController.h"

@implementation zenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self assemble];
    
    [self configureButtons];

    [self.view setMultipleTouchEnabled:YES];    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopping:) name:UIApplicationWillResignActiveNotification object:nil];
    if (![tweeter canTweet]) { [tweetButton removeFromSuperview]; }
    [colourist applyColoursTo:[self view]];
    
	[signaller becomeZen];
}

- (void)assemble {
    colourist = [[Colourist alloc] init];
    
    timer = [[Timer alloc] init];
    tweeter = [[Tweeter alloc] init: self];
    visibleTimer = [[VisibleTimer alloc] init:timerOutput];
    
    [timer addListener:visibleTimer];
    [timer addListener:tweeter];
    
    signaller = [[Signaller alloc] init];
    motionDetector = [[MotionDetector alloc] init:signaller];
    sound = [[Sound alloc] init];
    touchSensor = [[TouchSensor alloc] init:colourist];
    visibilitySwitch = [[VisibilitySwitch alloc] init:[self view]];
    
    [signaller addListener:sound];
    [signaller addListener:motionDetector];
    [signaller addListener:timer];
    [signaller addListener:visibilitySwitch];
    [signaller addListener:touchSensor];
}

-(void) configureButtons {
    NSArray *subviews = [[self view] subviews];
    for (UIView *view in subviews) { 
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [[button layer] setCornerRadius:8.0f];
            [[button layer] setBorderWidth:1.0f];
        }
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event     { [touchSensor process:touches forView:self.view]; }
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event     { [signaller returnFromZen]; }
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event { [signaller returnFromZen]; }
//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event   { [signaller returnFromZen];}

- (IBAction) zenAgain:(id) sender { [signaller becomeZen]; }
- (IBAction) tweet:(id) sender    { [tweeter tweet];       }

- (void) stopping:(NSNotification *) notification { [signaller returnFromZen]; }
- (void) viewDidUnload                            {
    [signaller returnFromZen]; 
    
    [motionDetector release];
    [signaller release];
    [sound release];
    [timer release];
    [touchSensor release];
    [tweeter release];
    [visibilitySwitch release];
    [visibleTimer release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { return YES; }

//////// HOUSEKEEPING REQUIRED BY APPLE
- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }
- (void)dealloc { [super dealloc]; }

@end
