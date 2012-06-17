//
//  ColourPickerViewController.m
//  zen
//
//  Created by Douglas Squirrel on 17/06/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "ColourPickerViewController.h"

@interface ColourPickerViewController ()

@end

@implementation ColourPickerViewController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    image.pickedColorDelegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (IBAction) cancel:(id) sender       { [delegate pickedColour:nil];  }
- (void) pickedColor:(UIColor *)color { [delegate pickedColour:color]; }
@end
