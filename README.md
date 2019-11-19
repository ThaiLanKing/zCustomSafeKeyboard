# zCustomSafeKeyboard
安全密码输入键盘，支持数字、字母随机排序

参考了项目[LRSafetyKeyboard](https://github.com/Luriss/SafetyKeyboard)，调整了键盘键位的布局逻辑及键盘弹出方式，不会监听键盘的显示隐藏通知

#### 效果

![safeKeyboard.gif](https://github.com/ThaiLanKing/zCustomSafeKeyboard/blob/master/safeKeyboard.gif)


#### 使用方式

引入头文件`UITextField+zSafeKeyboard.h`，内部有两个方法：

```objc

//字母符号键盘
- (void)setJBCharsAndSymbolsKeyboard:(BOOL)safe;

//纯数字键盘
- (void)setJBPureNumbersKeyboard:(BOOL)safe;

```

对于需要设置安全键盘的textField调用方法即可：

```objc

[self.passwordTxtField setJBCharsAndSymbolsKeyboard:YES];

```