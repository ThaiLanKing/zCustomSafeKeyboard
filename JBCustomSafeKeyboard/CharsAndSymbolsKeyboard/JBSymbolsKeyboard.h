//
//  JBSymbolsKeyboard.h
//  JamBoHealth
//
//  Created by ZhangYaoHua on 2019/11/4.
//  Copyright © 2019 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBSymbolsKeyboard : UIView

@property (nonatomic, strong, readonly) NSArray *allSymbolBtns;

- (void)reloadRandomKeys;

@end

NS_ASSUME_NONNULL_END
