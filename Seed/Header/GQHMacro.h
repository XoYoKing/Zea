//
//  GQHMacro.h
//  Seed
//
//  Created by GuanQinghao on 14/11/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#ifndef GQHMacro_h
#define GQHMacro_h


/// 弱引用
#define GQH_WEAKSELF     __weak typeof(self) weakSelf = self;
/// 弱引用变强引用
#define GQH_STRONGSELF   __strong __typeof(self) strongSelf = weakSelf;


/// debug 输出
#ifdef DEBUG
#define DLog(format, ...)   NSLog((@"\n[File:%s]\n" "[Function:%s]\n" "[Line:%d]\n" "[Output:"format"]\n"), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#define NSLog(...)
#endif


#endif /* GQHMacro_h */
