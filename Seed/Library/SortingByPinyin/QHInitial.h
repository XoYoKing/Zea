

#import <Foundation/Foundation.h>

@interface QHInitial : NSObject

#pragma mark --Description
/**
 *  输出汉字首字母
 *
 *  @param chinese 汉字
 *
 *  @return 汉字首字母
 */
+ (char)PinyinFirstCharacter:(unsigned short)chinese;

@end
