//
//  JsonUtils.h
//  BJDataProject
//
//  Created by 杨磊 on 14-10-25.
//  Copyright (c) 2014年 杨磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonUtils : NSObject


/**
    将 dictionary 或者 array 转位 Json Data
 */
+ (NSData *)encode:(id)json;

+ (NSString *)jsonToString:(id)json;

/**
    将 json data 转为 dictionary 或者 array
 */
+ (id)decode:(NSData *)data;

/**
 *  用于创建 JSON 对象或数组
 *  建议，应用中所有用到 Dictionary 或者 array 的地方都使用这个函数调用
 *
 *  @param array bool，是否要创建数组
 *
 *  @return
 */
+ (id)newJsonObject:(BOOL)array;

/**
 *  将外部的 json 转换为可变的 json(保险起见)
 *
 *  @param jsonObject 外部不知道类型的 Object
 *
 *  @return 可变的 Object
 */
+ (id)convertJsonObject:(id)jsonObject;

@end

@interface NSString(JsonObject)

/**
    字符串转 json
 */
- (id)jsonValue;

@end

@interface NSDictionary(JsonObject)

- (int)intValueForkey:(NSString *)key defaultValue:(int)defalutValue;
- (long long)longLongValueForKey:(NSString *)key defalutValue:(long long)defalutValue;
- (BOOL)boolValueForKey:(NSString *)key defalutValue:(BOOL)defalutValue;
- (float)floatValueForKey:(NSString *)key defalutValue:(float)defalutValue;
- (double)doubleValueForKey:(NSString *)key defalutValue:(double)defalutValue;
- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSDictionary *)dictionaryValueForKey:(NSString *)key;
- (NSArray *)arrayValueForKey:(NSString *)key;

- (void)setIntValue:(int)value forKey:(NSString *)key;
- (void)setLongLongValue:(long long)value forKey:(NSString *)key;
- (void)setBoolValue:(long long)value forKey:(NSString *)key;
- (void)setFloatValue:(float)value forKey:(NSString *)key;
- (void)setDoubleValue:(double)value forKey:(NSString *)key;

- (void)removeValueForKey:(NSString *)key;


- (NSString *)getError;

@end

@interface NSArray(JsonObject)
- (void)addObject:(id)object;
- (void)insertobjectHead:(id)object;
- (void)removeObjectAt:(NSInteger)index;
@end