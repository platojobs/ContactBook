//
//  WbContactUtil.m
//  WanBo
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 cuishengxi. All rights reserved.
//

#import "WbContactUtil.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@implementation WbContactModel
- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber
{
    self = [super init];
    if (self) {
        self.name = name;
        self.phoneNumber = phoneNumber;
    }
    return self;
}
@end

#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

@interface WbContactUtil ()<UINavigationControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, copy) WbContactsBlock contactBlock;

@end


@implementation WbContactUtil

#pragma mark - 调用系统通讯录 选择并获取联系人信息
- (void)callContactsHandler:(WbContactsBlock)handler {
    
    self.contactBlock = handler;
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        [kRootViewController presentViewController:peoplePicker animated:YES completion:nil];
        
    
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person{
    // 1.获取选中联系人的姓名
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    // (__bridge NSString *) : 将对象交给Foundation框架的引用来使用,但是内存不交给它来管理
    // (__bridge_transfer NSString *) : 将对象所有权直接交给Foundation框架的应用,并且内存也交给它来管理
    NSString *lastname = (__bridge_transfer NSString *)(lastName);
    NSString *firstname = (__bridge_transfer NSString *)(firstName);
    
    NSLog(@"%@%@", lastname, firstname);
    
    // 2.获取选中联系人的电话号码
    // 2.1.获取所有的电话号码
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex phoneCount = ABMultiValueGetCount(phones);
    
    // 2.2.遍历拿到每一个电话号码
    NSString *phoneValue;
    for (int i = 0; i < phoneCount; i++) {
        // 2.2.1.获取电话对应的key
        NSString *phoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
        
        // 2.2.2.获取电话号码
        phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
        
        NSLog(@"%@ %@", phoneLabel, phoneValue);
    }
    WbContactModel*model=[[WbContactModel alloc]initWithName:[NSString stringWithFormat:@"%@%@",firstName,lastName] phoneNumber:phoneValue];
    if (self.contactBlock) {
        self.contactBlock(model);
    }
    // 注意:管理内存
    CFRelease(phones);
    [kRootViewController dismissViewControllerAnimated:YES completion:^{}];
}


@end
