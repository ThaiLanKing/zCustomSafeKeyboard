//
//  UIButton+ActionBlock.h
//  JamBoHealth
//
//  Created by zyh on 16/7/29.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(UIButton *sender);

@interface UIButton (ActionBlock)

@property (nonatomic, copy) ActionBlock actionBlock;

- (void)addActionBlock:(ActionBlock)actionBlock;

@end
