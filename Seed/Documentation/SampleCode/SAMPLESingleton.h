//
//  SAMPLESingleton.h
//  Seed
//
//  Created by GuanQinghao on 26/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAMPLESingleton : NSObject

/// 单例方法一般以default  share  stand单词开头
+ (instancetype)sharePerson;
+ (instancetype)defaultPerson;

@end



@protocol SAMPLEObjectDelegate <NSObject>

@required

@optional

@end

@interface SAMPLEObject : NSObject

/// 代理使用weak来修饰
@property (nonatomic, weak) id<SAMPLEObjectDelegate> qh_delegate;

@end
