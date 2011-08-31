//
//  AppDelegate_iPhone.h
//  CustomGlyphs
//
//  Created by Oz Michaeli on 8/31/11.
//  Copyright 2011 NA. All rights reserved.
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
