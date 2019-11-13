//
//  JBBaseKeyboard.h
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBKeyboardButton.h"

#define JBKeyboard_Chars (@[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",   \
                            @"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",        \
                            @"z",@"x",@"c",@"v",@"b",@"n",@"m"])

#define JBKeyboard_Symbols (@[                                     \
        @[@"~",@"+",@"-",@"*",@"/",@"=",@"#",@"%",@"^",@"&"],      \
        @[@".",@"@",@"?",@"!",@"_"],                               \
        @[@"\\",@"|",@"[",@"]",@"{",@"}",@"(",@")",@"<",@">"],     \
        @[@":",@",",@";",@"\"",@"'",@"¥",@"$",@"€",@"£",@"•"]      \
        ])

#define JBKeyboard_Numbers (@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"])

// 键盘按钮横向间距
#define JBKeyboard_Space_X (6.0f)

// 键盘按键纵向间距
#define JBKeyboard_Space_Y (10.0f)

// 键盘高度
#define JBKeyboard_Keyboard_Height (226.0f)

#define JBKeyboard_Background_Color Color(@"d1d6dc")

// 整个键盘在垂直方向上的留白
#define JBKeyboard_Vertical_Inset (5.0f)

NS_ASSUME_NONNULL_BEGIN

@interface JBBaseKeyboard : UIView

//使用这个键盘的txtField
@property (nonatomic, weak) UITextField *containerTxtField;

@property (nonatomic, strong, readonly) JBKeyboardButton *deleteBtn;
@property (nonatomic, strong, readonly) JBKeyboardButton *doneBtn;

+ (CGFloat)smallButtonWidth;

+ (CGFloat)buttonLineHeight;

- (void)insertText:(NSString *)text;

- (void)reloadRandomKeys;

+ (NSArray *)randomSortedArrFromSrcArr:(NSArray *)srcArr;

@end

NS_ASSUME_NONNULL_END
