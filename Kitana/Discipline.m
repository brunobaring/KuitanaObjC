//
//  TC_Discipline.m
//  Kitana
//
//  Created by Bruno Baring on 3/25/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "Discipline.h"
#import "ST_Student.h"
#import "TC_Teacher.h"

@implementation Discipline

+(instancetype)initDisciplineWithObjectDiscipline:(NSObject *)disc Students:(NSMutableArray *)stud{
    Discipline *discipline = [[Discipline alloc]init];
    discipline.name = [disc valueForKey:@"disciplineName"];
    discipline.details = [disc valueForKey:@"Detail"];
    discipline.students = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < stud.count ; i++) {
        ST_Student *student = [ST_Student initStudent:[stud objectAtIndex:i]];
        [discipline.students addObject:student];
    }
    return discipline;
}

+(instancetype)initDisciplineWithObjectDiscipline:(NSObject *)disc Teachers:(NSMutableArray *)stud{
    Discipline *discipline = [[Discipline alloc]init];
    discipline.name = [disc valueForKey:@"disciplineName"];
    discipline.details = [disc valueForKey:@"Detail"];
    discipline.teachers = [[NSMutableArray alloc]init];
    discipline.answer = false;
    for (int i = 0 ; i < stud.count ; i++) {
        TC_Teacher *teacher = [TC_Teacher initTeacher:[stud objectAtIndex:i]];
        [discipline.teachers addObject:teacher];
//        NSLog(@"w w %@",teacher.name);
    }
    return discipline;
}

+(instancetype)initDisciplineWithObjectDiscipline:(NSObject *)disc{
    Discipline *discipline = [[Discipline alloc]init];
    discipline.name = [disc valueForKey:@"disciplineName"];
    discipline.details = [disc valueForKey:@"Detail"];
    return discipline;
}



@end

//@property NSString *details; //provisorio. depois precisa separar entre as outras propriedades room,days,time,abreviation e classes.
