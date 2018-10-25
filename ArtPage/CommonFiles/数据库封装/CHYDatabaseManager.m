//
//  CHYDatabaseManager.m
//  以FMDB为基础的数据库封装
//
//  Created by 华杉科技 on 2018/9/14.
//  Copyright © 2018年 曹海洋. All rights reserved.
//

#import "CHYDatabaseManager.h"

@implementation CHYDatabaseManager

@synthesize fmdb;
@synthesize fmrs;
static CHYDatabaseManager *dbManager = nil;

#pragma make  -  创建单例对象以及数据库文件
//获取数据库单例
+ (CHYDatabaseManager *)shareDataBaseManager
{
    if(!dbManager)
    {
        @synchronized(self)
        {
            if(!dbManager)
            {
                dbManager = [[super allocWithZone:NULL] init];
                //获取数据库文件的路径
                NSString *dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myProject.db"];
                NSLog(@"-------%@",dbPath);
                //通过路径创建fmdb对象
                dbManager.fmdb = [FMDatabase databaseWithPath:dbPath];
                
            }
        }
    }
    //打开数据库
    if(![dbManager.fmdb open])
    {
        dbManager = nil;
    }
    
    return dbManager;
}
+ (id)new
{
    return [CHYDatabaseManager shareDataBaseManager];
}
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [CHYDatabaseManager shareDataBaseManager];
}
- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

#pragma make  -  数据库表
//创建数据库表格
- (void)createTableWithModelClass:(NSString *)tableName
{
    if([self isExistsTable:tableName])
    {
        return ;
    }
    //拼接创建表的sql语句
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:[NSString stringWithFormat:@"CREATE TABLE %@(",tableName]];
    
    //通过tableName获取所有属性的名称
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(NSClassFromString(tableName), &propertyCount); //获取tableName类的所有属性的信息集合
    //循环遍历，获取所有属性的属性名并且添加到sql字符串上
    for(int i = 0; i < propertyCount; i++)
    {
        NSString *propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
        [sql appendFormat:@"%@, ",propertyName];
    }
    //添加给表设置主键的语句
    [sql appendString:@"thisid integer primary key autoincrement)"];
    NSLog(@"%@",sql);
    //执行sql语句
    [dbManager.fmdb executeUpdate:sql];
    
}

#pragma make  -  判断是否存在
//判断表格是否存在
- (BOOL)isExistsTable:(NSString *)tableName
{
    BOOL flag = NO;
    if([self.fmdb tableExists:tableName])    //判断表格是否存在
    {
        flag = YES;
    }
    return flag;
}
//判断表中是否存在某个对象
- (BOOL)isExistsFromTable:(NSString *)tableName whereObject:(id)object
{
    BOOL flag = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([NSClassFromString(tableName) class], &propertyCount);
    for(int i = 0; i < propertyCount; i++)
    {
        NSString *propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding: NSUTF8StringEncoding];
        if([object valueForKey:propertyName])
        {
            [dic setValue:[object valueForKey:propertyName] forKey:propertyName];
        }
    }
    //开始拼接
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"SELECT * FROM %@ WHERE %@ LIKE ?",tableName,[dic allKeys][0]];
    for(int i = 1; i < [dic allKeys].count; i++)
    {
        [sql appendFormat:@" AND %@ LIKE ?",[dic allKeys][i]];
    }
    //拼接完成
    self.fmrs = [self.fmdb executeQuery:sql withArgumentsInArray: [dic allValues]];
    if([self.fmrs next])
    {
        flag = YES;
    }
    
    return flag;
}

#pragma make  -  向数据库插入数据           insert into User(userName,pwd)Values(?,?)
/*-----------方法一：插入一个字典---------*/
//通过类名和数据字典向表中插入一条数据
- (BOOL)insertWithTabelName:(NSString *)tableName andDictionary:(NSDictionary *)objDic
{
    BOOL flag = NO;
    //判断表格是否存在
    if(![[CHYDatabaseManager shareDataBaseManager] isExistsTable:tableName])
    {
        //不存在就创建一个表格
        [[CHYDatabaseManager shareDataBaseManager] createTableWithModelClass:tableName];
    }
    //获取所有属性名
    NSArray *array = [objDic allKeys];
    
    //创建sql语句
    NSMutableString *sql = [NSMutableString string];
/*------开始拼接sql语句-------*/
    [sql appendFormat:@"INSERT INTO %@(",tableName];
    for(int i = 0; i < [array count]; i++)
    {
        [sql appendFormat:@"%@,",array[i]];    //把属性名拼接到sql语句上
    }
    //删除最后一个多余的","号
    [sql deleteCharactersInRange:NSMakeRange([sql length] - 1, 1)];
    [sql appendString:@")VALUES("];         //拼接values
    for(int i = 0; i < [array count]; i++)
    {
        [sql appendString:@"?,"];           //拼接占位符？
    }
    [sql deleteCharactersInRange:NSMakeRange([sql length] - 1, 1)];     //删除多余逗号
    [sql appendString:@")"];
/*-------拼接结束-------*/
    //执行sql语句
    if([fmdb executeUpdate:sql withArgumentsInArray: [objDic allValues]])
    {
        flag = YES;
    }
    
    return flag;
}


