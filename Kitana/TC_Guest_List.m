//
//  TC_Guest_List.m
//  Kitana
//
//  Created by Bruno Baring on 3/11/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "TC_Guest_List.h"
#import "BCN_BeBeacon.h"
#import "BCN_FindBeacon.h"
#import "User.h"
#import "Database.h"
#import "TC_Teacher.h"
#import "ST_Student.h"
#import "Discipline.h"

//#import "TC_Guest_List_Cell.h"

@interface TC_Guest_List () {
    NSMutableDictionary *infoToRow;
    NSArray *SectionTitles;
    NSArray *IndexTitles;
    CLBeacon *pBcn;
}

@property (nonatomic) NSMutableArray *StudentsBeaconFound;
@property BCN_BeBeacon *bcn;
@property BCN_FindBeacon *findBeacon;
@property NSMutableArray *studentsToRows;
@end

@implementation TC_Guest_List

int a=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.studentsToRows = [[NSMutableArray alloc]init];
    self.studentsToRows = [self getStudentToRowsFromClassName:self.className ClassDetail:self.classDetail];
    
    NSDictionary *AUXstudents = @{@"" : @[@""],
                                  @"Aguardando Confirmação" : @[],
                                  @"Não-Presentes" : self.studentsToRows,
                                  @"Presentes" : @[]};
    
    infoToRow = [NSMutableDictionary dictionaryWithDictionary:AUXstudents];
    
    SectionTitles = [[infoToRow allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    self.bcn = [BCN_BeBeacon initBeaconWithMajor:4 minor:4];
    self.findBeacon = [BCN_FindBeacon initRegion];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableInfo:) name:@"notificationName" object:nil];
}

- (NSMutableArray *)getStudentToRowsFromClassName:(NSString *)class_name ClassDetail:(NSString *)class_detail{
    NSMutableArray *eee = [[NSMutableArray alloc] init];
    NSMutableArray *aaa = self.teacher.classes;
    for (int i  = 0 ; i < aaa.count; i++) {
        Discipline *bbb = [aaa objectAtIndex:i];
        if ([bbb.name isEqualToString:class_name] && [bbb.details isEqualToString:class_detail]) {
            NSMutableArray *ccc = bbb.students;
            for ( int i = 0 ; i < bbb.students.count ; i++ ) {
                ST_Student *ddd = [ccc objectAtIndex:i];
                [eee addObject:ddd.name];
            }
            i = aaa.count;
        }
    }
    
    return eee;
}



- (void)reloadTableInfo:(NSNotification *)notification{
    //    self.userStudentAnswer = [notification object];
    //    NSString *nameStudentAnswer = [NSString stringWithString:[Database getStudentWithMajor:self.userStudentAnswer.major Minor:self.userStudentAnswer.minor]];
    //    NSLog(@"%@",nameStudentAnswer);
    //    NSLog(@"%d",self.userStudentAnswer.major);
    //    [Database moveUserBetweenSectionsWithDictionary:students userName:nameStudentAnswer from:@"Não-Presentes" to:@"Aguardando Confirmação"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [SectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionTitle = [SectionTitles objectAtIndex:section];
    NSArray *sectionstudents = [infoToRow objectForKey:sectionTitle];
//    NSLog(@"%ld",(long)section);
    return [sectionstudents count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [SectionTitles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0 && indexPath.section == 0){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"status" forIndexPath:indexPath];
        cell.textLabel.text = @"tap to chamada";
        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.detailTextLabel.numberOfLines = 3;
        return cell;
        
    }else{
        
        static NSString *Identifier = @"jbh";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
        
        NSString *sectionTitle = [SectionTitles objectAtIndex:indexPath.section];
        NSArray *sectionstudents = [infoToRow objectForKey:sectionTitle];
        NSString *student = [sectionstudents objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textAlignment = NSTextAlignmentNatural;
        cell.textLabel.text = student;
        
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.frame = CGRectMake(cell.bounds.size.width-54,5,49,60);
        //        iconImage.image = [UIImage imageNamed:[student stringByAppendingString:@".jpg"]];
        [cell.contentView addSubview:iconImage];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [SectionTitles indexOfObject:title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    if(indexPath.row == 0 && indexPath.section == 0){
        [self.bcn startRangingPlease];
        [self.findBeacon startMonitoringPlease];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
//        NSLog(@"Saiu do navigation Controller");
        [self.bcn stopRangingPlease];
    }
}


//******************************* FUNCOES INTERESSANTES ***************************************

// adiciona o indice azul do lado direito da tabela, com as letrinhas pequenas
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//  //  return studentSectionTitles;
//    return studentIndexTitles;
//}


//- (NSString *)getImageFilename:(NSString *)student
//{
//    NSString *imageFilename = [[student lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
//    imageFilename = [imageFilename stringByAppendingString:@".jpg"];
//
//    return imageFilename;
//}

//******************************* FUNCOES PADROES **********************************


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
