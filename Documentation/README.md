
# 工程文档

## 支持

* 支持版本: iOS 9.0
* 适配机型: iPhone 5s 以上


## 文件名、类名、变量名命名

##### 类名必须以GQH开头，以类的父类型结尾
> 例：GQHHomeController

#### 自定义公共方法名必须以qh_开头 系统方法保持原样
> 例：- (returnType)qh_method:(type)parameter;

#### 自定义私有方法名无须以qh_开头，但不能与系统方法冲突
> 例：- (returnType)qh_method:(type)parameter;

##### 网络请求的方法名用request
> 例：- (void)qh_requestUserInfo;

##### 应用程序内取值的方法名用get
> 例：- (void)qh_getImageViewFrame;

##### 应用程序外取值的方法名用fetch
> 例：- (void)qh_fetchPhoto;


# 项目文档

## 项目命名及说明

dashBoard       仪表盘
recordBoard     纪录板
scoreBoard      记分板

默认游戏设置
user_image      游戏图片
user_level         游戏等级
user_sound      游戏音效
user_record     游戏记录

# 项目中英文对照





## 通用

注册：register
登录：login
注销、退出：logout
用户名：username
密码：password
首页：home
订单：order
我的：me
消息(聊天消息)：chat
消息：message
通知：notice
详情： detail
服务：service
确定：sure、confirm
完成：done
取消：cancel
应用：apply






Authentication :  认证，确定用户身份
Authorization :  授权，允许用户获取某些权限


增 create add new
删 delete remove
改 update change
查 read check





// 登录／注册
"login" = "Login";
"password" = "Password";

// 忘记密码
"forget" = "ForgetPassword";

// 第三方登录
"quicklogin" = "Quick Login";

// 手机号验证码注册
"next" = "Next";
"phone" = "Phone Number";
"code" = "Verification Code";













## 权限
如果手机应用程序像后台一样可以进行角色和权限配置，需要协调用户、角色和权限三者的关系。
用户：未登录(游客)、登录
角色：(本应用程序)司机、货主、无车承运人、物流企业
权限：(本应用程序)司机三级(未认证、待完善、认证)，其他两级(未认证、认证)

通过这种方式可以将多种服务放到一个手机应用程序中，但是这样增加应用程序复杂度。

例如：
美团应用程序：

用户级：游客，登录用户
角色级：入住商家、普通用户、外卖小哥
权限级：入住商家(浏览、开店、接单)，普通用户(浏览、下单)，外卖小哥(浏览、接单)



## 保安端

勤务： GQHHomeController
消息：GQHChatController
指令：GQHInstructionController
工单：GQHOrderController
我的：GQHMeController


## 客户端

主页：GQHHomeController
订单：GQHOrderController
我的：GQHMeController

## 模式选择

先根据MVC模式进行划分成Model层、View层、Controller层，然后在每一层中根据业务及功能划分单独的功能模块。
理由：如果根据业务及功能划分各自的MVC层，则在开发过程中会出现各个模块中共用的某些类或文件不知道放到何处，例如模块有首页、订单、我的，在订单模块中有OrderModel、OrderView、UserModel、UserView，在我的模块中也有OrderModel、OrderView、UserModel、UserView，不管放在哪里都不合适。而根据MVC模式划分Model层、View层、Controller层，在每层中根据业务及功能划分单独的功能模块，例如Model层中有OrderModel、UserModel，在View层中OrderView、UserView，在Controller层中有OrderController、UserController，开发过程中用到哪一层就可以直接使用，一定程度提高了复用性。

