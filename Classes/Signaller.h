//
//  ZenState.h
//  zen
//
//  Created by Douglas Squirrel on 15/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Signaller : NSObject

{
    @private
    BOOL zenning;
    NSMutableSet *listeners;
}

-(id) init;
-(void) addListener:(id) listener;
-(void) becomeZen;
-(void) returnFromZen;

@end
