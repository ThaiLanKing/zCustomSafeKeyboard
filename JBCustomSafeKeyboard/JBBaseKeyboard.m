//
//  JBBaseKeyboard.m
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import "JBBaseKeyboard.h"

#define zIsiPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define zBottomAreaHeightForiPhoneX 34

@interface JBBaseKeyboard ()

@property (nonatomic, strong) JBKeyboardButton *deleteBtn;
@property (nonatomic, strong) JBKeyboardButton *doneBtn;

@end

@implementation JBBaseKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    CGFloat viewHeight = JBKeyboard_Keyboard_Height;
    if (zIsiPhoneX) {
        viewHeight += zBottomAreaHeightForiPhoneX;
    }
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, viewHeight)]) {
    
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textFieldBeginEditing:(NSNotification *)notification
{
    if (![self.containerTxtField isFirstResponder]) {
        return;
    }
    
    [self reloadRandomKeys];
}

#pragma mark -

- (JBKeyboardButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [[JBKeyboardButton alloc] init];
        
        UIImageView *iconImgView = [UIImageView new];
        iconImgView.image = [UIImage imageNamed:@"keyboard_delete"];
        [_deleteBtn addSubview:iconImgView];
        
        CGFloat btnHeight = [[self class] buttonLineHeight];
        [iconImgView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(btnHeight * 5/8);
            make.center.equalTo(self.deleteBtn);
        }];
        
        @weakify(self);
        [_deleteBtn addActionBlock:^(UIButton *sender) {
            @strongify(self);
            if (!self.containerTxtField) {
                return;
            }
            
            [self.containerTxtField deleteBackward];
        }];
    }
    return _deleteBtn;
}

- (JBKeyboardButton *)doneBtn
{
    if (!_doneBtn) {
        _doneBtn = [[JBKeyboardButton alloc] init];
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        @weakify(self);
        [_doneBtn addActionBlock:^(UIButton *sender) {
            @strongify(self);
            [self.containerTxtField resignFirstResponder];
        }];
    }
    return _doneBtn;
}

#pragma mark -

+ (CGFloat)smallButtonWidth
{
    NSInteger smallBtnCountPerLine = 10;
    //两边的间距加起来刚好是一个JBKeyboard_Space_X
    CGFloat result = (kScreenWidth - smallBtnCountPerLine * JBKeyboard_Space_X) / smallBtnCountPerLine;
    return result;
}

+ (CGFloat)buttonLineHeight
{
    NSInteger keyboardLineCount = 4;
    CGFloat result = ( JBKeyboard_Keyboard_Height - 2*JBKeyboard_Vertical_Inset - JBKeyboard_Space_Y * (keyboardLineCount - 1) ) / keyboardLineCount;
    return result;
}

/**
 *  修改textField中的文字
 */
+ (void)insertText:(NSString *)text toTxtFied:(UITextField *)txtField{
    if (text.length == 0) {
        return;
    }
    
    UITextPosition *beginning = txtField.beginningOfDocument;
    UITextPosition *start = txtField.selectedTextRange.start;
    UITextPosition *end = txtField.selectedTextRange.end;
    NSInteger startIndex = [txtField offsetFromPosition:beginning toPosition:start];
    NSInteger endIndex = [txtField offsetFromPosition:beginning toPosition:end];
    
    // 将输入框中的文字分成两部分，生成新字符串，判断新字符串是否满足要求
    NSString *originText = txtField.text;
    NSString *part1 = [originText substringToIndex:startIndex];
    NSString *part2 = [originText substringFromIndex:endIndex];
    
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", part1, text, part2];
    txtField.text = newText;
    //修复自定义键盘不触发UIControlEventEditingChanged事件的问题
    //另一种方案：insertText方法可以自动触发UIControlEventEditingChanged
    [txtField sendActionsForControlEvents:UIControlEventEditingChanged];
    
    // 重置光标位置
    UITextPosition *now = [txtField positionFromPosition:start offset:text.length];
    UITextRange *range = [txtField textRangeFromPosition:now toPosition:now];
    txtField.selectedTextRange = range;
}

#pragma mark -

+ (NSArray *)randomSortedArrFromSrcArr:(NSArray *)srcArr
{
    NSArray *result = [srcArr sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    
    return result;
}

#pragma mark -

- (void)insertText:(NSString *)text
{
    if (!self.containerTxtField) {
        return;
    }
    
    [[self class] insertText:text toTxtFied:self.containerTxtField];
}

- (void)reloadRandomKeys
{
    //do nothing
}

@end
