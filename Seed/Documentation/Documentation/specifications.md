# iOS开发编码及命名规范

## 目的
统一规范 Xcode 编辑环境下 Objective-C 的编码风格和标准。

## 适用范围
适用于所有用 Objective-C 语言开发的项目。

## 编码规范
### 文件

项目名称以项目代号开头，团队合作时个人创建的文件以姓名首字母大写开头，推荐采用三个字母。 (苹果公司拥有所有两个字母前缀的使用权)

任何文件的命名严禁以中文命名。

### 注释
注释可以采用多行注释和单行注释。多行注释时，尽量使用多行注释。对于一行代码的注释可放在前一行及本行上，不允许放在下一行，更不允许在一行语句的中间加入注释。

```
// 单行注释

/**
 多行注释
 */
```

单元文件的文件头注释说明。

```
//
//  文件名
//  工程名
//
//  Created by 创建者 on 日期.
//  Copyright © 年份  组织名称. All rights reserved.
//
//  系统名称： 
//  功能描述：
//  修改记录：(仅记录功能修改)
//       张三   2012-02-02  创建该单元 
//       小明   2010-03-02  增加本地点单功能。
//
```

方法前面的注释，如果某项没有，则以N/A表示。

```
/**
 函数描述

 @param 参数名 参数说明
 @return 返回值说明
 */
```

### 编码排版格式
#### 缩进
代码的缩进应使用空格 (space) ，不能使用制表符 (tab) ，并且缩进以2个字符为单位。

#### 中括弧
两种方式都可以，但同一个项目中不应同时出现两种。

```
- (instancetype)init {
    self = [super init];
    if (self) {
        <#code#>
    }
    return self;
}
```
```
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        <#code#>
    }
    return self;
}

```

#### 空格
关键字与其后的表达式之间要有空格

  ```
 if (self) {
     
     
 } else {
     
     
 }
  ```

单目操作符 (! 、 & 、 ^ 、 | ) 不应与它们的操作数分开。

除 "," 外，其它双目操作符应与它们的操作数用空格隔开。

  ```
i=i+1;       //错误
i = i + 1;   //正确
  ```

.h文件中协议<>前面有一个空格。

.h文件中成员声明时，类型与变量之间有至少1个空格。

  ```
NSString *imageString;
  ```

@property后留1个空格，()里面逗号紧跟前一变量，与后一变量之间留1个空格。()外面先留1个空格，再声明属性。

  ```
@property (nonatomic, strong) UIImageView *imageView;
  ```

方法的 "+" "-" 后面与 () 之间留1个空格。

  ```
- (void)qh_dismissWithIndex:(NSInteger)index;
  ```

方法返回类型和参数类型与 * 之间留1个空格。

 ```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
 ```

在多参数方法中，每个参数后面都有1个空格。

每行只能有一个语句

#### 空行
##### 文件中的空行
不同模块之间空 2 行，相同模块内空 1 行或不空行，注释与方法之间不空行。

```
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@class GQHButton;


@protocol Delegate <NSObject>

- (void)myDelegate;

@optional
- (void)optionalDelegate;

@end


@interface ViewController : UIViewController

@property (nonatomic, weak) id<Delegate> delegate;

@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, assign) NSInteger index;

// 初始化
- (instancetype)init;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end
```

##### 方法里面的空行

变量声明各类别之间空 1 行；条件、循环，选择语句，语句开始空 1 行，结束不空行；功能块之间空 1 行；注释与代码之间不空行；最后一个括弧之前不空行。

### 命名规范
#### 保留字
Objective-C 语言的保留字或关键词应全部使用小写字母。除下表中保留字外，**private** 、 **protected** 、 **public** 在类型说明中也作为保留字使用。**nonatomanic** 、 **retain** 、 **readwrite** 、 **readonly** 等也有特殊的使用场合。

```
_Bool _Complex _Imaginary auto break bycopy byref case char const continue default do double else enum extern float for goto if in inline inout int long oneway out register restrict return self short signed sizeof static struct super switch typedef union unsigned void volatile while
```

#### 方法
方法的名称应全部使用有意义的单词组成且以小写字母开头。多单词组合时，后面的单词首字母大写。

```
- (void)getUserInformation;
```

设置变量内容的方法应使用 set 作为前缀，读取变量内容的方法应使用 get 作为前缀。

get 获取项目内的变量、数据等  
fetch 获取项目外的本机资源，例如相册照片、相机、定位信息等  
request 通过网络请求获取信息，例如接口

```
- (void)getUserName;
- (void)setUserName:(NSString *)userName;
```

方法中的第一个参数名称要从函数名称上携带出来，第二个参数的首字母小写，多个单词组合时，后面单词首字母大写。参数别名与前一参数保留1个空格。参数以有意义的字母命名。

```
- (instancetype)viewWithFrame:(CGRect)frame imageArray:(NSArray<UIImage *> *)imageArray;
```

#### 变量
变量必须起有意义的名字，使其他组员可以很容易读懂变量所代表的意义，变量命名可以采用同义的英文命名，可使用几个英文单词，第一个单词首字母小写，其他单词首字母大写。

```
NSString  *totalScore;
```

对于一些特殊类型的变量，命名时要带上类型。

```
NSArray *productPriceArray;
NSMutableDictionary *productDictionary;
```

对于要和 interface builder 关联的的输出控件变量，命名时要后缀以特定的控件名。

```
UILabel *userNameLabel;
```

对于使用 C 语言形式声明的变量，一些特定类型可采用一定的简写。循环控制变量通常使用单一的字符如 i 、 j 、 k 等。

<!--BOOL变量全部以is开头-->

#### 常量
避免在程序中直接出现常数，使用三次及三次以上的应以宏定义的形式来替代。

常数的宏定义应与它实际使用时的类型相一致。如以 3.0 来定义浮点类型，用 3 表示整型。

常量的命名应当能够表达出它的用途，并且用大写字母表示。

```
#define MARGIN_SINGLE  15.0
```

一些常量前加特殊前缀，可以作为不同常量的区分

```
#define SCREEN_WIDTH   CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT  CGRectGetHeight([UIScreen mainScreen].bounds)
```

#### 类
所有的类名、接口名(Protocol)均以大写字母开头，多单词组合时，后面的单词首字母大写。类、接口名必须是有意义的。

* 继承自UIView的类以View结尾。

* 继承自ViewController的类以Controller结尾。

* 所有保存数据的实体以Model结尾。


### 修改规范
#### 新增代码行
新增代码行的前后应有注释行说明。

```
//修改人，修改时间，修改说明
//新增代码行
//修改结束
```

#### 删除代码行
删除代码向的前后用注释行说明

```
//修改人，修改时间，修改说明
//要删除的代码行(将要删除的语句进行注释)
//修改结束
```

#### 修改代码行
修改代码行以注释旧代码行后再新增代码行的方式进行。

```
//修改人，修改时间，修改说明

//修改前代码行开始
//修改前代码行
//修改前代码行结束

//修改后代码行开始
//修改后代码行
//修改结束
```

### 注意事项
#### 点语法
点语法用于简单的属性set、get操作，但对象的其他行为不应该使用它。
