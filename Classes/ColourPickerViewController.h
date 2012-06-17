//
//  ColourPickerViewController.h
//  zen
//
//  Created by Douglas Squirrel on 17/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickerImageView.h"

@protocol ColourPickerDelegate <NSObject>

-(void)pickedColour:(UIColor *) color;

@end

@interface ColourPickerViewController : UIViewController <PickedColorDelegate>
{
    IBOutlet UIButton *cancelButton;
    IBOutlet ColorPickerImageView *image;
    id <ColourPickerDelegate> delegate;
}

- (IBAction) cancel:(id) sender;

@property(nonatomic,assign)id delegate;

@end
