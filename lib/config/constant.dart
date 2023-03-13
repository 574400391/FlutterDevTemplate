import 'package:flutter/foundation.dart';

/// 运行时参数配置
class Constant {

  /// 是否打印日志，此处根据构建模式区分，debug/profile版本打印日志，release版本屏蔽日志
  static const bool showLog = kReleaseMode;

  /// aes对称加密key
  /// TODO：自行修改
  static const String aesEncryptKey = "eENuAKZDTF+rasrMePeguLoIEifVIb9P";

  /// 当前app版本和名称，程序初始化时获取
  static String currentVersionName = 'APP_V1.0.0';

  /// 当前编译版本名称（动态配置）
  static String currentBuildName = '';

  /// 当前编译版本ExampleApi使用的BaseUrl（动态配置）
  static String exampleApiBaseUrl = '';
}