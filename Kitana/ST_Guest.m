//
//  Guest.m
//  Kitana
//
//  Created by Bruno Baring on 3/10/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "ST_Guest.h"
#import "BCN_BeBeacon.h"

@interface ST_Guest ()

@property (nonatomic) NSMutableArray *myMutArray;
@property BCN_BeBeacon *bcn;

@end

@implementation ST_Guest



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.bcn = [BCN_BeBeacon initBeaconWithMajor:5 minor:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


/********************* TABLE VIEW **************************/

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    CLBeacon *aux = [[CLBeacon alloc] init];
    aux = [self.myMutArray firstObject];
    if ([aux.major intValue] == 4) {
        return 1;
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MateriasAluno" forIndexPath:indexPath];
    
    CLBeacon *aux = [[CLBeacon alloc] init];
    aux = [self.myMutArray objectAtIndex:indexPath.row];
    
    if ([aux.major intValue] == 4 && [aux.minor intValue] == 4){
        NSLog(@"%@ - %@",aux.major, self.myMutArray);
        
        
        
        if(aux.accuracy > 0) {
            cell.textLabel.text = @"Calculo IV";
            cell.detailTextLabel.text = @"Chamada liberada";
        }else{
            cell.textLabel.text = @"Calculo IV";
            cell.detailTextLabel.text = @"Chamada liberada -1";
        }
        
    }
    
    
    //    cell.textLabel.text = aux.proximityUUID.UUIDString;
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"Minor: %@, Major: %@, RSSI: %ld, Proximity: %ld, Accuracy: %f",[aux.minor stringValue],[aux.major stringValue], (long)aux.rssi, aux.proximity, aux.accuracy];
    //    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //    cell.detailTextLabel.numberOfLines = 3;
    //    cell.detailTextLabel.text = self.detalhes[indexPath.row];
    //    cell.imageView.image = self.imagens[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MateriasAluno" forIndexPath:indexPath];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    if(indexPath.row == 0 && indexPath.section == 0 && [cell.textLabel.text isEqualToString:@"Calculo IV"]){
        
        NSLog(@"respondido!");
        self.bcn = [BCN_BeBeacon initBeaconWithMajor:5 minor:5];
        [self.bcn startRangingPlease];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        NSLog(@"Saiu do navigation Controller");
        [self.bcn stopRangingPlease];
    }
}

/********************* FIND BEACONS **************************/
//
//
//- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
//    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
//}
//
////E2C56DB5-DFFB-48D2-B060-D0F5A71096E0
////f7826da6-4fa2-4e98-8024-bc5b71e0893e
//
//- (void)initRegion {
//    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
//    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid  identifier:@"Retail21"];
//    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
//    [self.locationManager startMonitoringForRegion:self.beaconRegion];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
//    NSLog(@"Beacon Found");
//    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
//    NSLog(@"2");
//    NSLog(@"Left Region");
//    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
//    self.beaconFoundLabel.text = @"No";
//}
//
//-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
//
//    //        NSLog(@"%@",beacons);
//    self.myMutArray = [NSMutableArray arrayWithArray:beacons];
//
//    CLBeacon *beacon = [[CLBeacon alloc] init];
//    beacon = [beacons firstObject];
//
//    self.beaconFoundLabel.text = @"Yes";
//
//
//    //    NSLog(@"%@",beacons[0]);
//    //        NSLog(@"asdasda %lu",(unsigned long)self.myMutArray.count);
//
//    self.proximityUUIDLabel.text = [NSString stringWithFormat:@"%@", beacon.proximityUUID.UUIDString];
//    self.majorLabel.text = [NSString stringWithFormat:@"%@", beacon.major];
//    self.minorLabel.text = [NSString stringWithFormat:@"%@", beacon.minor];
//    self.accuracyLabel.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
//
//
//
//    if (beacon.proximity == CLProximityUnknown) {
//        self.distanceLabel.text = @"Unknown Proximity";
//
//    } else if (beacon.proximity == CLProximityImmediate) {
//        //        self.propaganda.image = [UIImage imageNamed:@"frango_bovino.jpg"];
//
//        self.distanceLabel.text = @"Immediate";
//
//    } else if (beacon.proximity == CLProximityNear) {
//        self.distanceLabel.text = @"Near";
//
//
//    } else if (beacon.proximity == CLProximityFar) {
//        self.distanceLabel.text = @"Far";
//    }
//    self.rssiLabel.text = [NSString stringWithFormat:@"%li", (long)beacon.rssi];
//
//
//    if(beacons.count > 0){
//        for ( int i = 0 ; i < beacons.count ; i++ ){
//            beacon = beacons[i];
//            //            NSLog(@"%@ - %@ - Count: %lu",beacon, self.distanceLabel.text, (unsigned long)beacons.count);
//        }
//
//        //verificar se esse SORT está funcionando
//        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"major" ascending:YES];
//        [self.myMutArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
//
//        [self.tableView reloadData];
//    }
//}

/********************* TAB BUTTON **************************/



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
