//
//  Tweeter.m
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "Tweeter.h"

static NSString * const TWEET_FORMAT = @"I just zenned for %@ with @thezenapp (http://thezenapp.com) - \"nothing\" has never felt so good!";

@implementation Tweeter

-(id) init:(UIViewController *) theParentView
{
    if (!(self = [super init])) { return nil; }
    parentView = theParentView;
    return self;
}

-(void) tweet
{
    NSString *tweet = [NSString stringWithFormat: TWEET_FORMAT, zenTimeString];
    
    TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
    [tweetSheet setInitialText: tweet];
    [parentView presentModalViewController:tweetSheet animated:YES];
    [tweetSheet release];
}

-(BOOL) canTweet { return [TWTweetComposeViewController canSendTweet]; }
-(void) timerUpdated:(NSString *)theZenTimeString { zenTimeString = theZenTimeString; [zenTimeString retain]; }

@end
