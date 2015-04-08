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
@property (weak, nonatomic) IBOutlet UITextField *matricula;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;
@property TC_Teacher *teacher;
@property ST_Student *student;

@end

@implementation SignUp

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:254/255.0f green:219/255.0f blue:84/255.0f alpha:255/255.0f] CGColor],
                       (id)[[UIColor colorWithRed:252/255.0f green:148/255.0f blue:58/255.0f alpha:255/255.0f] CGColor],
                       nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ok:(id)sender {
    
    NSMutableArray *aux = [[NSMutableArray alloc]init];
    
    if (self.type.selectedSegmentIndex == 0) {
        aux = [Database insertUserWithName:self.name.text Email:self.email.text Password:self.password.text Matricula:self.matricula.text Type:@"teacher"];
        int major = [[[aux objectAtIndex:0]objectForKey:@"major"]intValue];
        int minor = [[[aux objectAtIndex:0]objectForKey:@"minor"]intValue];
        self.teacher = [TC_Teacher initTeacherWithMajor:major Minor:minor Name:self.name.text Email:self.email.text Matricula:self.matricula.text];
        
        [self performSegueWithIdentifier:@"SignUpTeacher" sender:self];
    }
    
    if (self.type.selectedSegmentIndex == 1) {
        aux = [Database insertUserWithName:self.name.text Email:self.email.text Password:self.password.text Matricula:self.matricula.text Type:@"student"];
        int major = [[[aux objectAtIndex:0]objectForKey:@"major"]intValue];
        int minor = [[[aux objectAtIndex:0]objectForKey:@"minor"]intValue];
        self.student = [ST_Student initStudentWithMajor:major Minor:minor Name:self.name.text Email:self.email.text Matricula:self.matricula.text];
        
        [self performSegueWithIdentifier:@"SignUpStudent" sender:self];
    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL"
//                                                    message:@"Dee dee doo doo."
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
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

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
