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
@property BCN_BeBeacon *be_beacon;
@property BCN_FindBeacon *find_beacon;
@property NSMutableArray *studentsNotPresent;
@property NSMutableArray *studentsPending;
@property NSMutableArray *studentsPresent;
@property NSMutableArray *beaconsPossiblyNewStudents;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *tap_call;
@property BOOL *isCallOn;
@end

@implementation TC_Guest_List

int a=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.studentsPresent = [[NSMutableArray alloc]init];
    self.studentsPending = [[NSMutableArray alloc]init];
    self.studentsNotPresent = [[NSMutableArray alloc]init];
    self.beaconsPossiblyNewStudents = [[NSMutableArray alloc]init];
    self.studentsNotPresent = [self getStudentsNotPresentFromClassName:self.disc.name ClassDetail:self.disc.details];
    
    NSDictionary *AUXstudents = @{@"Aguardando Confirmação" : self.studentsPending,
                                  @"Não-Presentes" : self.studentsNotPresent,
                                  @"Presentes" : self.studentsPresent};
    
    infoToRow = [NSMutableDictionary dictionaryWithDictionary:AUXstudents];
    
    SectionTitles = [[infoToRow allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.be_beacon = [BCN_BeBeacon initBeaconWithMajor:self.teacher.major minor:self.teacher.minor];
    self.find_beacon = [BCN_FindBeacon initRegion];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableInfo:) name:@"notificationName" object:nil];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:252/255.0f green:148/255.0f blue:58/255.0f alpha:255/255.0f] CGColor],
                       (id)[[UIColor colorWithRed:254/255.0f green:219/255.0f blue:84/255.0f alpha:255/255.0f] CGColor],
                       nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //    self.tableView.backgroundColor = [UIColor colorWithRed:252/255.0f green:148/255.0f blue:58/255.0f alpha:255.0/255.0f];
    
    [self.tap_call setImage:[UIImage imageNamed:@"pressbuttonin.png"] forState:UIControlStateHighlighted];
    self.isCallOn = false;
    
}

- (void)reloadTableInfo:(NSNotification *)notification{
    
    NSLog(@"%@",self.beaconsPossiblyNewStudents);
    
    for (int i = 0 ; i < self.find_beacon.BeaconsFound.count; i++)
    {  //percorre os beacons achados pelo find_beacon
        CLBeacon *beacon = [self.find_beacon.BeaconsFound objectAtIndex:i];  //cria um beacon com o beacon da posicao i no vetor de beacons achados
        
        int k ;
        
        for ( k = 0 ; k < self.disc.students.count; k++) //percorre os estudantes da disciplina criada q é igual a disciplina da posicao j no vetor de aulas do professor
        {
            ST_Student * stud = [self.disc.students objectAtIndex:k];  //cria um aluno na posicao k da aula criada
            if (stud.major == [beacon.major intValue] && stud.minor == [beacon.minor intValue])
            {
                
                if ( ![self.studentsPending containsObject:stud.name] && ![self.studentsPresent containsObject:stud.name]) //se aluno nao estiver já marcado como presente nem como aguardando confirmacao,
                {
                    [self.studentsNotPresent removeObject:stud.name]; //remove o aluno do nao presente
                    [self.studentsPending addObject:stud.name]; // e adiciona ao vetor de aguardando confirmaçao
                }
                break ;
            }
        }
        
        if ( k == self.disc.students.count )
        {
            if (self.beaconsPossiblyNewStudents.count == 0)
            {
                [self.beaconsPossiblyNewStudents addObject:beacon];
            }
            else
            {
                int l;
                for (l = 0; l < self.beaconsPossiblyNewStudents.count; l++)
                {
                    CLBeacon *beacon2 = [self.beaconsPossiblyNewStudents objectAtIndex:l];
                    if ([beacon2.major intValue] == [beacon.major intValue] && [beacon2.minor intValue] == [beacon.minor intValue])
                    {
                        break;
                    }
                }
                
                if ( l == self.beaconsPossiblyNewStudents.count )
                {
                    [self.beaconsPossiblyNewStudents addObject:beacon];
                }
            }
        }
    }
    
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
    return [sectionstudents count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [SectionTitles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier = @"jbh";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    NSString *sectionTitle = [SectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionstudents = [infoToRow objectForKey:sectionTitle];
    NSString *student = [sectionstudents objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textAlignment = NSTextAlignmentNatural;
    cell.textLabel.text = student;
    
    if (indexPath.section == 0) {
        [cell setBackgroundColor:[UIColor colorWithRed:254/255.0f green:219/255.0f blue:84/255.0f alpha:255.0/255.0f]];
    }
    if (indexPath.section == 1) {
        [cell setBackgroundColor:[UIColor colorWithRed:202/255.0f green:104/255.0f blue:87/255.0f alpha:255.0/255.0f]];
    }
    if (indexPath.section == 2) {
        [cell setBackgroundColor:[UIColor colorWithRed:64/255.0f green:190/255.0f blue:81/255.0f alpha:255.0/255.0f]];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [SectionTitles indexOfObject:title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    NSString *aa = [self.studentsPending objectAtIndex:indexPath.row];
    [self.studentsPending removeObject:aa];
    [self.studentsPresent addObject:aa];
    [self.tableView reloadData];
    
    
}

- (IBAction)tapCallButton:(id)sender {
    if (!self.isCallOn) {
        [self.be_beacon startRangingPlease];
        [self.find_beacon startMonitoringPlease];
        [self.tap_call setImage:[UIImage imageNamed:@"presençaok.png"] forState:UIControlStateNormal];
        self.isCallOn = true;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(abc)
                                                    userInfo:nil
                                                     repeats:YES];
        NSLog(@"Tap! Started Ranging and Monitoring. Roll Call is ON!");
    }else{
        [self.be_beacon stopRangingPlease];
        [self.timer invalidate];
        self.timer = nil;
        [self.tap_call setImage:[UIImage imageNamed:@"pressbuttonout.png"] forState:UIControlStateNormal];
        self.isCallOn = false;
        NSLog(@"Tap! Finished Ranging. Roll Call is OFF!");
    }
}

- (NSMutableArray *)getStudentsNotPresentFromClassName:(NSString *)class_name ClassDetail:(NSString *)class_detail{
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

-(void) abc{
    [self.be_beacon startRangingPlease];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        NSLog(@"Back to Classes.");
        [self.be_beacon stopRangingPlease];
        [self.timer invalidate];
        self.timer = nil;
        
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
