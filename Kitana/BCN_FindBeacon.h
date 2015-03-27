//
//  ViewController.h
//  Kitana
//
//  Created by Bruno Baring on 3/6/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "User.h"

@interface BCN_FindBeacon : NSObject <CLLocationManagerDelegate>

+ (instancetype)initRegion;
- (void)startMonitoringPlease;
- (void)abc;

@property User *user;

@end

