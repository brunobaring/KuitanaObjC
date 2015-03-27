//
//  Database.h
//  Kitana
//
//  Created by Bruno Baring on 3/23/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ST_Student.h"

@interface Database : NSObject

+(NSMutableDictionary *)getClassesFromTeacherMajor:(int)major Minor:(int)minor;

+(NSMutableArray *)getStudentsFromClassOfTeacherWithTeacherMajor:(int)major TeacherMinor:(int)minor ClassName:(NSString *)className Detail:(NSString *)classDetail;

+(ST_Student *)getStudentWithUser:(User *)user;

+(ST_Student *)getStudentNameWithMajor:(int)major Minor:(int)minor;

+ (NSMutableDictionary *)moveUserBetweenSectionsWithDictionary:(NSMutableDictionary *)dict userName:(NSString *)userName from:(NSString *)fromSect to:(NSString *)toSect;

+ (NSMutableArray *)checkLoginWithUsername:(NSString *)email Password:(NSString *)pass;

@end
