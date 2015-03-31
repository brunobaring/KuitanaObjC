//
//  ST_Student.m
//  Kitana
//
//  Created by Bruno Baring on 3/25/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "ST_Student.h"
#import "Discipline.h"

@implementation ST_Student

+(instancetype)initStudent:(NSObject *)user{
    ST_Student *student = [[ST_Student alloc]init];
    student.major = [[user valueForKey:@"Major"]intValue];
    student.minor = [[user valueForKey:@"Minor"]intValue];
    student.email = [user valueForKey:@"Email"];
    student.name = [user valueForKey:@"Name"];
    student.matricula = [user valueForKey:@"Matricula"];

    return student;
}

+(instancetype)initStudentWithArray:(NSMutableArray *)info{
    ST_Student *student = [[ST_Student alloc]init];
    student.major = [[[info objectAtIndex:1]objectForKey:@"Major"] intValue];
    student.minor = [[[info objectAtIndex:1]objectForKey:@"Minor"] intValue];
    student.minor = [[[info objectAtIndex:1]objectForKey:@"Minor"] intValue];
    student.matricula = [[info objectAtIndex:1]objectForKey:@"Matricula"];
    student.name = [[info objectAtIndex:1]objectForKey:@"Name"];
    student.classes = [[NSMutableArray alloc]init];
    NSMutableArray *disciplinesFromWeb = [[NSMutableArray alloc]initWithArray:[info objectAtIndex:2]];
    NSMutableArray *teachersAllClasses = [[NSMutableArray alloc]initWithArray:[info objectAtIndex:3]];
    for ( int i = 0 ; i < disciplinesFromWeb.count ; i++) {
        NSObject *disciplines = [disciplinesFromWeb objectAtIndex:i];
        NSMutableArray *teachers = [teachersAllClasses objectAtIndex:i];
        Discipline *discipline = [Discipline initDisciplineWithArrayDiscipline:disciplines Teachers:teachers];
        [student.classes addObject:discipline];
    }
    return student;
}

//+(instancetype)initTeacherWithArray:(NSMutableArray *)info{
//    TC_Teacher *teacher = [[TC_Teacher alloc]init];
//    teacher.major = [[[info objectAtIndex:1]objectForKey:@"Major"] intValue];
//    teacher.minor = [[[info objectAtIndex:1]objectForKey:@"Major"] intValue];
//    teacher.matricula = [[info objectAtIndex:1]objectForKey:@"Matricula"];
//    teacher.name = [[info objectAtIndex:1]objectForKey:@"Name"];
//    teacher.classes = [[NSMutableArray alloc]init];
//    NSMutableArray *disciplinesFromWeb = [[NSMutableArray alloc]initWithArray:[info objectAtIndex:2]];
//    NSMutableArray *studentsAllClasses = [[NSMutableArray alloc]initWithArray:[info objectAtIndex:3]];
//    
//    for ( int i = 0 ; i < disciplinesFromWeb.count ; i++) {
//        NSObject *disciplines = [disciplinesFromWeb objectAtIndex:i];
//        NSMutableArray *students = [studentsAllClasses objectAtIndex:i];
//        Discipline *discipline = [Discipline initDisciplineWithArrayDiscipline:disciplines Students:students];
//        [teacher.classes addObject:discipline];
//    }
//    
//    return teacher;
//}


@end
