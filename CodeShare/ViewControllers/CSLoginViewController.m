//
//  CSLoginViewController.m
//  CodeShare
//
//  Created by qianfeng_yujiang on 16/8/3.
//  Copyright © 2016年 qdyujiang002. All rights reserved.
//

#import "CSLoginViewController.h"
#import <Masonry.h>
//这个里面封装了一个方法，可以通过一个颜色，生成一张纯色的图片
#import "UIImage+Color.h"
#import "UIButton+BackgroundColor.h"
#import "UIControl+ActionBlocks.h"
#import "CSForgetViewController.h"
#import "CSRegisterViewController.h"

@interface CSLoginViewController ()

@end

@implementation CSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.907 alpha:1.000];
    self.title = @"登录";
    
    //一般创建ui都会写到viewDidLoad
    //viewDidLoad 是控制器的视图已经加载完毕的时候会自动调用的一个方法.
    [self setUpViews];
}

//界面将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
//界面已经出现
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
//界面将要消失
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
//界面已经消失
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
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
    
    UIImageView* PhoneLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户图标"]];
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
    
    
    //写自定义button，一定要用这个工厂方法
    UIButton *forgetPass = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPass titleLabel].font = [UIFont systemFontOfSize:14];
    // 80 64
    //我们用 autoLayout时候，就不能再以某个视图的frame当作参数来用(此时视图的frame时不可靠的)
    [forgetPass setFrame:CGRectMake(self.view.bounds.size.width-80, 250, 80, 64)];
    [self.view addSubview:forgetPass];
    //登录按钮
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton titleLabel].font = [UIFont systemFontOfSize:15];
    [loginButton setFrame:CGRectMake(0, 320, self.view.bounds.size.width, 64)];
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
    
    
    //当我们不用 autoLayout的时候,如何去让视图自适应
    //autoResizing是autoLayout之前的界面自适应工具，只有几个枚举
    /*
     typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
     UIViewAutoresizingNone                 = 0,
     UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
     UIViewAutoresizingFlexibleWidth        = 1 << 1,
     UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
     UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
     UIViewAutoresizingFlexibleHeight       = 1 << 4,
     UIViewAutoresizingFlexibleBottomMargin = 1 << 5
     };
     */
    //让登录按钮的宽度和左边距保持跟父空间相对位置不变
    loginButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin;
    [forgetPass setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
//    [forgetPass addTarget:self action:@selector(goToForget) forControlEvents:UIControlEventTouchUpInside];
    //我们可以将按钮的事件与按钮的事件写到一块
    //1.
    [forgetPass handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
      //把按钮的事件回调，写到block里，便于我们在写界面的时候方便的加入控制事件
        CSForgetViewController* forgetVC = [[CSForgetViewController alloc]init];
        [self.navigationController pushViewController:forgetVC animated:YES];
    }];
    
    //这里就用系统自带的 barButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(gotoRegister)];
    
    
    
    
    
}


-(void)gotoRegister{

    CSRegisterViewController* registerVC = [[CSRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}







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
