//
//  CSForgetViewController.m
//  CodeShare
//
//  Created by qianfeng_yujiang on 16/8/3.
//  Copyright © 2016年 qdyujiang002. All rights reserved.
//

#import "CSForgetViewController.h"
#import "UIButton+BackgroundColor.h"
#import <Masonry.h>
@interface CSForgetViewController ()

@end

@implementation CSForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"重置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setUpViews];
    
    
    
}



-(void)setUpViews{
    UITextField* phoneText = [[UITextField alloc]init];
    [self.view addSubview:phoneText];
    phoneText.placeholder = @"输入邮箱或者手机密码";
    phoneText.font = [UIFont systemFontOfSize:15 weight:-0.15];
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@64);
        make.height.equalTo(@48);
    }];
    
    UIView* phoneLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 48, 48)];
    UIImageView* phoneLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"手机邮箱图标"]];
    [phoneLeft addSubview:phoneLeftImage];
    [phoneLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        
    }];
    
    
    
    
    
    
    UITextField* password = [[UITextField alloc]init];
    [self.view addSubview:password];
    password.placeholder = @"输入验证码";
    password.font = [UIFont systemFontOfSize:15 weight:-0.15];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(phoneText.mas_bottom);
        make.height.equalTo(@48);
    }];
    
    UIView* passLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 48, 48)];
    UIImageView* passLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证信息图标"]];
    [passLeft addSubview:passLeftImage];
    [passLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        
    }];
    
    
    phoneText.leftView = phoneLeft;
    password.leftView = passLeft;
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    password.leftViewMode = UITextFieldViewModeAlways;
    
    
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
