//
//  ViewController.m
//  Kitana
//
//  Created by Bruno Baring on 3/6/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "BCN_FindBeacon.h"
#import "User.h"

@interface BCN_FindBeacon ()

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) NSMutableArray *BeaconsFound;

@end

@implementation BCN_FindBeacon
int pbeaconsFoundCount = 0;

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    
}



//E2C56DB5-DFFB-48D2-B060-D0F5A71096E0
//f7826da6-4fa2-4e98-8024-bc5b71e0893e

+ (instancetype)initRegion {
    BCN_FindBeacon *regiao = [[BCN_FindBeacon alloc] init];

    return regiao;
}

- (void)startMonitoringPlease {
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid  identifier:@"Retail21"];
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
    
    pbeaconsFoundCount = 0;
    self.user = [[User alloc]init];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Found");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

-(void)abc{
    NSArray *aaa = [[NSArray alloc]init];
    NSLog(@"vou chamar hein!!!!!");
    [self locationManager:self.locationManager didRangeBeacons:aaa inRegion:self.beaconRegion];
    NSLog(@"ja chamei");
}


-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    
    if(beacons.count > 0){
        
                NSLog(@"%@",beacons);
        self.BeaconsFound = [NSMutableArray arrayWithArray:beacons];
        
        CLBeacon *beacon = [[CLBeacon alloc] init];
        beacon = [beacons lastObject]; /// ATENCAO: COM O LASTOBJECT, SÓ É DETECTADO 1(O ÚLTIMO) BEACON NOVO.
        
        if (beacon.proximity == CLProximityUnknown) {
        } else if (beacon.proximity == CLProximityImmediate) {
        } else if (beacon.proximity == CLProximityNear) {
        } else if (beacon.proximity == CLProximityFar) {
        }
        
        //verificar se esse SORT está funcionando
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"major" ascending:YES];
        [self.BeaconsFound sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        
        
        
        if (pbeaconsFoundCount != (int)beacons.count) {
            if ([beacon.major intValue] < 20 && [beacon.minor intValue] < 20) {
                self.user.major = [beacon.major intValue];
                self.user.minor = [beacon.minor intValue];
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"notificationName"
                 object:self.user];
            }
            
        }
        pbeaconsFoundCount = (int)beacons.count;
        
    }else{
        NSLog(@"array beacons vazio");
    }
}

-(void)refreshBeaconsFound:(NSArray *)CurrentBeacons {
    
    //    CLBeacon *aux = [[CLBeacon alloc] init];
    //
    //    for (int i = 0; i < self.myMutArray.count; i++) {
    //        //        NSLog(@"sss");
    //
    //        aux = [self.myMutArray objectAtIndex:i];
    //        NSLog(@"%@ ===== AQUIIII",aux);
    //        NSMutableArray *arrayStudents = [NSMutableArray arrayWithArray:[students objectForKey:@"Não-Presentes"]];
    //
    //        if ([aux.major intValue] == 0 && [aux.minor intValue]== 0 && aux.accuracy>0 && [arrayStudents containsObject:@"Julia Baiteli"]){
    //            //            NSString *sectionTitle = [studentSectionTitles objectAtIndex:indexPath.section];
    //            [arrayStudents removeObjectIdenticalTo:@"Julia Baiteli"];
    //            [students setObject:arrayStudents forKey:@"Não-Presentes"];
    //            arrayStudents = [NSMutableArray arrayWithArray:[students objectForKey:@"Aguardando Confirmação"]];
    //            [arrayStudents addObject:@"Julia Baiteli"];
    //            [students setObject:arrayStudents forKey:@"Aguardando Confirmação"];
    //
    //        }
    //
    //        if ([aux.major intValue] == 6 && [aux.minor intValue]== 6 && aux.accuracy>0 && [arrayStudents containsObject:@"Joao Brandao"]){
    //            //            NSString *sectionTitle = [studentSectionTitles objectAtIndex:indexPath.section];
    //            [arrayStudents removeObjectIdenticalTo:@"Joao Brandao"];
    //            [students setObject:arrayStudents forKey:@"Não-Presentes"];
    //            arrayStudents = [NSMutableArray arrayWithArray:[students objectForKey:@"Aguardando Confirmação"]];
    //            [arrayStudents addObject:@"Joao Brandao"];
    //            [students setObject:arrayStudents forKey:@"Aguardando Confirmação"];
    //
    //        }
    //    }
}




@end
