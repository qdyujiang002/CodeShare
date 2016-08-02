//
//  ViewController.m
//  CodeShare
//
//  Created by qianfeng_yujiang on 16/8/2.
//  Copyright © 2016年 qdyujiang002. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "NetWorkTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary* paraDic = @{
                              @"service":@"UserInfo.GetInfo",
                              @"uid":@"1",
                              };

    [NetWorkTool getDataWithParameters:paraDic completeBlock:^(BOOL success,id result) {
        //虽然我们把成功和失败写到一个block回调，但是还是
        if (success) {
            NSLog(@"用户信息-----%@",result);
        }else{
            NSLog(@"失败原因-----%@",result);
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
