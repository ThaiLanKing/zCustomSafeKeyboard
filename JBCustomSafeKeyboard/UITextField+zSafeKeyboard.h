//
//  UITextField+zSafeKeyboard.h
//  zCustomSafeKeyboard
//
//  Created by ZhangYaoHua on 2019/11/8.
//  Copyright © 2019 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (zSafeKeyboard)

- (void)setJBCharsAndSymbolsKeyboard:(BOOL)safe;
- (void)setJBPureNumbersKeyboard:(BOOL)safe;

@end

NS_ASSUME_NONNULL_END
