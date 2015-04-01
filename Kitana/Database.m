//
//  Database.m
//  Kitana
//
//  Created by Bruno Baring on 3/23/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "Database.h"
#import "User.h"
#import "TC_Teacher.h"
#import "ST_Student.h"

@implementation Database

//+ (NSMutableDictionary *)getClassesFromTeacherMajor:(int)major Minor:(int)minor{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"GET"];
//    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://198.199.109.62/getClassesFromTeacherMajorAndMinor.php?major=%d&minor=%d",major,minor]]];
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSArray *response1 = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
//    NSMutableArray *class = [[NSMutableArray alloc] init];
//    for (int i = 0; i < response1.count; i++) {
//        [class addObject:[NSString stringWithFormat:@"%@",[[response1 objectAtIndex:i]objectForKey:@"name"]]];
//    }
//    NSMutableArray *detail = [[NSMutableArray alloc] init];
//    for (int i = 0; i < response1.count; i++) {
//        [detail addObject:[NSString stringWithFormat:@"%@",[[response1 objectAtIndex:i]objectForKey:@"detail"]]];
//    }
//    NSMutableDictionary *retorno = [NSMutableDictionary dictionaryWithObjects:@[class,detail] forKeys:@[@"Class",@"Detail"]];
//    //    NSLog(@"%@",retorno);
//    return retorno;
//}
//
//
//
//+(NSMutableArray *)getStudentsFromClassOfTeacherWithTeacherMajor:(int)major TeacherMinor:(int)minor ClassName:(NSString *)className Detail:(NSString *)classDetail{
//    
//    NSString *link = [NSString stringWithFormat:@"http://198.199.109.62/getStudentsFromClassOfTeacherWithTeacherMajor.php?major=%d&minor=%d&classname=%@&detail=%@", major, minor, className, classDetail];
//    
//    link = [link stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"GET"];
//    [request setURL:[NSURL URLWithString:link]];
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSMutableArray *response1 = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
//    NSMutableArray *name = [[NSMutableArray alloc] init];
//    for (int i = 0; i < response1.count; i++) {
//        [name addObject:[NSString stringWithFormat:@"%@",[[response1 objectAtIndex:i]objectForKey:@"name"]]];
//    }
//    
//    NSLog(@"%@", name);
//    return name;
//}
//
//+(ST_Student *)getStudentNameWithMajor:(int)major Minor:(int)minor{
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"GET"];
//    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://198.199.109.62/getStudentNameWithMajorAndMinor.php?major=%d&minor=%d",major, minor]]];
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSArray *response1 = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
//    
//    NSLog(@"getstudent %@",response1);
//    
//    ST_Student *student = [[ST_Student alloc]init];
//    student.name = [NSString stringWithFormat:@"%@",[[response1 objectAtIndex:0]objectForKey:@"name"]];
//    return student;
//}
//
//+ (NSMutableDictionary *)moveUserBetweenSectionsWithDictionary:(NSMutableDictionary *)dict userName:(NSString *)userName from:(NSString *)fromSect to:(NSString *)toSect{
//    NSMutableArray *sessao = [NSMutableArray arrayWithArray:[dict objectForKey:fromSect]];
//    [sessao removeObject:userName];
//    [dict setObject:sessao forKey:fromSect];
//    sessao = [NSMutableArray arrayWithArray:[dict objectForKey:toSect]];
//    if(![sessao containsObject:userName])
//        [sessao addObject:userName];
//    [dict setObject:sessao forKey:toSect];
//    
//    return dict;
//}

+ (NSMutableArray *)checkLoginWithEmail:(NSString *)email Password:(NSString *)pass{
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://198.199.109.62/checkLogin.php?email=%@&senha=%@",email,pass]]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSMutableArray *response1 = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@",response1);

    return response1;
}

@end
