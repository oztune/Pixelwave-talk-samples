//
//  SpriteAnimationsRoot.m
//  SpriteAnimations
//
//  Created by Oz Michaeli on 8/29/11.
//  Copyright Spiralstorm Games 2011. All rights reserved.
//

#import "SpriteAnimationsRoot.h"

#import "AnimationClip.h"

@interface SpriteAnimationsRoot (Private)
- (BOOL)deviceIsIPad;
@end

@implementation SpriteAnimationsRoot

- (void) initializeAsRoot
{
	self.stage.backgroundColor = 0xA5D5E9;
	
	BOOL deviceIsIPad = [self deviceIsIPad];
	
	NSString *fileName = deviceIsIPad ? @"RobotWalk@2x.json" : @"RobotWalk.json";
	
	PXTextureAtlas *robotWalkAtlas = [PXTextureAtlas textureAtlasWithContentsOfFile:fileName modifier:nil];
	
	NSArray *animationFrames = [robotWalkAtlas sequentialFramesWithPrefix:@"RobotWalk" suffix:@".png"];
	
	// The robot
	
	AnimationClip *robot = [[AnimationClip alloc] initWithFrames:animationFrames];
	
	robot.anchorX = 0.5f;
	robot.anchorY = 1.0f;
	
	robot.x = self.stage.stageWidth * 0.5f;
	robot.y = self.stage.stageHeight * 0.5f;
	
	robot.frameRate = 24;
	
	[self addChild:robot];
	
	// Robot's reflection
	
	AnimationClip *robotShadow = [[AnimationClip alloc] initWithFrames:animationFrames];
	
	robotShadow.anchorX = 0.5f;
	robotShadow.anchorY = 1.0f;
	
	robotShadow.x = self.stage.stageWidth * 0.5f;
	robotShadow.y = self.stage.stageHeight * 0.5f;
	
	robotShadow.frameRate = 24;
	
	// Reflect it
	robotShadow.scaleY = -1.0f;
	robotShadow.alpha = 0.5f;
	
	[self addChild:robotShadow];
}

- (void) dealloc
{
	// Cleaning up: Release retained objects, remove event listeners, etc.

	[super dealloc];
}

- (BOOL)deviceIsIPad
{
	UIDevice *device = [UIDevice currentDevice];
	
	// Device type check only supported in 3.2 and higher (first version of iPad)
	if ([device respondsToSelector:@selector(userInterfaceIdiom)])
	{
		if (device.userInterfaceIdiom == UIUserInterfaceIdiomPad)
		{
			return YES;
		}
	}
	
	return NO;
}

@end
