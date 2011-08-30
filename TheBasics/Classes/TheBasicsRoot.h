//
//  TheBasicsRoot.h
//  TheBasics
//
//  Created by Oz Michaeli on 8/30/11.
//  Copyright NA 2011. All rights reserved.
//

#import "Pixelwave.h"

@interface TheBasicsRoot : PXSprite
{
@private
	PXTexture *raccoon;
	float targetX, targetY;
}

- (void) initializeAsRoot;

@end
