//
//  UITextField+zSafeKeyboard.m
//  zCustomSafeKeyboard
//
//  Created by ZhangYaoHua on 2019/11/8.
//  Copyright © 2019 ZYH. All rights reserved.
//

#import "UITextField+zSafeKeyboard.h"
#import "JBCustomSafeKeyboard.h"

@implementation UITextField (zSafeKeyboard)

- (void)setJBCharsAndSymbolsKeyboard:(BOOL)safe
{
    JBCustomSafeKeyboard *keyboard = [[JBCustomSafeKeyboard alloc] initWithKeyBoardType:JBSafeKeyboardTypeCharsAndSymbols andContainerTxtField:self];
    self.inputView = keyboard;
}

- (void)setJBPureNumbersKeyboard:(BOOL)safe
{
    JBCustomSafeKeyboard *keyboard = [[JBCustomSafeKeyboard alloc] initWithKeyBoardType:JBSafeKeyboardTypePureNumber andContainerTxtField:self];
    self.inputView = keyboard;
}

@end
