//
//  JBCustomSafeKeyboard.h
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JBSafeKeyboardType) {
    JBSafeKeyboardTypeDefault,
    JBSafeKeyboardTypeCharsAndSymbols,
    JBSafeKeyboardTypePureNumber,
};

NS_ASSUME_NONNULL_BEGIN

@interface JBCustomSafeKeyboard : UIView

- (instancetype)initWithKeyBoardType:(JBSafeKeyboardType)keyboardType
                andContainerTxtField:(UITextField *)containerTxtField;

@end

NS_ASSUME_NONNULL_END
