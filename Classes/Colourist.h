//
//  Colourist.h
//  zen
//
//  Created by Douglas Squirrel on 17/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface Colourist : NSObject

{
    @private
    UIColor *baseColour;
    UIColor *textColour;
    UIColor *highlightedColour;
    UIColor *fadingColour;
}

-(id) init;
-(void) applyColoursTo:(UIView *) view;

@end
