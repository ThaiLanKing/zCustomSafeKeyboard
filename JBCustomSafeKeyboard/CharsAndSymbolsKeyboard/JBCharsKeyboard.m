//
//  JBCharsKeyboard.m
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import "JBCharsKeyboard.h"
#import "JBKeyboardLineView.h"
#import "JBKeyboardButton.h"
#import "JBBaseKeyboard.h"

@interface JBCharsKeyboard ()
{
    //是否是大写状态
    BOOL _isUpperCase;
    //大小写按钮的图标
    UIImageView *_upperCaseImgView;
}
@property (nonatomic, strong) JBKeyboardButton *upcaseBtn;
@property (nonatomic, strong) NSMutableArray *allCharBtns;

@end

@implementation JBCharsKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = JBKeyboard_Background_Color;
        
        NSInteger firstLineCharsCount = 10;
        NSInteger secondLineCharsCount = 9;
        NSInteger thirdLineCharsCount = 7;
        
        NSArray *allChars = [JBBaseKeyboard randomSortedArrFromSrcArr:JBKeyboard_Chars];
        
        CGFloat btnW = [JBBaseKeyboard smallButtonWidth];
        CGFloat btnH = [JBBaseKeyboard buttonLineHeight];
        JBKeyboardLineView *firstLineView = ({
            NSInteger firstCharLocation = 0;
            NSInteger charsLength = firstLineCharsCount;
            NSArray *lineChars = [allChars subarrayWithRange:NSMakeRange(firstCharLocation, charsLength)];
            JBKeyboardLineView *tempView = [[JBKeyboardLineView alloc] initWithTitles:lineChars
                                                                       andButtonWidth:btnW
                                                                         buttonHeight:btnH];
            tempView;
        });
        [self addSubview:firstLineView];
        
        JBKeyboardLineView *secondLineView = ({
            NSInteger firstCharLocation = firstLineCharsCount;
            NSInteger charsLength = secondLineCharsCount;
            NSArray *lineChars = [allChars subarrayWithRange:NSMakeRange(firstCharLocation, charsLength)];
            JBKeyboardLineView *tempView = [[JBKeyboardLineView alloc] initWithTitles:lineChars
                                                                       andButtonWidth:btnW
                                                                         buttonHeight:btnH];
            tempView;
        });
        [self addSubview:secondLineView];
        
        JBKeyboardLineView *thirdLineView = ({
            NSInteger firstCharLocation = firstLineCharsCount + secondLineCharsCount;
            NSInteger charsLength = thirdLineCharsCount;
            NSArray *lineChars = [allChars subarrayWithRange:NSMakeRange(firstCharLocation, charsLength)];
            JBKeyboardLineView *tempView = [[JBKeyboardLineView alloc] initWithTitles:lineChars
                                                                       andButtonWidth:btnW
                                                                         buttonHeight:btnH];
            tempView;
        });
        [self addSubview:thirdLineView];
        
        [self addSubview:self.upcaseBtn];
        
        [firstLineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self);
            make.height.equalTo(btnH);
        }];
        
        [secondLineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstLineView.bottom).offset(JBKeyboard_Space_Y);
            make.centerX.equalTo(self);
            make.height.equalTo(firstLineView);
        }];
        
        [thirdLineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(secondLineView.bottom).offset(JBKeyboard_Space_Y);
            make.centerX.equalTo(self);
            make.height.equalTo(firstLineView);
        }];
        
        [self.upcaseBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(thirdLineView);
            make.left.equalTo(firstLineView);
            make.width.equalTo(btnH);
            make.bottom.equalTo(self);
        }];
        
        _allCharBtns = [NSMutableArray arrayWithCapacity:0];
        [_allCharBtns addObjectsFromArray:firstLineView.keyboardBtns];
        [_allCharBtns addObjectsFromArray:secondLineView.keyboardBtns];
        [_allCharBtns addObjectsFromArray:thirdLineView.keyboardBtns];
    }
    return self;
}

#pragma mark -

- (JBKeyboardButton *)upcaseBtn
{
    if (!_upcaseBtn) {
        _upcaseBtn = [[JBKeyboardButton alloc] init];
        
        _upperCaseImgView = [UIImageView new];
        _upperCaseImgView.image = [UIImage imageNamed:@"keyboard_lowerCase"];
        [_upcaseBtn addSubview:_upperCaseImgView];
        
        CGFloat btnHeight = [JBBaseKeyboard buttonLineHeight];
        [_upperCaseImgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(btnHeight * 5/8);
            make.center.equalTo(self.upcaseBtn);
        }];
        
        @weakify(self);
        [_upcaseBtn addActionBlock:^(UIButton *sender) {
            @strongify(self);
            [self switchCharCase];
        }];
    }
    return _upcaseBtn;
}

- (void)switchCharCase
{
    _isUpperCase = !_isUpperCase;
    NSString *caseImgName = _isUpperCase ? @"keyboard_upperCase" : @"keyboard_lowerCase";
    _upperCaseImgView.image = [UIImage imageNamed:caseImgName];
    
    for (UIButton *charBtn in self.allCharBtns) {
        NSString *character = [charBtn titleForState:UIControlStateNormal];
        if (_isUpperCase) {
            character = [character uppercaseString];
        }
        else {
            character = [character lowercaseString];
        }
        [charBtn setTitle:character forState:UIControlStateNormal];
    }
}

#pragma mark -

- (void)reloadRandomKeys
{
    NSArray *allChars = [JBBaseKeyboard randomSortedArrFromSrcArr:JBKeyboard_Chars];
    [self.allCharBtns enumerateObjectsUsingBlock:^(JBKeyboardButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitle:allChars[idx] forState:UIControlStateNormal];
    }];
}

@end
