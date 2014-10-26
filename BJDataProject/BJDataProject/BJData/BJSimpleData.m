//
//  BJSimpleData.m
//  BJDataProject
//
//  Created by 杨磊 on 14-9-19.
//  Copyright (c) 2014年 杨磊. All rights reserved.
//

#import "BJSimpleData.h"
#import "BJFileManager.h"
#import "JsonUtils.h"

@interface BJSimpleData()

@end

@implementation BJSimpleData
@synthesize data=_data;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self loadCache];
    }
    return self;
}

- (NSMutableDictionary *)data
{
    if (_data == nil)
    {
        _data = [[NSMutableDictionary alloc] init];
    }
    
    return _data;
}

- (void)setData:(NSMutableDictionary *)data
{
    _data = data;
    [self saveCache];
}

- (void)saveCache
{
    NSString *filePath = [BJFileManager getCacheFilePath:[self getCacheKey]];
    if (filePath == nil)
        return;
    [_data writeToFile:filePath atomically:YES];
}

- (void)loadCache
{
    NSString *filePath = [BJFileManager getCacheFilePath:[self getCacheKey]];
    if (filePath == nil) return;
    
    _data = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
}

- (void)refresh
{
    if (_taskQueue != nil)
    { // 正在刷新，直接跳过
        return;
    }
    
    _taskQueue = [[TaskQueue alloc] init];
    //子类去添加具体的任务
    [self doRefreshOperation:_taskQueue];
    
    _taskQueue.delegate = self;
    [_taskQueue start:nil];
}

- (void)cancelRefresh
{
    if (_taskQueue == nil)
    { // 没有在刷新
        return;
    }
    
    [_taskQueue cancelQueue];
    _taskQueue = nil;
}

- (void)doRefreshOperation:(TaskQueue *)taskQueue
{
}

- (void)taskQueueFinished:(TaskQueue *)taskQueue param:(id)param error:(int)error
{
    if (error == ERROR_SUCCESSFULL)
    {
        // 获取结果数据
        id _result = [taskQueue.result valueForKey:@"result"];
        if (_result != nil)
        {
            [_data removeAllObjects];
            _data = [[NSMutableDictionary alloc] initWithDictionary:_result];
            [self saveCache];
        }
    }
    
    [_taskQueue cleanQueue];
    _taskQueue = nil;
    [self invokeDelegateWithError:error ope:OPERATION_REFRESH error_message:[_data getError] params:nil];
}

@end
