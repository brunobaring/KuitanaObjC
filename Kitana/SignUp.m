//
//  SignUp.m
//  Kitana
//
//  Created by Bruno Baring on 4/2/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "SignUp.h"
#import "Database.h"
#import "TC_Teacher.h"
#import "ST_Student.h"
#import "TC_NavigationController.h"
#import "ST_NavigationController.h"
#import "TC_ClassList.h"
#import "ST_Guest.h"

@interface SignUp ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;
@property TC_Teacher *teacher;
@property ST_Student *student;

@end

@implementation SignUp

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ok:(id)sender {
    
    NSMutableArray *aux = [[NSMutableArray alloc]init];
    
    if (self.type.selectedSegmentIndex == 0) {
        aux = [Database insertTeacherWithName:self.name.text Email:self.email.text Password:@"123123" Matricula:@"321321"];
        int major = [[[aux objectAtIndex:0]objectForKey:@"major"]intValue];
        int minor = [[[aux objectAtIndex:0]objectForKey:@"minor"]intValue];
        self.teacher = [TC_Teacher initTeacherWithMajor:major Minor:minor Name:self.name.text Email:self.email.text Matricula:@"321321"];
        
        [self performSegueWithIdentifier:@"SignUpTeacher" sender:self];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"SignUpTeacher"]) {
        TC_NavigationController *destViewController = [segue destinationViewController];
        TC_ClassList *classList = (TC_ClassList *) destViewController.topViewController;
        destViewController.teacher = self.teacher;
        [classList setTeacher:self.teacher];
    }
    if ([segue.identifier isEqualToString:@"SignUpStudent"]) {
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
