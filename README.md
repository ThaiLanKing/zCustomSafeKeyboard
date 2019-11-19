# zCustomSafeKeyboard
安全密码输入键盘，支持数字、字母随机排序

#### 效果

![safeKeyboard.gif](https://github.com/ThaiLanKing/zCustomSafeKeyboard/blob/master/safeKeyboard.gif)


#### 使用方式

引入头文件`UITextField+zSafeKeyboard.h`
有两个方法：

```objc
//字符键盘
- (void)setJBCharsAndSymbolsKeyboard:(BOOL)safe;

//纯数字键盘
- (void)setJBPureNumbersKeyboard:(BOOL)safe;

```

对于需要设置安全键盘的textField调用方法即可：

```
[self.passwordTxtField setJBCharsAndSymbolsKeyboard:YES];

```