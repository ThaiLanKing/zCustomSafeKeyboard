//
//  JBPureNumberKeyboard.m
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import "JBPureNumberKeyboard.h"
#import "JBKeyboardButton.h"

@interface JBPureNumberKeyboard ()

@property (nonatomic, strong) NSMutableArray *allNumberBtns;

@end

@implementation JBPureNumberKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JBKeyboard_Background_Color;
        
        NSArray *allNumbers = [JBBaseKeyboard randomSortedArrFromSrcArr:JBKeyboard_Numbers];
        
        _allNumberBtns = [NSMutableArray arrayWithCapacity:allNumbers.count];
        
        NSInteger btnCountPerLine = 4;
        NSInteger btnLineCount = 4;
        CGFloat btnSpace = JBKeyboard_Space_X;
        CGFloat numbweBtnW = 1.0 * (kScreenWidth - btnCountPerLine * btnSpace)/btnCountPerLine;
        CGFloat numberBtnH = ( JBKeyboard_Keyboard_Height - 2*JBKeyboard_Vertical_Inset - (btnLineCount - 1)*btnSpace )/btnLineCount;
        
        NSInteger NumPerLine = 3;
        __block JBKeyboardButton *preBtn;
        //+2是为了添加一个占位按钮，没有实际用途
        for (int i = 0; i < allNumbers.count + 2; ++i) {
            JBKeyboardButton *numberBtn = [[JBKeyboardButton alloc] init];
            //两个占位按钮分别位于最后一个数字按钮的两边
            if (i < allNumbers.count - 1) {
                NSString *number = allNumbers[i];
                [numberBtn setTitle:number forState:UIControlStateNormal];
                [_allNumberBtns addObject:numberBtn];
            }
            else if (i == allNumbers.count) {
                NSString *number = [allNumbers lastObject];
                [numberBtn setTitle:number forState:UIControlStateNormal];
                [_allNumberBtns addObject:numberBtn];
            }
            else {
                numberBtn.enabled = NO;
            }
            [self addSubview:numberBtn];
            
            [numberBtn makeConstraints:^(MASConstraintMaker *make) {
                if (i % NumPerLine == 0) {
                    if (preBtn) {
                        make.top.equalTo(preBtn.bottom).offset(btnSpace);
                    }
                    else {
                        make.top.equalTo(self).offset(JBKeyboard_Vertical_Inset);
                    }
                    make.left.equalTo(self).offset(btnSpace/2.0f);
                }
                else {
                    make.top.equalTo(preBtn);
                    make.left.equalTo(preBtn.right).offset(btnSpace);
                }
                make.width.equalTo(numbweBtnW);
                make.height.equalTo(numberBtnH);
            }];
            
            preBtn = numberBtn;
        }
        
        [self addSubview:self.deleteBtn];
        [self addSubview:self.doneBtn];
        
        [self.deleteBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(JBKeyboard_Vertical_Inset);
            make.right.equalTo(self).offset(-btnSpace/2.0f);
            make.width.equalTo(numbweBtnW);
        }];
        
        [self.doneBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.deleteBtn.bottom).offset(btnSpace);
            make.right.width.height.equalTo(self.deleteBtn);
            make.bottom.equalTo(preBtn);
        }];
        
        for (JBKeyboardButton *btn in _allNumberBtns) {
            @weakify(self);
            [btn addActionBlock:^(UIButton *sender) {
                @strongify(self);
                NSString *inputKey = sender.titleLabel.text;
                [self insertText:inputKey];
            }];
        }
    }
    return self;
}

#pragma mark - override

- (void)reloadRandomKeys
{    
    NSArray *allNumbers = [JBBaseKeyboard randomSortedArrFromSrcArr:JBKeyboard_Numbers];
    [self.allNumberBtns enumerateObjectsUsingBlock:^(JBKeyboardButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitle:allNumbers[idx] forState:UIControlStateNormal];
    }];
}

@end
