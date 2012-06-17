//
//  ZenningListener.h
//  zen
//
//  Created by J SCARBORO on 16/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZenningListener <NSObject>

-(void) becomingZen;
-(void) returningFromZen;

@end
