//
//  JBKeyboardButton.m
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import "JBKeyboardButton.h"

@implementation JBKeyboardButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color(@"acb3be");
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.adjustsImageWhenHighlighted = NO;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = FontWithSize(18);
    }
    return self;
}

@end
