//
//  JBKeyboardLineView.m
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import "JBKeyboardLineView.h"
#import "JBBaseKeyboard.h"
#import "JBKeyboardButton.h"

@interface JBKeyboardLineView ()

@property (nonatomic, strong) NSMutableArray *keyboardBtns;

@end

@implementation JBKeyboardLineView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
                andButtonWidth:(CGFloat)btnWidth
                  buttonHeight:(CGFloat)btnHeight
{
    if (self = [self initWithFrame:CGRectNull]) {
        _keyboardBtns = [NSMutableArray arrayWithCapacity:titles.count];
        
        for (NSString *title in titles) {
            JBKeyboardButton *charBtn = [[JBKeyboardButton alloc] init];
            [charBtn setTitle:title forState:UIControlStateNormal];
            [self addSubview:charBtn];
            [_keyboardBtns addObject:charBtn];
        }
        
        [_keyboardBtns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:JBKeyboard_Space_X leadSpacing:0 tailSpacing:0];
        [_keyboardBtns makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.equalTo(btnWidth);
            make.height.equalTo(btnHeight);
        }];
    }
    return self;
}

@end
