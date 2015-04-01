//
//  Guest.m
//  Kitana
//
//  Created by Bruno Baring on 3/10/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "ST_Guest.h"
#import "BCN_BeBeacon.h"
#import "BCN_FindBeacon.h"
#import "Discipline.h"
#import "Database.h"

@interface ST_Guest (){
    NSMutableDictionary *infoToRow;
    NSArray *SectionTitles;
    NSArray *IndexTitles;
    CLBeacon *pBcn;
    NSMutableArray *newDisciplines;
}

@property (nonatomic) NSMutableArray *myMutArray;
@property BCN_BeBeacon *be_beacon;
@property BCN_FindBeacon *find_beacon;
@property NSMutableArray *classesToRows;
@property NSTimer *st_timer;
@end

@implementation ST_Guest



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *AUXstudents = @{@"Cadastradas" : self.student.classes,
                                  @"Não-Cadastradas" : @[@""]};
    
    infoToRow = [NSMutableDictionary dictionaryWithDictionary:AUXstudents];
    
    SectionTitles = [[infoToRow allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    SectionTitles = @[@"Cadastradas",@"Nao-Cadastradas"];
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.be_beacon = [BCN_BeBeacon initBeaconWithMajor:self.student.major minor:self.student.minor];
    
    self.find_beacon = [BCN_FindBeacon initRegion];
    [self.find_beacon startMonitoringPlease];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableInfo:) name:@"notificationName" object:nil];
    
    self.st_timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(abc)
                                   userInfo:nil
                                    repeats:YES];
}

-(void) abc{
    [self.be_beacon startRangingPlease];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/********************* TABLE VIEW **************************/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return self.student.classes.count;
    }else{
        return newDisciplines.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [SectionTitles objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MateriasAluno" forIndexPath:indexPath];
    
    NSString *sectionTitle = [SectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionstudents = [infoToRow objectForKey:sectionTitle];
    Discipline *aaa = [sectionstudents objectAtIndex:indexPath.row];
    cell.textLabel.text = aaa.name;
    cell.detailTextLabel.text = aaa.details;
    
    
    if (!aaa.answer) {
        [cell setBackgroundColor:[UIColor redColor]];
    }else{
        [cell setBackgroundColor:[UIColor greenColor]];
    }
    //    [cell setBackgroundColor:[UIColor yellowColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MateriasAluno" forIndexPath:indexPath];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    
    if(indexPath.row == 0 && indexPath.section == 0 && [cell.textLabel.text isEqualToString:@"Calculo IV"]){
        
        NSLog(@"respondido!");
        self.be_beacon = [BCN_BeBeacon initBeaconWithMajor:self.student.major minor:self.student.minor];
        [self.be_beacon startRangingPlease];
    }
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

}

- (void)reloadTableInfo:(NSNotification *)notification{
    
    
    //    NSLog(@"beac %d",[beac.major intValue]);
    
//    NSLog(@"%@",self.find_beacon.BeaconsFound);

    for (int k = 0 ; k < self.find_beacon.BeaconsFound.count; k++) {
        CLBeacon *beac = [self.find_beacon.BeaconsFound objectAtIndex:k];
        for (int j = 0 ; j < self.student.classes.count; j++){
            Discipline *aaa = [self.student.classes objectAtIndex:j];
            for (int i = 0 ; i < aaa.teachers.count; i++) {
                TC_Teacher *bbb = [aaa.teachers objectAtIndex:i];
                if ([beac.major intValue] == bbb.major) {
                    aaa.answer = true;
                    NSLog(@"#######################################################################################################################################################################################");
                }
            }
        }
    }
    
    //pegar o major e minor recebido,ver quem é o professor, ver a hora da matéria, e ver qual matéria corresponde a tal hora
    //falta pegar a matéria pelo id tb
    
    [self.tableView reloadData];
}

- (IBAction)Back:(id)sender {
    [self.be_beacon stopRangingPlease];
    [self.st_timer invalidate];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        NSLog(@"Saiu do navigation Controller");
        [self.be_beacon stopRangingPlease];
        [self.st_timer invalidate];
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
