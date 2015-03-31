//
//  TC_Teacher.m
//  Kitana
//
//  Created by Bruno Baring on 3/25/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "TC_Teacher.h"
#import "Discipline.h"

@implementation TC_Teacher


+(instancetype)initTeacherWithMajor:(int)major Minor:(int)minor Classes:(NSMutableArray *)classes{
    TC_Teacher *teacher = [[TC_Teacher alloc]init];
    [teacher setMajor:major];
    [teacher setMinor:minor];
    [teacher setClasses:classes];
    return teacher;
}

+(instancetype)initTeacherWithArray:(NSMutableArray *)info{
    TC_Teacher *teacher = [[TC_Teacher alloc]init];
    teacher.major = [[[info objectAtIndex:1]objectForKey:@"Major"] intValue];
    teacher.minor = [[[info objectAtIndex:1]objectForKey:@"Major"] intValue];
    teacher.matricula = [[info objectAtIndex:1]objectForKey:@"Matricula"];
    teacher.name = [[info objectAtIndex:1]objectForKey:@"Name"];
    teacher.classes = [[NSMutableArray alloc]init];
    NSMutableArray *disciplinesFromWeb = [[NSMutableArray alloc]initWithArray:[info objectAtIndex:2]];
    NSMutableArray *studentsAllClasses = [[NSMutableArray alloc]initWithArray:[info objectAtIndex:3]];

    for ( int i = 0 ; i < disciplinesFromWeb.count ; i++) {
        NSObject *disciplines = [disciplinesFromWeb objectAtIndex:i];
        NSMutableArray *students = [studentsAllClasses objectAtIndex:i];
        Discipline *discipline = [Discipline initDisciplineWithArrayDiscipline:disciplines Students:students];
        [teacher.classes addObject:discipline];
    }
    
    return teacher;
}

+(instancetype)initTeacher:(NSObject *)user{
    TC_Teacher *teacher = [[TC_Teacher alloc]init];
    teacher.major = [[user valueForKey:@"Major"]intValue];
    teacher.minor = [[user valueForKey:@"Minor"]intValue];
    teacher.email = [user valueForKey:@"Email"];
    teacher.name = [user valueForKey:@"Name"];
    teacher.matricula = [user valueForKey:@"Matricula"];
    
    return teacher;
}


@end
