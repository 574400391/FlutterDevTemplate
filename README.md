# FlutterDevTemplate

flutter快速开发模板，用于跨端开发Android/iOS app。

开发环境如下：

- Flutter: 3.7.6
- Dart: 2.19.3
- Android
  - minSdkVersion: 21
  - targetSdkVersion: 33
  - compileSdkVersion: 33
  - Android Studio Electric Eel | 2022.1.1 Patch 2
- iOS
  - support iOS version: 11+

## 目录结构

- |--assets(资源目录)
  - |-- imgs (存放图片资源)
  - |-- json (存放接口通讯 json 文件,可以通过 json_serializable 解析 json 模板)
- |--config(编译时使用的配置文件目录)
- |--lib
  - |-- api (网络接口封装)
  - |-- common (常用类，例如常量 Constant)
  - |-- config (业务参数设置,不建议修改)
  - |-- model (实体类)
  - |-- provider (数据库)
  - |-- ui (界面相关 page，dialog，widgets)
    - |-- pages (界面)
    - |-- res (公共资源文件，string，colors，dimens，styles)
    - |-- widgets (自定义组件)
  - |-- utils (工具类)
  - |-- main.dart (程序入口)

## 技术栈选型

- 框架：flutter
- 屏幕适配：flutter_screenutil
- 缓存数据：shared_preferences
- 数据库：sqflite
- 网络通讯：dio
- cookie管理：dio_cookie_manager
- 启动 URL 的插件：url_launcher
- 图片展示：cached_network_image
- 轮播图：flutter_swiper
- 状态管理：provider
- Toast：oktoast
- 图片选择插件：image_picker
- 处理键盘事件：keyboard_actions
- json 模板解析: json_serializable
- Dart常用工具类：common_utils
- 并发控制:synchronized
- 替代MethodChannel: [pigeon](https://pub.flutter-io.cn/packages/pigeon)

## 功能描述

### 状态管理

状态管理使用provider库。

需控制provider在最小的widget节点范围内使用，注意区分哪些数据需要放到全局，哪些数据挂载到某个页面节点即可。

### 网络通讯

网络通讯使用dio库。

### SQLite数据库

使用sqflite库操作数据库。

需注意涉及表结构变动时，在openDatabase()中重写onUpgrade逻辑，自行判断旧数据库版本号，低于指定版本时执行更新脚本。

增删查操作参考/lib/ui/page/demo/db_demo/db_demo_page.dart

### SP缓存文件

参考/lib/common/sp_manager.dart

### 路由管理

自行设置routerName并完成Route映射，参考/lib/common/router_manager.dart

### 消息订阅

### Flutter与Native双向通讯

使用Pigeon库，可以替换flutter层通讯native层的Method Channel，通过在flutter层编辑模板定制，通过脚本生成native层对应文件

协议文件message.dart放置在/pigeons目录下，执行下述命令生成dart、Android、iOS三端相关pigeon文件

**下述脚本注意input指向的文件名称和java_out指定的包名路径、java_package**

```
flutter pub run --no-sound-null-safety pigeon --input pigeons/message.dart  --dart_out lib/pigeon.dart  --objc_header_out ios/Runner/pigeon.h  --objc_source_out ios/Runner/pigeon.m  --java_out ./android/app/src/main/java/dev/wanghl/flutter_dev_template/Pigeon.java --java_package "dev.wanghl.flutter_dev_template"
```

#### Flutter -> Native

使用@HostApi()注解，在Native层进行实现。在dart文件中调用Native中实现的函数。

**注**：若函数内返回值需要异步获取，可以另行定义@FlutterApi()，在Native层发送结果数据。

#### Native -> Flutter

使用@FlutterApi()注解，在dart文件进行实现。Native通过定义的函数来调用dart层函数。

在dart文件中通过NativeApi.setup(MyNativeApi());进行注册

### 权限管理

TODO

### Mock数据

TODO

### 日志管理

通过Log工具类进行日志打印，方便开发阶段排查问题。如需存储到文件，调用Log工具类打印日志时设置saveLog: true即可。

#### 日志加解密

参考**/lib/ui/page/demo/file_demo/file_demo.dart**

### 页面主题

TODO

### 编译时动态添加配置

从Flutter3.7版本开始，我们可以使用**--dart-define-from-file**参数指定编译时的配置文件：

```
flutter run --dart-define-from-file=config/dev.json
```

我们可以将开发、测试、生产环境不同的配置项或各种渠道标识添加到配置文件中，运行时动态指定配置文件路径，程序运行时通过Environment获取：

```
Constant.currentBuildName = const String.fromEnvironment('channel');
```

原生程序同样支持获取当前配置，参考：[Flutter 小技巧之 3.7 更灵活的编译变量支持--恋猫de小郭](https://juejin.cn/post/7197936331926175804)