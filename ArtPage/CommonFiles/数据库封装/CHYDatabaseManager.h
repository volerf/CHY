//
//  CHYDatabaseManager.h
//  以FMDB为基础的数据库封装
//
//  Created by 华杉科技 on 2018/9/14.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "CommonClass.h"

@interface CHYDatabaseManager : UIView<NSCopying>

@property(nonatomic,strong) FMDatabase *fmdb;
@property(nonatomic,strong) FMResultSet *fmrs;

#pragma make  -  创建单例对象以及数据库文件
//获取数据库单例
+ (CHYDatabaseManager *)shareDataBaseManager;

#pragma make  -  数据库表
//创建数据库表格
- (void)createTableWithModelClass:(NSString *)tableName;

#pragma make  -  判断是否存在
//判断表格是否存在
- (BOOL)isExistsTable:(NSString *)tableName;

//判断表中是否存在某个对象
- (BOOL)isExistsFromTable:(NSString *)tableName whereObject:(id)object;


#pragma make  -  向数据库插入数据
/*-----------方法一：插入一个字典--------*/
- (BOOL)insertWithTabelName:(NSString *)tableName andDictionary:(NSDictionary *)objDic;

/*----------方法二：插入一个对象---------*/
- (BOOL)insertWithTableName:(NSString *)tableName andModel:(id)model;

/*----------方法三：插入一组字典数据------*/
- (BOOL)insertWithTableName:(NSString *)tableName andDicArray:(NSArray *)dicArray;

/*--------方法四：插入一组对象-----------*/
- (BOOL)insertWithTableName:(NSString *)tableName andModelArray:(NSArray *)modelArr;


#pragma make  -  删除数据
//通过表（类）名和删除条件删除数据
- (BOOL)deleteWithTableName:(NSString *)tableName andConditionsDic:(NSDictionary *)conDic;


#pragma make  -  修改数据
//通过表名、新数据、和修改条件修改数据
- (BOOL)updateWithTableName:(NSString *)tableName andNewDataDic:(NSDictionary *)newDic andConditionsDic:(NSDictionary *)conDic;


#pragma make  -  查询数据
//查询某个id范围内的所有数据
- (NSMutableArray *)selectWithTableName:(NSString *)tableName andFromId:(NSString *)beginId andToId:(NSString *)endId;

//根据条件查询数据
- (NSMutableArray *)selectWithTableName:(NSString *)tableName andSelectCondition:(NSDictionary *)conDic;

//查询表中的所有数据
- (NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName;

//查找某一列的所有数据
- (NSMutableArray *)selectWithColumn:(NSString *)column AllDataWithTableName:(NSString *)tableName;

//根据条件查询某一列数据
- (NSMutableArray *)selectWithColumn:(NSString *)column fromTable:(NSString *)tableName whereCondition:(NSDictionary *)conDic;

@end
