//
//  User.h
//  Kitana
//
//  Created by Bruno Baring on 3/18/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+(instancetype)initUserWithMajor:(int)major Minor:(int)minor;

@property NSMutableArray *classes;

@property (nonatomic) NSString *email;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *matricula;
@property (nonatomic) int major;
@property (nonatomic) int minor;

@end
