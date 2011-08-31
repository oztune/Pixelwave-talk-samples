//
//  CustomGlyphsRoot.m
//  CustomGlyphs
//
//  Created by Oz Michaeli on 8/31/11.
//  Copyright NA 2011. All rights reserved.
//

#import "CustomGlyphsRoot.h"

@implementation CustomGlyphsRoot

- (void) initializeAsRoot
{
	// Entry point for the App. A good place to start.
	
	[PXFont registerFontWithContentsOfFile:@"MyFont.fnt" name:@"MyFont" options:nil];
	
	PXTextField *txt = [[PXTextField alloc] initWithFont:@"MyFont"];
	
	txt.x = self.stage.stageWidth * 0.5f;
	txt.y = self.stage.stageHeight * 0.5f;
	
	txt.align = PXTextFieldAlign_Center;
	
	txt.text = @"Custom Font";
	txt.textColor = 0xFFFFFF;
	
	[self addChild:txt];
	
}

- (void) dealloc
{
	// Cleaning up: Release retained objects, remove event listeners, etc.

	[super dealloc];
}

@end
