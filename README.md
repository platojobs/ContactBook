# ContactBook
调用系统通讯录选择联系人

1.添加紧急联系人
***权限配置***
***通讯录权限： Privacy - Contacts Usage Description  是否允许此App访问你的通讯录？***
![效果图](https://github.com/cuishengxi/ContactBook/blob/master/1375AF7C8D253AAD3AEA915CD6ECEE67.png?raw=true)
```Objective-c

把这个类直接干到你的文件里，怎么干，不用教了吧

/**
 *  调用系统通讯录 选择并获取联系人信息
 *
 *  @param handler 选取联系人后的回调
 */
- (void)callContactsHandler:(WbContactsBlock)handler;
//在点击添加联系人按钮事件里面：

self.contactsUtil = [WbContactUtil new];
// 获取联系人信息
[self.contactsUtil callContactsHandler:^(WbContactModel *contact) {
NSLog(@"David恭喜发财==@@ name : %@, phoneNumber: %@", contact.name, contact.phoneNumber);

}];

```