/*----------方法二：插入一个对象---------*/
//通过类名和该类的一个对象向表中插入一条数据
- (BOOL)insertWithTableName:(NSString *)tableName andModel:(id)model
{
    BOOL flag = NO;
    NSMutableDictionary *objDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    //通过tableName获取所有属性的名称
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(NSClassFromString(tableName), &propertyCount); //获取tableName类的所有属性的信息集合
    for(int i = 0; i < propertyCount; i++)
    {
        //循环获取类的每一个属性名称
        NSString *propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
        //取出类中的该属性的值以键值对的形式添加到字典中
        if([model valueForKey:propertyName])
        {
            [objDic setValue:[model valueForKey:propertyName] forKey:propertyName];
        }
    }
    //调用方法执行插入数据库操作
    if([[CHYDatabaseManager shareDataBaseManager] insertWithTabelName:tableName andDictionary:objDic])
    {
        flag = YES;
    }
    
    return flag;
}

/*----------方法三：插入一组字典数据----------*/
- (BOOL)insertWithTableName:(NSString *)tableName andDicArray:(NSArray *)dicArray
{
    BOOL flag = NO;
    
    //开启事务避免批量数据插入时候卡顿的情况
    [[[CHYDatabaseManager shareDataBaseManager] fmdb] beginTransaction];
    
    int sum = 0;        //计算插入成功的数据个数
    //循环插入数据
    for(int i = 0; i < [dicArray count]; i++)
    {
        NSDictionary *objDic = dicArray[i];         //取得第i个字典
        //调用插入单个字典的方法并判断是否插入成功
        if([[CHYDatabaseManager shareDataBaseManager] insertWithTabelName:tableName andDictionary:objDic])
        {
            sum++;
        }
    }
    if(sum == [dicArray count])         //判断是否全部插入完成
    {
        flag = YES;
        [[[CHYDatabaseManager shareDataBaseManager] fmdb] commit];      //保存事务
    }
    else{
        [[[CHYDatabaseManager shareDataBaseManager] fmdb] rollback];    //事务回滚
    }
    
    return flag;
}

/*--------方法四：插入一组对象---------*/
- (BOOL)insertWithTableName:(NSString *)tableName andModelArray:(NSArray *)modelArr
{
    BOOL flag = NO;
    //开启事务
    [[[CHYDatabaseManager shareDataBaseManager] fmdb] beginTransaction];
    int sum = 0;
    //遍历数组插入数据
    for(id obj in modelArr)
    {
        //取出数组中的对象调用插入单个对象的方法插入数据并判断是否插入成功
        if([[CHYDatabaseManager shareDataBaseManager] insertWithTableName:tableName andModel:obj])
        {
            sum++;
        }
    }
    if(sum == [modelArr count])         //判断是否全部插入成功
    {
        [[[CHYDatabaseManager shareDataBaseManager] fmdb] commit];      //保存事务
        flag = YES;
    }
    else{
        [[[CHYDatabaseManager shareDataBaseManager] fmdb] rollback];    //回滚事务
    }
    
    return flag;
}

#pragma make  -  删除数据               delete from User where userName like ? and pwd like ?
//通过表（类）名和删除条件删除数据
- (BOOL)deleteWithTableName:(NSString *)tableName andConditionsDic:(NSDictionary *)conDic
{
    BOOL flag = NO;
    NSMutableString *sql = [NSMutableString string];        //创建sql语句
/*----------开始拼接-----------*/
    if([conDic allKeys].count)     //判断是否有删除条件
    {
        [sql appendFormat:@"DELETE FROM %@ WHERE %@ LIKE ?",tableName,[[conDic allKeys] objectAtIndex:0]];
        for(int i = 1; i < [conDic allKeys].count; i++)
        {
            [sql appendFormat:@" AND %@ LIKE ?",[[conDic allKeys] objectAtIndex:i]];
        }
    }
    else{
        [sql appendFormat:@"DELETE FROM %@",tableName];
    }
/*----------拼接完成-----------*/
    //执行数据库语句
    if([[[CHYDatabaseManager shareDataBaseManager] fmdb] executeUpdate:sql withArgumentsInArray: [conDic allValues]])
    {
        flag = YES;
    }
    return flag;
}

