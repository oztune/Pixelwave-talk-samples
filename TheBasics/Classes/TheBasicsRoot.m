//
//  TheBasicsRoot.m
//  TheBasics
//
//  Created by Oz Michaeli on 8/30/11.
//  Copyright NA 2011. All rights reserved.
//

#import "TheBasicsRoot.h"

@implementation TheBasicsRoot

/**
 * The Basics:
 * - Vector drawing
 * - Image loading (Raccoon)
 * - Main loop (Rotating)
 * - Touch interaction (Touch following)
 */

- (void) initializeAsRoot
{
	raccoon = [PXTexture textureWithContentsOfFile:@"Rocky.png"];
	
	raccoon.anchorX = 0.5f;
	raccoon.anchorY = 0.5f;
	
	raccoon.x = self.stage.stageWidth * 0.5f;
	raccoon.y = self.stage.stageHeight * 0.5f;
	
	raccoon.smoothing = YES;
	
	targetX = raccoon.x;
	targetY = raccoon.y;
	
	[self addChild:raccoon];
	
	[self addEventListenerOfType:PXEvent_EnterFrame listener:PXListener(onEnterFrame:)];
	
	[self.stage addEventListenerOfType:PXTouchEvent_TouchDown listener:PXListener(updateTouch:)];
	[self.stage addEventListenerOfType:PXTouchEvent_TouchMove listener:PXListener(updateTouch:)];
}

- (void) updateTouch:(PXTouchEvent *)event
{
	targetX = event.stageX;
	targetY = event.stageY;
}

- (void) onEnterFrame:(PXEvent *)event
{
	float xd = targetX - raccoon.x;
	float yd = targetY - raccoon.y;
	
	float d = sqrtf(xd*xd + yd*yd);
	
	if (d == 0.0f)
	{
		xd = 0.0f;
		yd = 0.0f;
	}
	else
	{
		xd = xd / d;
		yd = yd / d;
	}
	
	float speed = 2.0f;
	
	raccoon.x += xd * speed;
	raccoon.y += yd * speed;
	
	raccoon.rotation += 1.0f;
}

- (void) dealloc
{
	[super dealloc];
}

@end
