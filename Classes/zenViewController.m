//
//  zenViewController.m
//  zen
//
//  Created by Douglas Squirrel on 21/04/2012.
//  Copyright 2012 TheZenApp, Ltd. All rights reserved.
//

#import "zenViewController.h"

@interface zenViewController()
- (void)assemble;
-(void) configureButtons;
-(void) createViews;
@end

@implementation zenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"The Zen App";

    [self assemble];
    
    [self configureButtons];
    [self createViews];

    [self.view setMultipleTouchEnabled:YES];    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
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
    zenRecords = [[ZenRecords alloc] init];
    
    [timer addListener:visibleTimer];
    [timer addListener:tweeter];
    [timer addListener:zenRecords];
    
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

-(void) createViews {
    colourPickerView = [[ColourPickerViewController alloc] initWithNibName:@"ColourPicker" bundle:[NSBundle mainBundle]];
    colourPickerView.delegate = self;
    logView = [[LogViewController alloc] initWithNibName:@"LogViewController" bundle: [NSBundle mainBundle]];
    logView.delegate = self;
    logView.records = zenRecords;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event     { [touchSensor process:touches forView:self.view]; }
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event     { [signaller returnFromZen]; }
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event { [signaller returnFromZen]; }
//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event   { [signaller returnFromZen];}

- (IBAction) colours:(id)sender   { 
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:colourPickerView];
    [self presentViewController:navigationController animated:YES completion: nil];
}

- (IBAction) log:(id)sender {
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:logView];
    [self presentViewController:navigationController animated:YES completion: nil];
}

- (IBAction) tweet:(id) sender    { [tweeter tweet];       }
- (IBAction) zenAgain:(id) sender { [signaller becomeZen]; }

-(void)pickedColour:(UIColor *) color;
{
    [self dismissModalViewControllerAnimated:YES];

    if (nil == color) { return; }
    [colourist doColoursWithBase:color];
    [colourist applyColoursTo:[self view]];
}

-(void)closeLog
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) stopping:(NSNotification *) notification { [signaller returnFromZen]; }

- (void) viewDidUnload                         
{
    [signaller returnFromZen]; 
    
    [colourPickerView release];
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

@end
