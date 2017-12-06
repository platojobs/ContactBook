//
//  WbContactUtil.h
//  WanBo
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 cuishengxi. All rights reserved.
//

#import <Foundation/Foundation.h>
/** model 类 */
@interface WbContactModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;

@end
@interface WbContactUtil : NSObject
typedef void(^WbContactsBlock)(WbContactModel *contact);
/**
 *  调用系统通讯录 选择并获取联系人信息
 *
 *  @param handler 选取联系人后的回调
 */
- (void)callContactsHandler:(WbContactsBlock)handler;

@end
