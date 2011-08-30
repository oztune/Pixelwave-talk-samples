//
//  TheBasicsAppDelegate.h
//  TheBasics
//
//  Created by Oz Michaeli on 8/30/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pixelwave.h"

@interface TheBasicsAppDelegate : NSObject <UIApplicationDelegate>
{
@private
    UIWindow *window;
	PXView *pixelView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
