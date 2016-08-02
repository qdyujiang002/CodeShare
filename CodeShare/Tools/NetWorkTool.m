//
//  NetWorkTool.m
//  CodeShare
//
//  Created by qianfeng_yujiang on 16/8/2.
//  Copyright © 2016年 qdyujiang002. All rights reserved.
//

#import "NetWorkTool.h"
#import <AFNetworking.h>
@implementation NetWorkTool

//为了防止我们的应用频繁的获取网络数据的时候，创建的sessionManager过多,会大量消耗手机资源，我们最好将封装为一个单例,获取网络数据只用到这一个对象.
+(AFHTTPSessionManager*)sharedManager{
    static AFHTTPSessionManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://www.1000phone.tk"]];
        //设置请求的超时时间
        //设置请求的参数编码方式
        manager.requestSerializer.timeoutInterval = 30;
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/html", @"text/xml", @"application/json", nil];
    });
    return manager;
}


+ (void)getDataWithParameters:(NSDictionary *)parameters completeBlock:(void (^)(BOOL success,id result))complete{

    
    [[self sharedManager] POST:@""  parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSNumber* serviceCode = [responseObject objectForKey:@"ret"];
        if ([serviceCode isEqualToNumber:@200]) {
            //证明没有服务错误
            NSDictionary* retData = [responseObject objectForKey:@"data"];
            NSNumber* dataCode = [retData objectForKey:@"code"];
            if ([dataCode isEqualToNumber:@0]) {
                //证明返回的数据没有错误
                NSDictionary* userInfo = [retData objectForKey:@"data"];
                NSLog(@"%@",userInfo);
                
                //先判断是否有完成请求的处理block,如果有，就传回解析到的数据
                if (complete) {
                    complete(YES,userInfo);
                }
                
                
            }else{
                NSString* dataMessage = [responseObject objectForKey:@"msg"];
                NSLog(@"%@",dataMessage);
                if (complete) {
                    complete(NO,dataMessage);
                }
                
            }
            
        }else{
            NSString* serviceMessage = [responseObject objectForKey:@"msg"];
            NSLog(@"%@",serviceMessage);
            if (complete) {
                complete(NO,serviceMessage);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        if (complete) {
            complete(NO,error.localizedDescription);
        }
    }];

    
}
@end
