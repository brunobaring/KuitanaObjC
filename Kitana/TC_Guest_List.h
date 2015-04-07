//
//  TC_Guest_List.h
//  Kitana
//
//  Created by Bruno Baring on 3/11/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "User.h"
#import "TC_Teacher.h"


@interface TC_Guest_List : UIViewController <UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

//@property (weak, nonatomic) IBOutlet UILabel *beaconFoundLabel;
//@property (weak, nonatomic) IBOutlet UILabel *proximityUUIDLabel;
//@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
//@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
//@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
//@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
//@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property int major;
@property int minor;
@property NSString *className;
@property NSString *classDetail;

@property TC_Teacher *teacher;
@property User *userStudentAnswer;

//@property (nonatomic, copy, readonly) NSArray *uuid_disponiveis;

-(void) abc;

@end
