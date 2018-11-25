
#import <Foundation/Foundation.h>
#import "QHInitial.h"

@interface QHChinesePhrase : NSObject

@property (nonatomic, copy) NSString *chinese;

@property (nonatomic, copy) NSString *pinYin;

//索引
+ (NSMutableArray *)acquireIndexCharacterArray:(NSArray *)phraseArray;

//分组排序词组
+ (NSMutableArray *)dividePhraseArray:(NSArray *)phraseArray;

//排序词组(中英混排)
+ (NSMutableArray *)sortedChineseArray:(NSArray *)phraseArray;

@end
