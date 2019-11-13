//
//  JBCharsAndSymbolsKeyboard.m
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import "JBCharsAndSymbolsKeyboard.h"
#import "JBCharsKeyboard.h"
#import "JBSymbolsKeyboard.h"
#import "JBKeyboardButton.h"

@interface JBCharsAndSymbolsKeyboard ()
{
    //是否是符号键盘
    BOOL _isSymbolKeyboard;
}

@property (nonatomic, strong) JBCharsKeyboard *charsKeyboard;
@property (nonatomic, strong) JBSymbolsKeyboard *symbolsKeyboard;

@property (nonatomic, strong) JBKeyboardButton *switchKeyboardBtn;
@property (nonatomic, strong) JBKeyboardButton *spaceBtn;

@end

@implementation JBCharsAndSymbolsKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JBKeyboard_Background_Color;
        
        [self addSubview:self.symbolsKeyboard];
        [self addSubview:self.charsKeyboard];
        
        [self addSubview:self.deleteBtn];
        [self addSubview:self.switchKeyboardBtn];
        [self addSubview:self.spaceBtn];
        [self addSubview:self.doneBtn];
        
        [self.symbolsKeyboard makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(JBKeyboard_Vertical_Inset);
            make.left.right.equalTo(self);
        }];
        
        [self.charsKeyboard makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.symbolsKeyboard);
        }];
        
        CGFloat lineHeight = [JBBaseKeyboard buttonLineHeight];
        //左右边距
        CGFloat sideOffset = JBKeyboard_Space_X/2.0f;
        [self.deleteBtn makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(lineHeight);
            make.right.equalTo(self).offset(-sideOffset);
            make.bottom.equalTo(self.charsKeyboard);
        }];
        
        [self.switchKeyboardBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.charsKeyboard.bottom).offset(JBKeyboard_Space_Y);
            make.left.equalTo(self).offset(sideOffset);
            make.width.height.equalTo(lineHeight);
        }];
        
        [self.spaceBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.switchKeyboardBtn);
            make.left.equalTo(self.switchKeyboardBtn.right).offset(JBKeyboard_Space_X);
        }];
        
        CGFloat doneBtnW = [JBBaseKeyboard smallButtonWidth] + JBKeyboard_Space_X + lineHeight;
        [self.doneBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.spaceBtn);
            make.left.equalTo(self.spaceBtn.right).offset(JBKeyboard_Space_X);
            make.right.equalTo(self.deleteBtn);
            make.width.equalTo(doneBtnW);
        }];
    }
    return self;
}

#pragma mark -

- (JBCharsKeyboard *)charsKeyboard
{
    if (!_charsKeyboard) {
        _charsKeyboard = [[JBCharsKeyboard alloc] init];
        for (JBKeyboardButton *btn in _charsKeyboard.allCharBtns) {
            @weakify(self);
            [btn addActionBlock:^(UIButton *sender) {
                @strongify(self);
                NSString *inputKey = sender.titleLabel.text;
                [self insertText:inputKey];
            }];
        }
    }
    return _charsKeyboard;
}

- (JBSymbolsKeyboard *)symbolsKeyboard
{
    if (!_symbolsKeyboard) {
        _symbolsKeyboard = [[JBSymbolsKeyboard alloc] init];
        for (JBKeyboardButton *btn in _symbolsKeyboard.allSymbolBtns) {
            @weakify(self);
            [btn addActionBlock:^(UIButton *sender) {
                @strongify(self);
                NSString *inputKey = sender.titleLabel.text;
                [self insertText:inputKey];
            }];
        }
    }
    return _symbolsKeyboard;
}

- (JBKeyboardButton *)switchKeyboardBtn
{
    if (!_switchKeyboardBtn) {
        _switchKeyboardBtn = [[JBKeyboardButton alloc] init];
        [_switchKeyboardBtn setTitle:@"123" forState:UIControlStateNormal];
        @weakify(self);
        [_switchKeyboardBtn addActionBlock:^(UIButton *sender) {
            @strongify(self);
            [self switchKeyboard];
        }];
    }
    return _switchKeyboardBtn;
}

- (JBKeyboardButton *)spaceBtn
{
    if (!_spaceBtn) {
        _spaceBtn = [[JBKeyboardButton alloc] init];
        _spaceBtn.backgroundColor = [UIColor whiteColor];
        [_spaceBtn setTitle:@"空格" forState:UIControlStateNormal];
        @weakify(self);
        [_spaceBtn addActionBlock:^(UIButton *sender) {
            @strongify(self);
            [self insertText:@" "];
        }];
    }
    return _spaceBtn;
}

#pragma mark -

- (void)switchKeyboard
{
    _isSymbolKeyboard = !_isSymbolKeyboard;
    
    NSString *switchBtnTitle = _isSymbolKeyboard ? @"ABC" : @"123";
    [self.switchKeyboardBtn setTitle:switchBtnTitle forState:UIControlStateNormal];
    
    self.symbolsKeyboard.hidden = !_isSymbolKeyboard;
    self.charsKeyboard.hidden = _isSymbolKeyboard;
}

#pragma mark - override

- (void)reloadRandomKeys
{
    [self.charsKeyboard reloadRandomKeys];
    [self.symbolsKeyboard reloadRandomKeys];
}

@end
