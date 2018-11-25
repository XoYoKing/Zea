# ChineseToPinYin

### 术语定义

Chinese -> 汉字(单个字)

Phrase -> 词组(多个字，且包含英文及其他符号)

initial -> 本义为初始化，也作首字母

Pinyin -> 专有名词，指汉语拼音

### 说明

参考网络已有的词组排序(汉字与英文混排)，发现其中有很多问题，自己在参考的基础上又重新整理了一下，但是有些问题没有解决，先列出我想到的问题，以后会继续修改。

#### 问题

本代码提供的是按照汉语词组中每个汉字的拼音首字母及英文单词全字母进行排序

例如：西安XA，北京BJ，排序为北京，西安

但是汉字常见排序方式为：按汉字全拼分字排序

例：杭州hangzhou，汉字hanzi，常见排序为汉字(han zi)，杭州(hang zhou)；按首字母排序为默认排序杭州(HZ)，汉字(HZ)，则可认为没有排序。

英文排序也是如此。

### 使用

首先导入类文件"QHChinesePhrase.h"、"QHChinesePhrase.m"、"QHChinesePhrase.h"、"QHInitial.h"、"QHInitial.m"

然后项目中导入头文件"QHChinesePhrase.h"

最后调用方法

```objc
//索引
+ (NSMutableArray *)acquireIndexCharacterArray:(NSArray *)phraseArray;

//分组排序词组
+ (NSMutableArray *)dividePhraseArray:(NSArray *)phraseArray;

//排序词组(中英混排)
+ (NSMutableArray *)sortedChineseArray:(NSArray *)phraseArray;
```

详细使用方法见项目Demo。

