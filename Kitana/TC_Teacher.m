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
    NSMutableArray *AUXdisciplines = [[NSMutableArray alloc]initWithArray:[info objectAtIndex:2]];
    for ( int i = 0 ; i < AUXdisciplines.count ; i++) {
        NSString *name = [[AUXdisciplines objectAtIndex:i]objectForKey:@"disciplineName"];
        NSString *detail = [[AUXdisciplines objectAtIndex:i]objectForKey:@"Detail"];
        Discipline *discipline = [Discipline initWithName:name Detail:detail];
        [teacher.classes addObject:discipline];
    }
    return teacher;
}


@end
