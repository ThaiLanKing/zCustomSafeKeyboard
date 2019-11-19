//
//  UITextField+zSafeKeyboard.m
//  zCustomSafeKeyboard
//
//  Created by ZhangYaoHua on 2019/11/8.
//  Copyright © 2019 ZYH. All rights reserved.
//

#import "UITextField+zSafeKeyboard.h"
#import "JBCharsAndSymbolsKeyboard.h"
#import "JBPureNumberKeyboard.h"

@implementation UITextField (zSafeKeyboard)

- (void)setJBCharsAndSymbolsKeyboard:(BOOL)safe
{
    JBCharsAndSymbolsKeyboard *keyboard = [[JBCharsAndSymbolsKeyboard alloc] init];
    keyboard.containerTxtField = self;
    keyboard.safeKeyboard = safe;
    self.inputView = keyboard;
}

- (void)setJBPureNumbersKeyboard:(BOOL)safe
{
    JBPureNumberKeyboard *keyboard = [[JBPureNumberKeyboard alloc] init];
    keyboard.containerTxtField = self;
    keyboard.safeKeyboard = safe;
    self.inputView = keyboard;
}

@end
