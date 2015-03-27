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

//#import "TC_Guest_List_Cell.h"

@interface TC_Guest_List () {
    NSMutableDictionary *students;
    NSArray *studentSectionTitles;
    NSArray *studentIndexTitles;
    CLBeacon *pBcn;
}

@property (nonatomic) NSMutableArray *StudentsBeaconFound;
@property BCN_BeBeacon *bcn;
@property BCN_FindBeacon *findBeacon;
@end

@implementation TC_Guest_List

int a=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.teacher.studentsFromClass = [Database getStudentsFromClassOfTeacherWithTeacherMajor:self.teacher.major TeacherMinor:self.teacher.minor ClassName:self.className Detail:self.classDetail];

    self.teacher.
    
    NSDictionary *AUXstudents = @{@"" : @[@""],
                                  @"Aguardando Confirmação" : @[],
                                  @"Não-Presentes" : @[],//self.teacher.studentsFromClass,
                                  @"Presentes" : @[]};
    
    
    students = [NSMutableDictionary dictionaryWithDictionary:AUXstudents];
    
    studentSectionTitles = [[students allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.bcn = [BCN_BeBeacon initBeaconWithMajor:4 minor:4];
    self.findBeacon = [BCN_FindBeacon initRegion];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableInfo:) name:@"notificationName" object:nil];
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
    return [studentSectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionTitle = [studentSectionTitles objectAtIndex:section];
    NSArray *sectionstudents = [students objectForKey:sectionTitle];
    return [sectionstudents count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [studentSectionTitles objectAtIndex:section];
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
        
        NSString *sectionTitle = [studentSectionTitles objectAtIndex:indexPath.section];
        NSArray *sectionstudents = [students objectForKey:sectionTitle];
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
    return [studentSectionTitles indexOfObject:title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
//    NSString *sectionTitle = [studentSectionTitles objectAtIndex:indexPath.section];
    
    if(indexPath.row == 0 && indexPath.section == 0){
        [self.bcn startRangingPlease];
        [self.findBeacon startMonitoringPlease];
        [NSTimer scheduledTimerWithTimeInterval:0.5
                                         target:self
                                       selector:@selector(joe)
                                       userInfo:nil
                                        repeats:YES];
    }
    
}

-(void)joe{
    [self.findBeacon abc];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        NSLog(@"Saiu do navigation Controller");
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
