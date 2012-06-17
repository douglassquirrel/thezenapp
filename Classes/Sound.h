//
//  ZenAudio.h
//  zen
//
//  Created by Douglas Squirrel on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "ZenningListener.h"

@interface Sound : NSObject <ZenningListener>

{
    @private
    AVAudioPlayer *audioPlayer;
}

-(id) init;

@end
