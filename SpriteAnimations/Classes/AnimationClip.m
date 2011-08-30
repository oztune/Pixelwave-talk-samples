//
//  AnimationClip.m
//  SpriteAnimations
//
//  Created by Oz Michaeli on 8/29/11.
//  Copyright 2011 Spiralstorm Games. All rights reserved.
//

#import "AnimationClip.h"

@implementation AnimationClip

@synthesize frameRate;
@synthesize frames;
@synthesize isPlaying;

- (id) init
{
	return [self initWithFrames:nil];
}

- (id) initWithFrames:(NSArray *)_frames
{
	self = [super init];
	if (self)
	{
		currentFrame = -1;
		
		self.frames = _frames;
		self.frameRate = [PXStage mainStage].frameRate;
		
		[self play];
	}
	
	return self;
}

- (void) dealloc
{
	self.frames = nil;
	
	[super dealloc];
}

- (void) play
{
	if (isPlaying) return;
	
	isPlaying = YES;
	
	startTime = PXGetTimerSec();
	
	[self addEventListenerOfType:PXEvent_EnterFrame listener:PXListener(onEnterFrame:)];
}
- (void) stop
{
	if (!isPlaying) return;
	
	isPlaying = NO;
	
	[self removeEventListenerOfType:PXEvent_EnterFrame listener:PXListener(onEnterFrame:)];
}
	 
- (void) onEnterFrame:(PXEvent *)event
{
	int framesCount = [frames count];
	float duration = framesCount / frameRate;
		
	float time = fmodf(PXGetTimerSec() - startTime, duration);
	float t = time / duration;
	
	int targetFrame = roundf(t * framesCount);
	
	if (targetFrame == currentFrame) return;
	
	// Update the texture to display the frame
	
	currentFrame = targetFrame;
	PXAtlasFrame *frame = [frames objectAtIndex:currentFrame];
	
	[frame setToTexture:self];
}

@end
