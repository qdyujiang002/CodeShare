//
//  CSUserModel.h
//  CodeShare
//
//  Created by qianfeng_yujiang on 16/8/3.
//  Copyright © 2016年 qdyujiang002. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSUserModel : NSObject

//我们通常都将用户当作一个Model来看待，那么用户是否登录就需要我们封装一个方法，因为在我们的程序整个生命周期内，很可能只会创建一个用户对象，所以我们用类方法判断就可以了.
+(BOOL)isLogin;


@end
