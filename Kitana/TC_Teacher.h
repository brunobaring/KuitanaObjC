//
//  TC_Teacher.h
//  Kitana
//
//  Created by Bruno Baring on 3/25/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface TC_Teacher : User

+(instancetype)initTeacherWithMajor:(int)major Minor:(int)minor Classes:(NSMutableArray *)classes;

+(instancetype)initTeacherWithArray:(NSMutableArray *)info;

+(instancetype)initTeacher:(NSObject *)user;

@end
