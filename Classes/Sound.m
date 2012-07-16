//
//  ZenAudio.m
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "Sound.h"

@interface Sound()
- (void)createAudioPlayer;
@end

@implementation Sound

- (id)init {
    if (!(self = [super init])) { return nil; }
    
    [self createAudioPlayer];

    return self;
}

-(void) becomingZen 
{
    if (audioPlayer != nil) { audioPlayer.currentTime = 0; [audioPlayer play]; }
}

-(void) returningFromZen
{
    if (audioPlayer != nil) { [audioPlayer stop]; }
}

- (void)createAudioPlayer {
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/waves.mp3", [[NSBundle mainBundle] resourcePath]]];
	NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (nil != audioPlayer) { audioPlayer.numberOfLoops = -1; }
}

-(void) dealloc {
    [audioPlayer release];
    [super dealloc];
}

@end
