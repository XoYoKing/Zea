
#import "QHChinesePhrase.h"
#import "QHInitial.h"

@implementation QHChinesePhrase

@synthesize chinese;
@synthesize pinYin;


#pragma mark - 排序词组
+ (NSMutableArray *)sortedChineseArray:(NSArray *)phraseArray {
    
    NSMutableArray *tempArray = [self orderByChinesePinyin:phraseArray];
    NSMutableArray *chineseArray = [NSMutableArray array];
    
    for (int i = 0; i < [phraseArray count]; i++) {
        
        [chineseArray addObject:((QHChinesePhrase *)[tempArray objectAtIndex:i]).chinese];
    }
    return chineseArray;
}

#pragma mark - 分组词组
+ (NSMutableArray *)dividePhraseArray:(NSArray *)phraseArray {
    
    NSMutableArray *dividedPhraseArray = [NSMutableArray array];
    
    NSMutableArray *tempArray = [self orderByChinesePinyin:phraseArray];
    NSMutableArray *group = [NSMutableArray array];
    NSString *tempString;
    
    //拼音分组
    for (NSString *object in tempArray) {
        
        NSString *initial = [((QHChinesePhrase *)object).pinYin substringToIndex:1];
        NSString *chinese = ((QHChinesePhrase *)object).chinese;
        
        if(![tempString isEqualToString:initial]) {
            //分组
            group = [NSMutableArray array];
            [group  addObject:chinese];
            [dividedPhraseArray addObject:group];
            
            tempString = initial;
            
        } else {
            [group  addObject:chinese];
        }
    }
    return dividedPhraseArray;
}

#pragma mark - indexCharacterArray(索引)
+ (NSMutableArray *)acquireIndexCharacterArray:(NSArray *)phraseArray {
    
    NSMutableArray *indexCharacterArray = [NSMutableArray array];
    NSString *tempCharater = [NSString string];
    
    NSMutableArray *tempArray = [self orderByChinesePinyin:phraseArray];
    
    for (NSString *object in tempArray) {
        
        NSString *initial = [((QHChinesePhrase *)object).pinYin substringToIndex:1];
        
        if (![tempCharater isEqualToString:initial]) {
            
            [indexCharacterArray addObject:initial];
            
            tempCharater = initial;
        }
    }
    
    return indexCharacterArray;
}

//返回排序好的词组(汉字和拼音)，放在数组中
+ (NSMutableArray *)orderByChinesePinyin:(NSArray *)phraseArray {
    
    //获取字符串中汉字的拼音首字母并与字符串共同存放
    NSMutableArray *chinesePhraseArray = [NSMutableArray array];
    
    for (int i = 0; i < [phraseArray count]; i++) {
        
        QHChinesePhrase *chinesePhrase = [[QHChinesePhrase alloc]init];
        
        chinesePhrase.chinese = [NSString stringWithString:[phraseArray objectAtIndex:i]];
        
        if (chinesePhrase.chinese == nil) {
            
            chinesePhrase.chinese = @"";
        }
        
        //去除两端空格和回车
        chinesePhrase.chinese  = [chinesePhrase.chinese stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //递归过滤指定字符
        chinesePhrase.chinese = [QHChinesePhrase removeSpecialCharactersFromUnfilterString:chinesePhrase.chinese];
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        NSString *initial = [chinesePhrase.chinese length]?[chinesePhrase.chinese substringToIndex:1]:@"";//initial 首字母
        
        if ([predicate evaluateWithObject:initial]) {
            //首字母大写
            chinesePhrase.pinYin = [chinesePhrase.chinese capitalizedString];
            
        } else {
            
            if (![chinesePhrase.chinese isEqualToString:@""]) {
                NSString *initialString = [NSString string];
                
                //获取每个汉字的大写首字母
                for(int j = 0; j < chinesePhrase.chinese.length; j++){
                    unsigned short temp = [chinesePhrase.chinese characterAtIndex:j];
                    char tempChar = [QHInitial PinyinFirstCharacter:temp];
                    NSString *singleInitial = [[NSString stringWithFormat:@"%c",tempChar] uppercaseString];
                    initialString = [initialString stringByAppendingString:singleInitial];
                }
                
                chinesePhrase.pinYin = initialString;
                
            } else {
                chinesePhrase.pinYin = @"";
            }
        }
        [chinesePhraseArray addObject:chinesePhrase];
    }
    
    //按照拼音首字母对这些Phrase进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chinesePhraseArray sortUsingDescriptors:sortDescriptors];
    
    return chinesePhraseArray;
}

//过滤指定字符串 里面的指定字符根据自己的需要添加
+ (NSString *)removeSpecialCharactersFromUnfilterString: (NSString *)unfilterString {
    
    NSCharacterSet *searchSet = [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"];
    NSRange urgentRange = [unfilterString rangeOfCharacterFromSet: searchSet];
    
    if (urgentRange.location != NSNotFound) {
        
        NSString *filteredString = [unfilterString stringByReplacingCharactersInRange:urgentRange withString:@""];
        
        return [self removeSpecialCharactersFromUnfilterString:filteredString];//筛选未结束，继续筛选
    }
    
    return unfilterString;
}

@end
