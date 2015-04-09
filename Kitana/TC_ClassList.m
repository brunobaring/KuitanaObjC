//
//  Teacher.m
//  Kitana
//
//  Created by Bruno Baring on 3/10/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "TC_ClassList.h"
#import "TC_Guest_List.h"
#import "TC_NavigationController.h"
#import "TC_Teacher.h"
#import "TC_InsertNewClass.h"
#import "Database.h"
#import "Discipline.h"

@interface TC_ClassList ()

@property NSString *className;
@property NSString *classDetail;

@end

@implementation TC_ClassList

- (void)viewDidLoad {
    [super viewDidLoad];    //253 218 57 //249 176 30
    
    //    self.tableView.backgroundColor = [UIColor colorWithRed:252/255.0f green:148/255.0f blue:58/255.0f alpha:255.0/255.0f];
    
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
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (self.teacher.classes.count == 0) {
        return 1;
    }else{
        return self.teacher.classes.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MateriasProf" forIndexPath:indexPath];
    if (self.teacher.classes.count == 0) {
        cell.textLabel.text = @"You don`t have any classes yet";
        cell.detailTextLabel.text = @"Add one tapping on ➕";
    }else{
        Discipline *disc = [self.teacher.classes objectAtIndex:indexPath.row];
        cell.textLabel.text = disc.name;
        cell.detailTextLabel.text = disc.details;
        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.detailTextLabel.numberOfLines = 3;
    }
    //253 218 57
    [cell setBackgroundColor:[UIColor colorWithRed:254/255.0f green:219/255.0f blue:84/255.0f alpha:1.0f]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    UITableViewCell *aaa = [tableView cellForRowAtIndexPath:indexPath];
    
    self.className = aaa.textLabel.text;
    self.classDetail = aaa.detailTextLabel.text;
    
    
    //    [self performSegueWithIdentifier: @"sendUser2" sender: self];
    
}

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"sendUser2"]) {
        UITableViewCell *cellSegue = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
        TC_Guest_List *destViewController = segue.destinationViewController;
        destViewController.teacher = self.teacher;
        destViewController.className = cellSegue.textLabel.text;
        destViewController.classDetail = cellSegue.detailTextLabel.text;
    }
    if ([segue.identifier isEqualToString:@"insertNewClass"]) {
        TC_InsertNewClass *destViewController = segue.destinationViewController;
        destViewController.teacher = self.teacher;
    }
}



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
