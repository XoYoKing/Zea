# 目录结构说明

## AppDelegate 文件夹
包含 AppDelegate.h 文件和 AppDelegate.m 文件，是工程创建时自动生成的文件。

## Documentation 文件夹
存放工程说明文档及其他文档，包含 Documentation 文件夹、LICENSE 文件、SampleCode 文件夹。

### Documentation 文件夹
存放工程编码规范、工程说明文档、项目文档等。
### LICENSE 文件
许可证文档。
### SampleCode 文件夹
存放示例代码。

## General 文件夹
存放分类、扩展、通用类、抽象类及自定义封装的各种控件或组件，包括 Category 文件夹、Class 文件夹、View 文件夹。

### Category 文件夹
存放通用分类或扩展。
### Class 文件夹
存放工程公共基类，例如 GQHBaseController 、GQHBaseModel等。
### View 文件夹
存放工程公共基类、通用视图类，例如 GQHCommonCell、GQHCustomButton等。

## Helper 文件夹
存放自定义工具类，例如网络请求封装、第三方库封装、定位工具、全局常量等。

### GQHConstantHelper.h 和 GQHConstantHelper.m 文件
全局常量。
### GQHNetHelper.h 和 GQHNetHelper 文件
网络请求封装。

## Header文件夹
存放工程全局引用头文件，包括 GQHHeader.h 文件、GQHMacro.h 文件。

### GQHHeader.h 文件
工程全局引用头文件，只引用公用文件。
### GQHMacro.h 文件
常用宏定义、宏定义方法等。

## Library 文件夹
常用的第三方库、集成的SDK、私有库、自定义控件等。

## Module 文件夹
按照业务功能进行划分成各个模块，每个模块按照 MVC 设计模式进行开发。

## Resource 文件夹
包含项目使用到的图片、视频、音频等资源文件，按照功能模块分文件夹保存。资源文件命名采用小写字母加下划线形式。

## Support Files 文件夹
系统支持文件。