#pragma make  -  修改数据    update User set userName = ?,pwd = ? where userName like ? and pwd like ?
//通过表名、新数据、和修改条件修改数据
- (BOOL)updateWithTableName:(NSString *)tableName andNewDataDic:(NSDictionary *)newDic andConditionsDic:(NSDictionary *)conDic
{
    BOOL flag = NO;
    NSMutableString *sql = [NSMutableString string];        //创建sql语句
/*-----------开始拼接-----------*/
    //拼接语句开头和第一个修改内容
    [sql appendFormat: @"UPDATE %@ SET %@ = ?",tableName,[newDic allKeys][0]];
    //拼接修改内容
    for(int i = 1; i < [newDic allKeys].count; i++)
    {
        [sql appendFormat: @", %@ = ?",[[newDic allKeys] objectAtIndex:i]];
    }
    //拼接where和第一个修改条件
    [sql appendFormat: @" WHERE %@ LIKE ?",[[conDic allKeys] objectAtIndex:0]];
    //拼接修改条件
    for(int i = 1; i < [conDic allKeys].count; i++)
    {
        [sql appendFormat: @" AND %@ LIKE ?",[[conDic allKeys] objectAtIndex:i]];
    }
    //创建参数数组
    NSMutableArray *argumentsArr = [[NSMutableArray alloc] initWithCapacity:1];
    //添加修改内容的值
    for(id value in [newDic allValues])
    {
        [argumentsArr addObject:value];
    }
    //添加修改条件的值
    for(id value in [conDic allValues])
    {
        [argumentsArr addObject:value];
    }
    //执行修改语句并判断是否修改成功
    if([[[CHYDatabaseManager shareDataBaseManager] fmdb] executeUpdate:sql withArgumentsInArray:argumentsArr])
    {
        flag = YES;
    }
    
    return flag;
}


#pragma make  -  查询数据       select userName,pwd from tableName where userName = ?
//查询某个id范围内的所有数据
- (NSMutableArray *)selectWithTableName:(NSString *)tableName andFromId:(NSString *)beginId andToId:(NSString *)endId
{
    //判断表格是否存在
    if(![[CHYDatabaseManager shareDataBaseManager] isExistsTable:tableName])
    {
        //不存在就创建一个表格
        [[CHYDatabaseManager shareDataBaseManager] createTableWithModelClass:tableName];
    }
    //创建一个数组用来存放查询结果
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableString *sql = [NSMutableString string];        //创建sql语句
/*----------开始拼接-----------*/
    if(beginId == nil && endId == nil)      //where id >= ? AND id <= ?
    {
        [sql appendFormat:@"SELECT * from %@",tableName];       //beginId和endId都为空
        dbManager.fmrs = [dbManager.fmdb executeQuery:sql];
    }
    else if (beginId == nil)
    {
        [sql appendFormat:@"SELECT * from %@ where thisid < ?",tableName];     //查询第一个到指定的范围
        dbManager.fmrs = [dbManager.fmdb executeQuery:sql,endId];
    }
    else if (endId == nil)
    {
        [sql appendFormat:@"SELECT * from %@ where thisid >= ?",tableName];     //查询指定的后面的所有
        dbManager.fmrs = [dbManager.fmdb executeQuery:sql,beginId];
    }
    else{
        [sql appendFormat:@"SELECT * from %@ where thisid >= ? AND thisid < ?",tableName]; //查询指定范围的数据
        dbManager.fmrs = [dbManager.fmdb executeQuery:sql,beginId,endId];
    }
/*-------------拼接结束--------------*/
    //循环遍历查询结果
    while ([dbManager.fmrs next])
    {
        //通过tableName创建对象
        id model = [[NSClassFromString(tableName) alloc] init];
        unsigned int propertyCount = 0;     //用来记录对象中的属性的个数
        //获取tableName里所有的属性信息数组
        objc_property_t *properties = class_copyPropertyList(NSClassFromString(tableName), &propertyCount);
        //循环遍历类的属性信息数组
        for(int i = 0; i < propertyCount; i++)
        {
            //获取类的属性的属性的名称
            NSString *propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
            //判断dbManager.fmrs[propertyName]的值是否存在
            if(![dbManager.fmrs[propertyName] isKindOfClass:[NSNull class]] && dbManager.fmrs[propertyName] != nil)
            {
                //给model的这个属性赋值
                [model setValue:dbManager.fmrs[propertyName] forKey:propertyName];
            }
        }
        //把赋完值的model假如结果数组
        [resultArr addObject:model];
    }
    //返回查询结果
    return resultArr;
}

