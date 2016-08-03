//
//  CSRegisterViewController.m
//  CodeShare
//
//  Created by qianfeng_yujiang on 16/8/3.
//  Copyright © 2016年 qdyujiang002. All rights reserved.
//

#import "CSRegisterViewController.h"
#import <Masonry.h>
#import "UIButton+BackgroundColor.h"
#import "UIControl+ActionBlocks.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SMSSDK/SMS_SDK/SMSSDK.h>
@interface CSRegisterViewController ()

@end

@implementation CSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpViews];
}


-(void)setUpViews{
    //创建手机号码输入框，密码输入框，登录按钮
    UITextField* phonetext = [[UITextField alloc]init];
    [self.view addSubview:phonetext];
    phonetext.backgroundColor = [UIColor whiteColor];
    UITextField* password = [[UITextField alloc]init];
    [self.view addSubview:password];
    password.backgroundColor = [UIColor whiteColor];
    
    phonetext.placeholder = @"输入邮箱或者手机号码";
    password.placeholder = @"输入密码";
    
    password.secureTextEntry = YES;
    
    UIImageView* PhoneLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"手机邮箱图标"]];
    UIImageView* passLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码图标"]];
    
    UIView* phoneLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    UIView* passLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    [phoneLeft addSubview:PhoneLeftImage];
    [passLeft addSubview:passLeftImage];
    [passLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        //视图居中
        make.center.equalTo(@0);
    }];
    [PhoneLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    
    
    phonetext.leftView = phoneLeft;
    password.leftView = passLeft;
    phonetext.leftViewMode = UITextFieldViewModeAlways;
    password.leftViewMode = UITextFieldViewModeAlways;
    
    //手写输入框的布局
    //在写布局的时候，我们添加的所有约束必须能够唯一确定这个视图的位置和大小
    [phonetext mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(@0);
        //        make.right.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(@120);
        //因为 Masonry 在实现的时候，充分考虑到了我们写约束的时候越简单越好，所以引入了链式写法,我们在写的时候，可以尽量的将一样的约束写到一起.
    }];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(phonetext.mas_bottom);
    }];
    
    
    
    
    
    phonetext.font  = [UIFont systemFontOfSize:15 weight:-0.15];
    password.font = [UIFont systemFontOfSize:15 weight:-0.15];
    
    
    phonetext.layer.borderColor = [UIColor grayColor].CGColor;
    phonetext.layer.borderWidth = 0.5;
    password.layer.borderColor = [UIColor grayColor].CGColor;
    password.layer.borderWidth = 0.5;
    
    
    
    
    
    
    
    
    
    
    
    UITextField* test = [[UITextField alloc]init];
    [self.view addSubview:test];
    test.placeholder = @"输入验证码";
    test.font = [UIFont systemFontOfSize:15 weight:-0.15];
    [test mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(password.mas_bottom).offset(16);
        make.height.equalTo(@48);
    }];
    
    UIView* testLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    UIImageView* testLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证信息图标"]];
    [testLeft addSubview:testLeftImage];
    [testLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        
    }];
    
    test.layer.borderColor = [UIColor grayColor].CGColor;
    test.layer.borderWidth = 0.5;
   
    test.leftView = testLeft;

    test.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [rightButton titleLabel].font = [UIFont systemFontOfSize:14 weight:-0.15];
    [rightButton layer].borderColor = [UIColor grayColor].CGColor
    ;
    [rightButton layer].borderWidth = 1.0f;
    [rightButton layer].cornerRadius = 4.0f;
    [rightButton layer].masksToBounds = YES;
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 108, 48)];
    [rightView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(@0);
        make.top.equalTo(@8);
        make.left.equalTo(@4);
        
    }];
    password.rightView = rightView;
    password.rightViewMode = UITextFieldViewModeAlways;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
       //登录按钮
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton titleLabel].font = [UIFont systemFontOfSize:15];
    [loginButton setFrame:CGRectMake(0, 550, self.view.bounds.size.width, 64)];
    [self.view addSubview:loginButton];
    
    //如果要让按钮不同状态的时候显示不同的背景颜色
    //一般我们的按钮，都会需要三个状态下的颜色,1.普通状态 2.高亮状态 3.不可用状态
    //1.不同的状态设置不同的图片
    //我们需要做很多图片，比较麻烦,图片太多，占用很多空间
    //2.在不同状态的事件下面，设置按钮的背景颜色
    //我们需要实现很多方法，麻烦
    //3.使用封装好的分类方法，简单方便
    [loginButton setBackgroundColor:[UIColor colorWithRed:0.146 green:0.847 blue:0.048 alpha:1.000] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [loginButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    
    loginButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
   
    
    //设置用户输入框，只能输入数字
    phonetext.keyboardType = UIKeyboardTypeNumberPad;
    
    
    //ReactiveCocaa 处理
    //Reactive 可以代替delegate\target action\通知\kvo\.....一系列 iOS开发里面的数据传递方式
    //RAC使用的是信号流的方式来处理我们的数据，无论是按钮点击事件，还是输入框事件，还是网络数据获取.........都可以被当作"信号"来看待.
    //我们可以观测某个信号的改变，来做相应的操作
    // RAC 还可以将多个信号合并处理、过滤某些信号、自定义一些信号，所以比较强大.
    //RAC 帮我们实现了很多系统自带的信号，文本框的变化、按钮点击........
    //我们去订阅这些信号,那么当信号一旦发生变化，就会通知我们
    [phonetext.rac_textSignal subscribeNext:^(NSString* phone) {
        if (phone.length >= 11) {
            //当输入的手机号超过11位，直接将密码框设置为第一响应者
            [password becomeFirstResponder];
            if (phone.length > 11) {
                phonetext.text = [phone substringToIndex:11];
            }
        }
    }];
    
    //获取验证码按钮默认不可点
    rightButton.enabled = NO;
    //我们可以直接将某个信号处理的返回结果，设置为某个对象的属性值
    //RAC(rightButton,enabled) = [RACSignal combineLatest: reduce:];
    //combineLatest 一堆信号的集合
    RAC(rightButton,enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal] reduce:^(NSString* phone){
        return @(phone.length >= 11);
    }];
    
    
    //RAC可以将信号和处理写到一起，我们写项目的时候，不用再去来回找了
    loginButton.enabled = NO;
    RAC(loginButton,enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal,password.rac_textSignal,test.rac_textSignal] reduce:^(NSString* phone,NSString* pass,NSString* testT){
        return @(phone.length>=11 && pass.length>=6 && testT.length == 4);
    }];
    
       [rightButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
           //发送验证码
           [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phonetext.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
               if (error) {
                   
               }else{
                   NSLog(@"获取验证码成功");
                   
               }
               
               
           }];

    } ];
    
}


//我的需求:
//1.账号输入框，用户只可以输入数字
//2.当用户输入完11个数字，不能再继续输入
//3.当账号输入框少于11个数字，那么获取验证码按钮，设为灰色不可点
//4.当账号为11个数字，密码大于等于6个长度，验证码为4个数字，注册按钮可用

//怎么做?
//1.设置键盘样式
//2.可以在代理方法里判断，如果输入框长度大于11，返回NO.
//3.也可以在代理方法里面处理
//4.也可以在代理方法里面处理，但是非常麻烦










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
