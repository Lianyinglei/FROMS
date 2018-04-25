//
//  YLSatatusTool.m
//  dsdl
//
//  Created by 廉英雷 on 17/2/8.
//  Copyright © 2017年 廉英雷. All rights reserved.
//

#import "YLSatatusTool.h"
#import "FMDB.h"

@implementation YLSatatusTool

static FMDatabase *_db;



-(void)filePath:(NSString *)filePath{

      // 1.打开数据库
      NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:filePath];
      _db = [FMDatabase databaseWithPath:path];
      [_db open];
      
      // 2.创表
      [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop (id integer PRIMARY KEY, shop blob NOT NULL);"];
      
}

- (NSMutableArray *)readShops
{
      FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_shop LIMIT 30;"];
      NSMutableArray *dataAry = [NSMutableArray array];
      while (set.next) {
            NSData *data = [set objectForColumnName:@"shop"];
            id shop = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            NSLog(@"%@", shop);
            [dataAry addObject:shop];
      }

      return dataAry;
}



- (void)addShops:(NSArray *)dataArray
{
      for (int i = 0; i<dataArray.count; i++) {
            //            HMShop *shop = [[HMShop alloc] init];
            //            shop.name = [NSString stringWithFormat:@"商品--%d", i];
            //            shop.price = arc4random() % 10000;
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataArray[i]];
            [_db executeUpdateWithFormat:@"INSERT INTO t_shop(shop) VALUES (%@);", data];
      }
      
}

+(instancetype)shareStatusTool{

      static YLSatatusTool *statusTool = nil;
      
      static  dispatch_once_t  token;
      dispatch_once(&token, ^{
           
            statusTool = [[YLSatatusTool alloc] init];
      });
      return statusTool;
}

@end
