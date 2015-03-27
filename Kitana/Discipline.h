//
//  TC_Discipline.h
//  Kitana
//
//  Created by Bruno Baring on 3/25/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TC_Teacher.h"

@interface Discipline : NSObject

+(instancetype)initWithName:(NSString *)name Detail:(NSString *)detail;

@property NSString *name;
@property NSString *abreviation;
@property NSString *classes;
@property NSString *days;
@property NSString *time;
@property NSMutableArray *students;
@property NSString *room;
@property NSString *details; //provisorio. depois precisa separar entre as outras propriedades
@property int id;

@end
