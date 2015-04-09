//
//  TC_InsertNewClass.m
//  Kitana
//
//  Created by Bruno Baring on 4/7/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "TC_InsertNewClass.h"
#import "TC_Teacher.h"
#import "Database.h"
#import "TC_NavigationController.h"
#import "TC_ClassList.h"
#import "Discipline.h"

@interface TC_InsertNewClass ()

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *details;

@end

@implementation TC_InsertNewClass

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%d",self.teacher.major);
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:254/255.0f green:219/255.0f blue:84/255.0f alpha:255/255.0f] CGColor],
                       (id)[[UIColor colorWithRed:252/255.0f green:148/255.0f blue:58/255.0f alpha:255/255.0f] CGColor],
                       nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (IBAction)confirm:(id)sender {
    [Database insertClassWithName:self.name.text Details:self.details.text Teacher:self.teacher];
    Discipline * disc = [[Discipline alloc]init];
    disc.name = self.name.text;
    disc.details = self.details.text;
    [self.teacher.classes addObject:disc];
    NSLog(@"%@",[self.teacher.classes firstObject]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"returnNewClass"]) {
        TC_ClassList *destViewController = segue.destinationViewController;
        destViewController.teacher = self.teacher;
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
