//
//  AppDelegate_iPhone.h
//  SpriteAnimations
//
//  Created by Oz Michaeli on 8/29/11.
//  Copyright 2011 Spiralstorm Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pixelwave.h"

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate>
{
@private
    UIWindow *window;
	PXView *pixelView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
