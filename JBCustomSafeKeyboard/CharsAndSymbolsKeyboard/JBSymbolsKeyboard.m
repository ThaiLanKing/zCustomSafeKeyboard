//
//  JBSymbolsKeyboard.m
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import "JBSymbolsKeyboard.h"
#import "JBKeyboardLineView.h"
#import "JBKeyboardButton.h"
#import "JBBaseKeyboard.h"

@interface JBSymbolsKeyboard ()
{
    //是否显示更多符号
    BOOL _isMoreSymbols;
}

@property (nonatomic, strong) JBKeyboardLineView *firstLineView;
@property (nonatomic, strong) JBKeyboardLineView *secondLineView;

@property (nonatomic, strong) JBKeyboardButton *moreSymbolsBtn;

@property (nonatomic, strong) NSMutableArray *allSymbolBtns;

@end

@implementation JBSymbolsKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JBKeyboard_Background_Color;
        
        NSArray *numbers = [JBBaseKeyboard randomSortedArrFromSrcArr:JBKeyboard_Numbers];
        NSArray *firstLineSymbols = JBKeyboard_Symbols[0];
        NSArray *secondLineSymBols = JBKeyboard_Symbols[1];
        
        CGFloat btnW = [JBBaseKeyboard smallButtonWidth];
        CGFloat btnH = [JBBaseKeyboard buttonLineHeight];
        JBKeyboardLineView *firstLineView = ({
            JBKeyboardLineView *tempView = [[JBKeyboardLineView alloc] initWithTitles:numbers
                                                                       andButtonWidth:btnW
                                                                         buttonHeight:btnH];
            tempView;
        });
        [self addSubview:firstLineView];
        
        JBKeyboardLineView *secondLineView = ({
            JBKeyboardLineView *tempView = [[JBKeyboardLineView alloc] initWithTitles:firstLineSymbols
                                                                       andButtonWidth:btnW
                                                                         buttonHeight:btnH];
            tempView;
        });
        [self addSubview:secondLineView];
        
        JBKeyboardLineView *thirdLineView = ({
            JBKeyboardLineView *tempView = [[JBKeyboardLineView alloc] initWithTitles:secondLineSymBols
                                                                       andButtonWidth:btnH
                                                                         buttonHeight:btnH];
            tempView;
        });
        [self addSubview:thirdLineView];
        
        [self addSubview:self.moreSymbolsBtn];
        
        [firstLineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self);
            make.height.equalTo(btnH);
        }];
        
        [secondLineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstLineView.bottom).offset(JBKeyboard_Space_Y);
            make.centerX.equalTo(self);
            make.height.equalTo(firstLineView);
        }];
        
        [thirdLineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(secondLineView.bottom).offset(JBKeyboard_Space_Y);
            make.centerX.equalTo(self);
            make.height.equalTo(firstLineView);
        }];
        
        [self.moreSymbolsBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(thirdLineView);
            make.left.equalTo(firstLineView);
            make.width.height.equalTo(btnH);
            make.bottom.equalTo(self);
        }];
        
        _firstLineView = firstLineView;
        _secondLineView = secondLineView;
        
        _allSymbolBtns = [NSMutableArray arrayWithCapacity:0];
        [_allSymbolBtns addObjectsFromArray:firstLineView.keyboardBtns];
        [_allSymbolBtns addObjectsFromArray:secondLineView.keyboardBtns];
        [_allSymbolBtns addObjectsFromArray:thirdLineView.keyboardBtns];
    }
    return self;
}

#pragma mark -

- (JBKeyboardButton *)moreSymbolsBtn
{
    if (!_moreSymbolsBtn) {
        _moreSymbolsBtn = [[JBKeyboardButton alloc] init];
        [_moreSymbolsBtn setTitle:@"$<¥" forState:UIControlStateNormal];
        @weakify(self);
        [_moreSymbolsBtn addActionBlock:^(UIButton *sender) {
            @strongify(self);
            [self switchMoreSymbols];
        }];
    }
    return _moreSymbolsBtn;
}

- (void)switchMoreSymbols
{
    _isMoreSymbols = !_isMoreSymbols;
    NSString *moreSymbolBtnTitle = _isMoreSymbols ? @"123" : @"$<¥";
    [self.moreSymbolsBtn setTitle:moreSymbolBtnTitle forState:UIControlStateNormal];
    
    NSArray *newFirstLineTitles, *newSecondLineTitles;
    if (_isMoreSymbols) {
        newFirstLineTitles = JBKeyboard_Symbols[2];
        newSecondLineTitles = JBKeyboard_Symbols[3];
    }
    else {
        newFirstLineTitles = [JBBaseKeyboard randomSortedArrFromSrcArr:JBKeyboard_Numbers];;
        newSecondLineTitles = JBKeyboard_Symbols[0];
    }
    
    [_firstLineView.keyboardBtns enumerateObjectsUsingBlock:^(JBKeyboardButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *btnTitle = newFirstLineTitles[idx];
        [obj setTitle:btnTitle forState:UIControlStateNormal];
    }];
    
    [_secondLineView.keyboardBtns enumerateObjectsUsingBlock:^(JBKeyboardButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *btnTitle = newSecondLineTitles[idx];
        [obj setTitle:btnTitle forState:UIControlStateNormal];
    }];
}

#pragma mark -

- (void)reloadRandomKeys
{
    if (_isMoreSymbols) {
        return;
    }
    NSArray *numbers = JBKeyboard_Numbers;
    if (self.safeKeyboard) {
        numbers = [JBBaseKeyboard randomSortedArrFromSrcArr:numbers];
    }
    [self.firstLineView.keyboardBtns enumerateObjectsUsingBlock:^(JBKeyboardButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitle:numbers[idx] forState:UIControlStateNormal];
    }];
}

@end
