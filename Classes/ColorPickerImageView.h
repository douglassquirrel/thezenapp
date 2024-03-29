//
//  ColorPickerImageView.h
//  ColorPicker
//
//  Created by markj on 3/6/09.
//  Copyright 2009 Mark Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PickedColorDelegate <NSObject>
        
-(void) pickedColor:(UIColor *)color;

@end

@interface ColorPickerImageView : UIImageView {
	UIColor* lastColor;
	id <PickedColorDelegate> pickedColorDelegate;
}

@property (nonatomic, retain) UIColor* lastColor;
@property (nonatomic, retain) id pickedColorDelegate;

- (UIColor*) getPixelColorAtLocation:(CGPoint)point;
- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef)inImage;

@end
