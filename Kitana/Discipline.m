//
//  TC_Discipline.m
//  Kitana
//
//  Created by Bruno Baring on 3/25/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "Discipline.h"

@implementation Discipline

+(instancetype)initWithName:(NSString *)name Detail:(NSString *)detail{
    Discipline *discipline = [[Discipline alloc]init];
    discipline.name = name;
    discipline.details = detail;
    return discipline;
}

@end

