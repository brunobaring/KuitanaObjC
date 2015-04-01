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
#import "ST_Guest.h"
#import "ST_NavigationController.h"
#import "Discipline.h"
#import "Database.h"


@interface Menu ()

@property (weak, nonatomic) IBOutlet UIButton *Log_In;
@property TC_Teacher* teacher;
@property ST_Student* student;
@property ( nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITextField *Email_login;
@property (weak, nonatomic) IBOutlet UITextField *Password_login;

@end

@implementation Menu

- (void)viewDidLoad {
    

    

    [super viewDidLoad];
    
    self.Password_login.secureTextEntry = YES;
    
//    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"telacadastro.jpg"]];
//                                        self.backgroundImageView.frame = self.view.bounds;
//                                        [self.view insertSubview:self.backgroundImageView belowSubview:self.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    NSMutableArray *info = [Database checkLoginWithUsername:@"brunobaring@gmail.com" Password:@"555"];
////    NSMutableArray *info = [Database checkLoginWithUsername:@"joaobrandao@gmail.com" Password:@"666"];
//    
//    if ([identifier isEqualToString:@"sendUserTeacher"]) {
//        if ([[[info objectAtIndex:0]objectForKey:@"status"] isEqualToString:@"professor"]) {
//            self.teacher = [TC_Teacher initTeacherWithArray:info];
//            return YES;
//        }else{
//            NSLog(@"Error:Não é PROFESSOR!");
//            return NO;
//        }
//    }else if ([identifier isEqualToString:@"sendUserStudent"]) {
//        if ([[[info objectAtIndex:0]objectForKey:@"status"] isEqualToString:@"aluno"]) {
//            self.student = [ST_Student initStudentWithArray:info];
//            return YES;
//        }else{
//            NSLog(@"Error:Não é ALUNO!");
//            return NO; 253 218 57
//        }
//    }
//    return NO;
//}

- (IBAction)WillLogin:(id)sender {
    
    
    NSMutableArray *info = [[NSMutableArray alloc]init];
    //*************
    if ([self.Email_login.text isEqualToString:@"st"]) {
        info = [Database checkLoginWithEmail:@"hendicoelho@gmail.com" Password:@"225"];
    }else if ([self.Email_login.text isEqualToString:@"tc"]) {
        info = [Database checkLoginWithEmail:@"joaobrandao@gmail.com" Password:@"666"];
    }else{
    //*************
        info = [Database checkLoginWithEmail:self.Email_login.text Password:self.Password_login.text];
    }
    if ([[[info objectAtIndex:0]objectForKey:@"status"] isEqualToString:@"professor"]) {
        self.teacher = [TC_Teacher initTeacherWithArray:info];
        [self performSegueWithIdentifier:@"sendUserTeacher" sender:self];
    }
    if ([[[info objectAtIndex:0]objectForKey:@"status"] isEqualToString:@"aluno"]) {
        self.student = [ST_Student initStudentWithArray:info];
        [self performSegueWithIdentifier:@"sendUserStudent" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"sendUserTeacher"]) {
            TC_NavigationController *destViewController = [segue destinationViewController];
            TC_ClassList *classList = (TC_ClassList *) destViewController.topViewController;
            destViewController.teacher = self.teacher;
            [classList setTeacher:self.teacher];
    }
    if ([segue.identifier isEqualToString:@"sendUserStudent"]) {
            ST_NavigationController *destViewController = [segue destinationViewController];
            ST_Guest *guest = (ST_Guest *) destViewController.topViewController;
            destViewController.student = self.student;
            [guest setStudent:self.student];
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
