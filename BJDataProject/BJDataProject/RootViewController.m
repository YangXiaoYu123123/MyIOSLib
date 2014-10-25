//
//  RootViewController.m
//  BJDataProject
//
//  Created by 杨磊 on 14-9-17.
//  Copyright (c) 2014年 杨磊. All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"
#import "BJUserAccount.h"
#import "TaskQueue.h"
#import "TestTaskItem.h"
#import "JsonUtils.h"

@interface RootViewController ()<BJDataDelegate, TaskItemDelegate, TaskQueueDelegate>
{
    BJUserAccount *_account;
    TaskQueue *taskQueue;
}

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)taskWillStart:(TaskItem *)taskItem
{
}

- (void)taskDidStart:(TaskItem *)taskItem
{
}

- (void)taskDidFinished:(TaskItem *)taskItem
{
}

- (void)taskQueueFinished:(TaskQueue *)taskQueue param:(id)param error:(int)error
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(50, 50, 100, 50);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"跳转2" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(50, 150, 100, 50);
    [button addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    
    _account = [[BJUserAccount alloc] initWithDomain:USER_DOMAIN_MAIN];
    [_account addDelegate:self];
    
}

- (void)buttonAction2:(id)sender
{
    SecondViewController *second = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}



- (void)buttonAction:(id)sender
{
    
    NSString *str = @"{\"aaa\":\"bbb\", \"ccc\":1, \"list\":[{\"name\":\"yl\", \"age\":23}]}";
    NSDictionary *dic = [str jsonValue];
    NSLog(@"%@", dic);
    NSArray *list = [dic valueForKey:@"list"];
    NSDictionary *item = [list objectAtIndex:0];
    NSLog(@"age : %d", [item intValueForkey:@"age"]);
    
//    SecondViewController *second = [[SecondViewController alloc] init];
//    [self.navigationController pushViewController:second animated:YES];
    
//    [_account loginWithPerson:11 token:@"auth_token"];
//    [_account logout];
    
//    taskQueue = [[TaskQueue alloc] init];
//    TestTaskItem *item = [[TestTaskItem alloc] init];
//    item.delegate = self;
//    
//    [taskQueue addTaskItem:item];
//    taskQueue.delegate = self;
//    [taskQueue start:@"helloTask"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataEvent:(BJData *)_data error:(int)_error ope:(int)_ope error_message:(NSString *)_error_message params:(id)params
{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
