//
//  Answer.h
//  Kitana
//
//  Created by Bruno Baring on 3/10/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BCN_BeBeacon : NSObject <CBPeripheralDelegate>

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

+ (instancetype)initBeaconWithMajor:(int)major minor:(int) minor;
- (void)startRangingPlease;
- (void)stopRangingPlease;

@end
