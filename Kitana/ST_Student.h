//
//  ST_Student.h
//  Kitana
//
//  Created by Bruno Baring on 3/25/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ST_Student : User

+ (instancetype)initStudentWithMajor:(int)major Minor:(int)minor Name:(NSString *)name Email:(NSString *)email Matricula:(NSString *)matricula;

+(instancetype)initStudent:(NSObject *)user;

+(instancetype)initStudentWithArray:(NSMutableArray *)info;

@end
