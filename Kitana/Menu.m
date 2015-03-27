//
//  Menu.m
//  Kitana
//
//  Created by Bruno Baring on 3/23/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "Menu.h"
#import "User.h"
#import "TC_ClassList.h"
#import "TC_NavigationController.h"
#import "TC_Teacher.h"
#import "ST_Student.h"
#import "Database.h"


@interface Menu ()

@property (weak, nonatomic) IBOutlet UILabel *major;
@property TC_Teacher* teacher;
@property ST_Student* student;

@end

@implementation Menu

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSMutableArray *info = [Database checkLoginWithUsername:@"hendicoelho@gmail.com" Password:@"225"];
    
    if ([[[info objectAtIndex:0]objectForKey:@"status"] isEqualToString:@"aluno"]) {
        //        ST_Student *teacher = [ST_Student initStudentWithArray:info];
    }
    
    
    if ([segue.identifier isEqualToString:@"sendUserTeacher"]) {
        
        if ([[[info objectAtIndex:0]objectForKey:@"status"] isEqualToString:@"professor"]) {
            self.teacher = [TC_Teacher initTeacherWithArray:info];
            TC_NavigationController *destViewController = [segue destinationViewController];
            TC_ClassList *classList = (TC_ClassList *) destViewController.topViewController;
            destViewController.teacher = self.teacher;
            [classList setTeacher:self.teacher];
        }else{
            NSLog(@"Error:Não é professor!");
        }
    }
    
    if ([segue.identifier isEqualToString:@"sendUserStudent"]) {
        TC_NavigationController *destViewController = [segue destinationViewController];
        TC_ClassList *classList = (TC_ClassList *) destViewController.topViewController;
        //        [classList setUser:self.user];
        //        destViewController.user = self.user;
        //        destViewController.className = @"Aula do BEPiD";
    }
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
