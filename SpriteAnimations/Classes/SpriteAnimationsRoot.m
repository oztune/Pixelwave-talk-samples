//
//  SpriteAnimationsRoot.m
//  SpriteAnimations
//
//  Created by Oz Michaeli on 8/29/11.
//  Copyright Spiralstorm Games 2011. All rights reserved.
//

#import "SpriteAnimationsRoot.h"

#import "AnimationClip.h"

@interface PXTextureAtlas (Utils)
- (NSArray *)framesWithNames:(NSArray *)names;
- (NSArray *)framesWithPattern:(PXRegexPattern *)pattern;
- (NSArray *)sequentialFramesWithPrefix:(NSString *)prefix suffix:(NSString *)suffix;
- (NSArray *)sequentialFramesWithPrefix:(NSString *)prefix suffix:(NSString *)suffix inRange:(NSRange)range;
// TODO: Add a [sequentialFramesWithPattern:range:] which will sort the list with all the groups in the pattern.
@end

NSInteger pxAtlasFrameSorter(NSDictionary *frameA, NSDictionary *frameB, void *context)
{
	int indexA = [((NSNumber *)[frameA objectForKey:@"index"]) intValue];
	int indexB = [((NSNumber *)[frameB objectForKey:@"index"]) intValue];
	
	if (indexA > indexB) return 1;
	if (indexA < indexB) return -1;
	return 0;
}

@implementation PXTextureAtlas (Utils)

/**
 * Returns the frames with the given names. If a frame
 * doesn't exist for any of the given names, those names
 * are simply ignored.
 *
 * @param names
 */
- (NSArray *)framesWithNames:(NSArray *)names
{
	if (!names) return nil;
	
	NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[names count]];
	
	PXAtlasFrame *frame;
	
	for (NSString *name in names)
	{
		frame = [self frameWithName:name];
		if (!frame) continue;
		
		[array addObject:frame];
	}
	
	return [array autorelease];
}

- (NSArray *)framesWithPattern:(PXRegexPattern *)pattern
{
	PXRegexMatcher *matcher = [[PXRegexMatcher alloc] initWithPattern:pattern];
	BOOL matched;
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	PXAtlasFrame *frame;
	
	for (NSString *frameName in frames)
	{
		matcher.input = frameName;
		matched = [matcher next];
		
		if (matched == NO) continue;
		
		frame = [self frameWithName:frameName];
		
		// Just to be extra cautious:
		if (frame == nil) continue;
		
		[array addObject:frame];
	}
	
	return [array autorelease];
}

- (NSArray *)sequentialFramesWithPrefix:(NSString *)prefix suffix:(NSString *)suffix
{
	return [self sequentialFramesWithPrefix:prefix suffix:suffix inRange:NSMakeRange(NSNotFound, 0)];
}
- (NSArray *)sequentialFramesWithPrefix:(NSString *)prefix suffix:(NSString *)suffix inRange:(NSRange)inRange
{
	BOOL checkRange = (inRange.location != NSNotFound);
	
	NSString *frameName;
	PXAtlasFrame *frame;
	
	NSRange range;
	
	int numberStartIndex, numberEndIndex;
	int frameNameLength;
	
	NSString *numberString;
	int frameIndex;
	
	// For keeping the results
	NSDictionary *dictionary;
	NSNumber *frameIndexNumber;
	NSMutableArray *arrayOfDicts = [[NSMutableArray alloc] init];
	
	for (frameName in frames)
	{
		// Find the location of the index string, if any.
		if (prefix)
		{
			range = [frameName rangeOfString:prefix options:(NSCaseInsensitiveSearch)];
			if (range.location == NSNotFound) continue;
			if (range.location != 0) continue;
			
			numberStartIndex = range.location + range.length;
		}
		else
		{
			numberStartIndex = 0;
		}
		
		frameNameLength = [frameName length];
		
		if (suffix)
		{
			range = [frameName rangeOfString:suffix options:(NSCaseInsensitiveSearch | NSBackwardsSearch)];
			if (range.location == NSNotFound) continue;
			if (range.location + range.length != frameNameLength) continue;
			
			numberEndIndex = range.location;
		}
		else
		{
			numberEndIndex = frameNameLength;
		}
		
		// Get the index string given its location
		
		range.location = numberStartIndex;
		range.length = numberEndIndex - numberStartIndex;
		numberString = [frameName substringWithRange:range];
		
		// Convert the string to a number we can use
		
		frameIndex = [numberString intValue];
		
		if (frameIndex == 0 && ([numberString isEqualToString:@"0"] == NO || [numberString isEqualToString:@"-0"] == NO))
		{
			// Invalid number
			continue;
		}
		
		// Check if the index is in range (inclusive)
		if (checkRange && (frameIndex < inRange.location || frameIndex  > (inRange.location + inRange.length)))
		{
			continue;
		}
		
		frame = [self frameWithName:frameName];
		
		if (!frame) continue;
		
		// Found the frame. We wrap the frame inside a dictionary, along with its index.
		// Then we add it to a list, which will be sorter at the end.
		
		frameIndexNumber = [[NSNumber alloc] initWithInt:frameIndex];
		dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:frame, @"frame", frameIndexNumber, @"index", nil];
		
		[arrayOfDicts addObject:dictionary];
		
		[frameIndexNumber release];
		[dictionary release];
	}
	
	// Sort the frame wrappers.
	[arrayOfDicts sortUsingFunction:pxAtlasFrameSorter context:nil];
	
	// Extract all the frames out of the sorted array of dictionaries
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (dictionary in arrayOfDicts)
	{
		//NSLog(@"%@", [dictionary objectForKey:@"index"]);
		[array addObject:[dictionary objectForKey:@"frame"]];
	}
	
	[arrayOfDicts release];
	
	return [array autorelease];
}

@end

@implementation SpriteAnimationsRoot

- (void) initializeAsRoot
{
	self.stage.backgroundColor = 0xA5D5E9;
	
	// TODO: Add iPad check
	
	PXTextureAtlas *robotWalkAtlas = [PXTextureAtlas textureAtlasWithContentsOfFile:@"RobotWalk.json" modifier:nil];
	
	NSArray *animationFrames = [robotWalkAtlas sequentialFramesWithPrefix:@"RobotWalk" suffix:@".png"];
	
	AnimationClip *robot = [[AnimationClip alloc] initWithFrames:animationFrames];
	
	robot.anchorX = 0.5f;
	robot.anchorY = 0.5f;
	
	robot.x = self.stage.stageWidth * 0.5f;
	robot.y = self.stage.stageHeight * 0.5f;
	
	robot.frameRate = 24;
	
	[self addChild:robot];
}

- (void) dealloc
{
	// Cleaning up: Release retained objects, remove event listeners, etc.

	[super dealloc];
}

@end
