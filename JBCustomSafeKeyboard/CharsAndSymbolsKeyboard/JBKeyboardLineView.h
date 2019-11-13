//
//  JBKeyboardLineView.h
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBKeyboardButton;

NS_ASSUME_NONNULL_BEGIN

@interface JBKeyboardLineView : UIView

@property (nonatomic, strong, readonly) NSArray<JBKeyboardButton *> *keyboardBtns;

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
                andButtonWidth:(CGFloat)btnWidth
                  buttonHeight:(CGFloat)btnHeight;

@end

NS_ASSUME_NONNULL_END
