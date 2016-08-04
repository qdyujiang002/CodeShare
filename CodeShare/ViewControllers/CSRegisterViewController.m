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
#import "NSTimer+Blocks.h"
#import "NSTimer+Addition.h"
#import "NSString+MD5.h"
#import "UIAlertView+Block.h"
@interface CSRegisterViewController ()

//写成属性可以方便的监控变化
@property(nonatomic,strong)NSNumber* waitTime;
@property(nonatomic,strong)NSTimer * timer;

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
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
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
    
    
    //ReactiveCocoa 处理
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
    
    //我们给等待时间赋初始值
    self.waitTime = @-1;
    //获取验证码按钮默认不可点
    rightButton.enabled = NO;
    //我们可以直接将某个信号处理的返回结果，设置为某个对象的属性值
    //RAC(rightButton,enabled) = [RACSignal combineLatest: reduce:];
    //combineLatest 一堆信号的集合
    RAC(rightButton,enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal,RACObserve(self, waitTime)] reduce:^(NSString* phone, NSNumber* waitTime1){
      
        return @(phone.length >= 11 && waitTime1.integerValue<=0);
    }];
    
    
    //RAC可以将信号和处理写到一起，我们写项目的时候，不用再去来回找了
    loginButton.enabled = NO;
    RAC(loginButton,enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal,password.rac_textSignal,test.rac_textSignal] reduce:^(NSString* phone,NSString* pass,NSString* testT){
        return @(phone.length>=11 && pass.length>=6 && testT.length == 4);
    }];
    
    
    //如果在实际开发环境中，我们在做发送验证码的功能时，都会有一个等待时间
    //1.为了节省成本
    //一般开发中用第三方短信提供商，做发送验证码功能，一条/6-8分钱,所以成本还是挺高的.
    //2.为了用户体验
       [rightButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
           //直接进入读秒
           self.waitTime = @60;
           //发送验证码
           [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phonetext.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
               if (error) {
                   //如果失败，让等待时间变为-1
                   self.waitTime = @-1;
                   
               }else{
                   NSLog(@"获取验证码成功");
                   self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^{
                      
                           self.waitTime = [NSNumber numberWithInteger:self.waitTime.integerValue - 1];
                       
                       
                       
                   } repeats:YES];
               }
               
               
           }];

    }];
    
    //用RAC监控数据的变化，显示响应的界面
    [RACObserve(self, waitTime)  subscribeNext:^(NSNumber* waitTime2) {
        
        if (waitTime2.integerValue <= 0) {
            //将定时器去除的操作写到这里也可以
            [self.timer invalidate];
            self.timer = nil;
            [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        }else if(waitTime2.integerValue > 0){
            [rightButton setTitle:[NSString stringWithFormat:@"等待%@秒",waitTime2] forState:UIControlStateNormal];
            
        }
    }];
    
    [[loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //一般我们的密码不可能明文传输，最简单的也要进行md5加密
        //一旦进行md5加密，会破坏字符串原来携带的信息
        //但是，对于密码来说，服务器和app交互并不需要知道密码所携带的信息，所以无论是登录还是注册，我们都必须加密(服务器也不知道你的密码是多少)
        //MD5 加密算法是死的,所以别人可以通过暴力破解的方式来获取你的密码
        //所以我们有时候，会将我们的密码加盐后再进行加密，传给服务器
        //固定字符串的盐@"ABCDEF"
        //随机字符串的盐
        NSString* pass = [password.text md532BitUpper];
        
        NSDictionary* paraDic = @{
                                  @"service":@"User.Register",
                                  @"phone":phonetext.text,
                                  @"password":pass,
                                  @"verificationCode":test.text
                                  };
        
        [NetWorkTool getDataWithParameters:paraDic completeBlock:^(BOOL success, id result) {
            if (success) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }else{
                [UIAlertView alertWithCallBackBlock:nil title:@"温馨提示" message:result cancelButtonName:@"确定" otherButtonTitles:nil, nil];
            }
        }];
        
    }];
    
    
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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



//需求:
//1.点击发送验证码，按钮变为不可用，发送验证码
//2.如果发送成功，按钮不可用，按钮上面显示60秒倒计时
//3.如果失败，将按钮设置为可用，提示发送失败
//4.当倒计时结束的时候，将按钮设置为可用（还要同时考虑到手机号码是否符合规则）

//我们可以设置一个初始数字为60的变量，发送验证码的按钮可用与否再添加一个条件，当0-60的时候，按钮不可用，我们的定时器每走一次，将这个数字减去1，同时监控这个数字的变化，去改变我们的按钮倒计时提示








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
