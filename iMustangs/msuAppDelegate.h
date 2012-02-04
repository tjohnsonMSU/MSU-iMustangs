//
//  msuAppDelegate.h
//  iMustangs
//
//  Created by Eric Binnion on 2/3/12.
//  Copyright (c) 2012 Midwestern State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mapViewController;

@interface msuAppDelegate : NSObject <UIApplicationDelegate>{
    UIWindow *window;
    mapViewController *viewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) mapViewController *viewController;

@end
