//
//  Answer.m
//  Kitana
//
//  Created by Bruno Baring on 3/10/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "BCN_BeBeacon.h"

@interface BCN_BeBeacon ()

@end

@implementation BCN_BeBeacon

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self initBeacon];
//    // Do any additional setup after loading the view.
//}

+ (instancetype)initBeaconWithMajor:(int)major minor:(int) minor {
   
    BCN_BeBeacon *bcn = [[BCN_BeBeacon alloc] init];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    bcn.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:major
                                                                minor:minor
                                                           identifier:@"com.devfright.myRegion"];
    return bcn;
}

- (void)startRangingPlease {
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
    }
}

-(void)stopRangingPlease {
    NSLog(@"stopRangingPlease");
    [self.peripheralManager stopAdvertising];
}


@end
