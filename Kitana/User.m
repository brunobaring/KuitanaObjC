//
//  User.m
//  Kitana
//
//  Created by Bruno Baring on 3/18/15.
//  Copyright (c) 2015 Bruno Baring. All rights reserved.
//

#import "User.h"
#import "Database.h"

@interface User ()

//@property NSMutableData *responseData1;



@end

@implementation User


//+(instancetype)initUserWithMajor:(int)major Minor:(int)minor Name:(NSString *)name Email:(NSString *)email {
//    User *user = [[User alloc]init];
//    [user setMajor:major];
//    [user setMinor:minor];
//    [user setEmail:email];
//    [user setName:name];
//    return user;
//}

+(instancetype)initUserWithMajor:(int)major Minor:(int)minor{
    User *user = [[User alloc]init];
    [user setMajor:major];
    [user setMinor:minor];
    return user;
}

@end


/*
 class User
 {
 var classes : [Turma] //Dictionary<String, String>
 let major   : Int
 let minor   : Int
 var email   : String
 var name    : String
 var picture : UIImage
 var matricula:String
 
 class Turma
 {
 var nomeDisciplina:String
 var siglaDisciplina:String
 var turma:String
 var dias:String
 var horarios:String
 var professor:Teacher
 var alunos:[Student]
 var local:String
 var ID:Int
*/