//根据条件查询数据
- (NSMutableArray *)selectWithTableName:(NSString *)tableName andSelectCondition:(NSDictionary *)conDic
{
    //判断表格是否存在
    if(![[CHYDatabaseManager shareDataBaseManager] isExistsTable:tableName])
    {
        //不存在就创建一个表格
        [[CHYDatabaseManager shareDataBaseManager] createTableWithModelClass:tableName];
    }
    //创建数组用来返回查询结果
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:1];
    //创建数据库查询语句
    NSMutableString *sql = [NSMutableString string];
/*-----------开始拼接------------*/
    [sql appendFormat: @"SELECT * From %@ WHERE %@ = ?",tableName,[conDic allKeys][0]];
    for(int i = 1; i < [conDic allKeys].count; i++)
    {
        [sql appendFormat: @" AND %@ = ?",[conDic allKeys][i]];
    }
/*----------拼接完成------------*/
    self.fmrs = [self.fmdb executeQuery:sql withArgumentsInArray:[conDic allValues]];
    while([self.fmrs next])
    {
        //通过tableName创建对象
        id model = [[NSClassFromString(tableName) alloc] init];
        unsigned int propertyCount = 0;     //用来记录对象中的属性的个数
        //获取tableName里所有的属性信息数组
        objc_property_t *properties = class_copyPropertyList(NSClassFromString(tableName), &propertyCount);
        //循环遍历类的属性信息数组
        for(int i = 0; i < propertyCount; i++)
        {
            //获取类的属性的属性的名称
            NSString *propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
            //判断dbManager.fmrs[propertyName]的值是否存在
            if(![dbManager.fmrs[propertyName] isKindOfClass:[NSNull class]] && dbManager.fmrs[propertyName] != nil)
            {
                //给model的这个属性赋值
                [model setValue:dbManager.fmrs[propertyName] forKey:propertyName];
            }
        }
        //把赋完值的model加入结果数组
        [resultArr addObject:model];
    }
    
    return resultArr;
}

//查询表中的所有数据
- (NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName
{
    //判断表格是否存在
    if(![[CHYDatabaseManager shareDataBaseManager] isExistsTable:tableName])
    {
        //不存在就创建一个表格
        [[CHYDatabaseManager shareDataBaseManager] createTableWithModelClass:tableName];
    }
    
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"SELECT * FROM %@",tableName];   //查询语句
    self.fmrs = [self.fmdb executeQuery:sql];       //执行查询语句
    //循环查询结果，取出转化从对象数组
    while([self.fmrs next])
    {
        //创建对象存放数据
        id model = [[NSClassFromString(tableName) alloc] init];
        //取出tableName类型的所有属性信息的集合
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList(NSClassFromString(tableName), &propertyCount);
        for(int i = 0; i < propertyCount; i++)
        {
            //循环获取每个属性的名称，通过名称从fmrs中取值并赋值给model
            NSString *propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
            [model setValue:self.fmrs[propertyName] forKey:propertyName];
        }
        //model添加到数组中
        [resultArr addObject:model];
    }
    
    return resultArr;
}

//查询表中的所有数据
- (NSMutableArray *)selectWithColumn:(NSString *)column AllDataWithTableName:(NSString *)tableName
{
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"SELECT * FROM %@",tableName];   //查询语句
    self.fmrs = [self.fmdb executeQuery:sql];       //执行查询语句
    //循环查询结果，取出转化从对象数组
    while([self.fmrs next])
    {
        NSString *str = [self.fmrs objectForColumn:column];
        [resultArr addObject: str];
    }
    
    return resultArr;
}
//根据条件查询某一列数据
- (NSMutableArray *)selectWithColumn:(NSString *)column fromTable:(NSString *)tableName whereCondition:(NSDictionary *)conDic
{
    NSMutableArray *modelArr = [[CHYDatabaseManager shareDataBaseManager] selectWithTableName:tableName andSelectCondition:conDic];
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:1];
    for(int i = 0; i < modelArr.count; i++)
    {
        id model = [[NSClassFromString(tableName) alloc] init];
        model = modelArr[i];
        NSString *str = [model valueForKey:column];
        if(!str)
        {
            str = @"";
        }
        [resultArr addObject:str];
    }
    return resultArr;
}


@end




















