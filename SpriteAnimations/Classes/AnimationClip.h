//
//  AnimationClip.h
//  SpriteAnimations
//
//  Created by Oz Michaeli on 8/29/11.
//  Copyright 2011 Spiralstorm Games. All rights reserved.
//

#import "Pixelwave.h"

@interface AnimationClip : PXTexture {
@private
	float frameRate;
	NSArray *frames;
	
	float currentTime;
	int currentFrame;
	
	BOOL isPlaying;
}

@property (nonatomic, assign) float frameRate;
@property (nonatomic, retain) NSArray *frames;
@property (nonatomic, readonly) BOOL isPlaying;

- (id) initWithFrames:(NSArray *)frames;

- (void) play;
- (void) stop;

@end
