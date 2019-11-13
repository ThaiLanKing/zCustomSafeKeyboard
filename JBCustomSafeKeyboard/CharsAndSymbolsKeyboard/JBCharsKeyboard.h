//
//  JBCharsKeyboard.h
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBKeyboardButton;

NS_ASSUME_NONNULL_BEGIN

@interface JBCharsKeyboard : UIView

@property (nonatomic, strong, readonly) NSArray<JBKeyboardButton *> *allCharBtns;

- (void)reloadRandomKeys;

@end

NS_ASSUME_NONNULL_END
