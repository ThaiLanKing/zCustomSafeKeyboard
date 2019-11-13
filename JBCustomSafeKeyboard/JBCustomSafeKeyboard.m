//
//  JBCustomSafeKeyboard.m
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import "JBCustomSafeKeyboard.h"
#import "JBCharsAndSymbolsKeyboard.h"
#import "JBPureNumberKeyboard.h"


#define zIsiPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define zBottomAreaHeightForiPhoneX 34

@interface JBCustomSafeKeyboard ()

@property (nonatomic, strong) JBCharsAndSymbolsKeyboard *charsAndSymbolsKeyboard;
@property (nonatomic, strong) JBPureNumberKeyboard *pureNumberKeyboard;

@end

@implementation JBCustomSafeKeyboard

- (instancetype)initWithKeyBoardType:(JBSafeKeyboardType)keyboardType
                andContainerTxtField:(UITextField *)containerTxtField
{
    CGFloat viewHeight = JBKeyboard_Keyboard_Height;
    if (zIsiPhoneX) {
        viewHeight += zBottomAreaHeightForiPhoneX;
    }
    if (self = [self initWithFrame:CGRectMake(0, 0, kScreenWidth, viewHeight)]) {
        if (JBSafeKeyboardTypePureNumber == keyboardType) {
            [self addSubview:self.pureNumberKeyboard];
            self.pureNumberKeyboard.containerTxtField = containerTxtField;
            
            [self.pureNumberKeyboard makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
        else {
            [self addSubview:self.charsAndSymbolsKeyboard];
            self.charsAndSymbolsKeyboard.containerTxtField = containerTxtField;
            
            [self.charsAndSymbolsKeyboard makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
    }
    return self;
}

#pragma mark -

- (JBCharsAndSymbolsKeyboard *)charsAndSymbolsKeyboard
{
    if (!_charsAndSymbolsKeyboard) {
        _charsAndSymbolsKeyboard = [[JBCharsAndSymbolsKeyboard alloc] init];
    }
    return _charsAndSymbolsKeyboard;
}

- (JBPureNumberKeyboard *)pureNumberKeyboard
{
    if (!_pureNumberKeyboard) {
        _pureNumberKeyboard = [[JBPureNumberKeyboard alloc] init];
    }
    return _pureNumberKeyboard;
}

@end
