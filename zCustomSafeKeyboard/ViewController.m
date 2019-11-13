//
//  ViewController.m
//  zCustomSafeKeyboard
//
//  Created by ZhangYaoHua on 2019/11/8.
//  Copyright © 2019 ZYH. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+zSafeKeyboard.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *charsAndSymbolsTxtField;
@property (nonatomic, strong) UITextField *pureNumberTxtField;

@property (nonatomic, strong) UISwitch *safeKeyboardSwitcher;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义安全键盘";
    
    [self initView];
}

- (void)initView
{
    {
        UILabel *titleLbl = [[UILabel alloc] init];
        titleLbl.font = FontWithSize(16);
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.text = @"字母字符键盘";
        [self.view addSubview:titleLbl];
        
        _charsAndSymbolsTxtField = [[UITextField alloc] init];
        _charsAndSymbolsTxtField.borderStyle = UITextBorderStyleRoundedRect;
        [_charsAndSymbolsTxtField setJBCharsAndSymbolsKeyboard:NO];
        [self.view addSubview:_charsAndSymbolsTxtField];
        
        [titleLbl makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(60);
            make.left.equalTo(self.view).offset(30);
            make.height.equalTo(50);
            make.width.equalTo(100);
        }];
        
        [_charsAndSymbolsTxtField makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLbl);
            make.left.equalTo(titleLbl.right).offset(20);
            make.right.equalTo(self.view).offset(-30);
            make.height.equalTo(50);
        }];
    }
    
    {
        UILabel *titleLbl = [[UILabel alloc] init];
        titleLbl.font = FontWithSize(16);
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.text = @"纯数字键盘";
        [self.view addSubview:titleLbl];
        
        _pureNumberTxtField = [[UITextField alloc] init];
        _pureNumberTxtField.borderStyle = UITextBorderStyleRoundedRect;
        [_pureNumberTxtField setJBPureNumbersKeyboard:NO];
        [self.view addSubview:_pureNumberTxtField];
        
        [titleLbl makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.charsAndSymbolsTxtField.bottom).offset(30);
            make.left.equalTo(self.view).offset(30);
            make.height.equalTo(50);
            make.width.equalTo(100);
        }];
        
        [_pureNumberTxtField makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLbl);
            make.left.equalTo(titleLbl.right).offset(20);
            make.right.equalTo(self.view).offset(-30);
            make.height.equalTo(50);
        }];
    }
    
    {
        UILabel *titleLbl = [[UILabel alloc] init];
        titleLbl.font = FontWithSize(16);
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.text = @"安全键盘";
        [self.view addSubview:titleLbl];
        
        _safeKeyboardSwitcher = [[UISwitch alloc] init];
        [_safeKeyboardSwitcher addTarget:self action:@selector(switchToSafeKeyboard:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_safeKeyboardSwitcher];
        
        [titleLbl makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pureNumberTxtField.bottom).offset(30);
            make.left.equalTo(self.view).offset(30);
            make.height.equalTo(60);
            make.width.equalTo(100);
        }];
        
        [_safeKeyboardSwitcher makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLbl);
            make.left.equalTo(titleLbl.right).offset(20);
        }];
    }
}

- (void)switchToSafeKeyboard:(UISwitch *)sender
{
    BOOL safeKeyboard = sender.isOn;
    [self.charsAndSymbolsTxtField setJBCharsAndSymbolsKeyboard:safeKeyboard];
    [self.pureNumberTxtField setJBPureNumbersKeyboard:safeKeyboard];
}

@end
