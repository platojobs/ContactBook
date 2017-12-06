# ContactBook
调用系统通讯录选择联系人
1.添加紧急联系人

```Objective-c
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
