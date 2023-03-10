import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:common_utils/common_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:convert/convert.dart';
import 'package:flutter_dev_template/common/eventbus_manager.dart';
import 'package:flutter_dev_template/config/constant.dart';
import 'package:flutter_dev_template/common/event_bus_enum.dart';
import 'package:flutter_dev_template/utils/device_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'log_utils.dart';
import 'package:encrypt/encrypt.dart' as encrypt_lib;

class Utils {

  static String getRandomString(int? length) {
    if (length == null || length < 0) {
      return '';
    }
    String random =
        "zxcvbnmlkjhgfdsaqwertyuiopQWERTYUIOPASDFGHJKLZXCVBNM1234567890";
    String s = '';
    var r = Random();
    for (int i = 0; i < length; i++) {
      int number = r.nextInt(62);
      s += random[number];
    }
    return s;
  }

  // md5后取sha1值
  static sha1AndMd5(String data) {
    var md5Content = md5.convert(const Utf8Encoder().convert(data));
    return hex.encode(sha1
        .convert(const Utf8Encoder().convert(hex.encode(md5Content.bytes)))
        .bytes);
  }

  static String transEmpty(String? str) {
    return (str == null) ? '' : str;
  }

  static String transEmptyAndReturnDefaultStr(String? str,
      {required String defaultStr}) {
    if (str == null || str.isEmpty) {
      return defaultStr;
    }
    return str;
  }

  // 校验字符串是否是数字
  static bool checkNumber(String? input, {bool isCheckZero = false}) {
    RegExp regExpStr = RegExp(r'(^[\-0-9][0-9]*(.[0-9]+)?)$');
    if (isCheckZero) {
      return regExpStr.hasMatch(input!) && double.parse(input) != 0;
    }
    return regExpStr.hasMatch(input!);
  }

  // 校验字符串是否是正整数
  static bool isNumeric(String input) {
    RegExp regExpStr = RegExp(r'(^[0-9]*)$');
    return regExpStr.hasMatch(input);
  }

  // 校验字符串是否是email
  static bool checkEmail(String input) {
    RegExp regExpStr = RegExp(r'\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*');
    return regExpStr.hasMatch(input);
  }

  // 校验字符串是否是合法的手机号
  static bool checkSjhm(String input) {
    RegExp regExpStr = RegExp(
        r'^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$');
    return regExpStr.hasMatch(input);
  }

  // 校验字符串是否是合法的身份证号
  static bool checkID(String input) {
    RegExp regExpStr = RegExp(r'(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)');
    return regExpStr.hasMatch(input);
  }

  // 校验证书密码
  static bool checkPwd(String input) {
    RegExp regExpStr = RegExp(r'^.{6,20}$');
    return regExpStr.hasMatch(input);
  }

  // 校验手机号登录密码
  static bool checkPhonePwd(String input) {
    RegExp regExpStr = RegExp(r'^.{8,20}$');
    return regExpStr.hasMatch(input);
  }

  // 获取字符串byte长度--按gbk编码，业务层校验也是按gbk格式字节长度校验（汉字及全角符号占两个字节）
  static int getByteLength(String input) {
    RegExp chineseByteReg = RegExp(r'[^\x00-\xff]');
    int length = 0;
    try {
      for (int i = 0; i < input.length; i++) {
        if (chineseByteReg.hasMatch(input.characters.characterAt(i).toString())) {
          length += 2;
        } else {
          length++;
        }
      }
    } catch (e) {
      return input.length;
    }
    return length;
  }

  /// 是否含有特殊字符
  static bool tszf(String input) {
    RegExp chineseByteReg = RegExp(r'[￥§＄￡￠€℃℅℉№℡?∏※∮‰]');
    for (int i = 0; i < input.length; i++) {
      if (chineseByteReg.hasMatch(input.characters.characterAt(i).string)) {
        return true;
      }
    }
    return false;
  }

  static bool isEmpty(String? input) {
    return input == null || input.isEmpty || input.trim().isEmpty;
  }

  static bool isNotEmpty(String? input) {
    return input != null && input.isNotEmpty;
  }


  /// EventBus 监听事件 执行某方法
  ///   注：事件监听方法，只需调用一次，严禁放到onTap或者onPressed中多次触发
  static void eventBusOn(EventBusNameEnum eventName, EventCallback f) {
    Log.d("-----eventBusOn-----:$eventName");
    EventBus().on(eventName, (arg) {
      Log.d("-----eventBusOn接收到的参数-----$arg");
      f(arg);
    });
  }

  /// EventBus 注销事件
  static void eventBusOff(EventBusNameEnum eventName) {
    Log.d("-----eventBusOff-----:$eventName");
    EventBus().off(eventName);
  }

  /// EventBus 发送事件
  static void eventBusEmit(EventBusNameEnum eventName, arg) {
    Log.d("-----eventBusEmit-----:$eventName 发送的参数 $arg");
    EventBus().emit(eventName, arg);
  }

  /// WangHL：获取当前平台存储目录，用户可见（仅支持Android/iOS）
  static Future<String> getDirectoryPath() async {
    String directoryPath;
    if (Device.isAndroid) {
      /// WangHL: Android端使用外置存储目录: /storage/emulated/0/Android/data/[package_name]/files
      var directory = await getExternalStorageDirectory();
      directoryPath = directory!.path;
      Log.d('Android directory path: ${directory.path}');
    } else if (Device.isIOS) {
      var directory = await getApplicationDocumentsDirectory();
      directoryPath = directory.path;
      Log.d('iOS ApplicationDocumentsDirectory path: ${directory.path}');
    } else {
      directoryPath = "";
      Log.d('暂不支持当前平台！');
    }
    return directoryPath;
  }

  /// 项目存储数据目录，用户不可见
  static Future<String> getLibraryPath() async {
    String directoryPath;
    if (Device.isAndroid) {
      var directory = await getDatabasesPath();
      directoryPath = directory;
      Log.d('Android library path: $directoryPath');
    } else if (Device.isIOS) {
      var directory = await getLibraryDirectory();
      directoryPath = directory.path;
      Log.d('iOS LibraryDirectory path: ${directory.path}');
    } else {
      directoryPath = "";
      Log.d('暂不支持当前平台！');
    }
    return directoryPath;
  }

  /// WangHL: 在指定目录下创建文件夹
  /// directoryPath： 指定目录
  /// fileName： 文件夹名称
  /// recursive： 创建的文件夹内是否会创建子目录，如果需要则指定为true
  static Future<void> createDirectory(String? directoryPath, String fileName,
      {bool recursive = false}) async {
    Directory directory =
        Directory("$directoryPath${Platform.pathSeparator}$fileName");
    if (!directory.existsSync()) {
      await directory.create(recursive: recursive);
    }
  }

  /// WangHL: 获取指定长度的随机数，包含大小写英文字母和数字
  ///     长度限制在1-20
  static String getRandomStr(int len) {
    if (len <= 0 || len > 20) {
      return '';
    }
    const chars = "QWERTYUIOPASDFGHJKLZXCVBNM1234567890";
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        len, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }


  static String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  static String formatYyyymmdd(String kprq) {
    return kprq.length < 8
        ? kprq
        : '${kprq.substring(0, 4)}年${kprq.substring(4, 6)}月${kprq.substring(6, 8)}日';
  }

  static final _key = encrypt_lib.Key.fromUtf8(Constant.aesEncryptKey);
  static final _iv = encrypt_lib.IV.fromLength(16);

  /// WangHL: 使用AES进行加密，密钥使用程序内置的aes_key
  ///   originalData: 明文数据
  ///       如果明文数据为空，加密失败，返回空字符串
  ///       明文数据不为空，则使用AES加密后将加密结果转为base64编码字符串
  static String aesEncrypt(String? originalData) {
    if (originalData != null && !isEmpty(originalData)) {
      final encrypted = encrypt_lib.Encrypter(encrypt_lib.AES(_key))
          .encrypt(originalData, iv: _iv);
      String base64Result = encrypted.base64;
      Log.d(
          'aesEncrypt originalData：$originalData， base64Result：$base64Result');
      return base64Result;
    } else {
      Log.d('aesEncrypt originalData is empty');
      return '';
    }
  }

  /// WangHL: 使用AES进行解密，密钥使用程序内置的aes_key
  ///   encryptData：加密数据
  ///       如果加密数据为空，解密失败，返回空字符串
  ///       加密数据不为空，则使用AES解密后将解密结果返回，解密时异常则返回空字符串
  static String aesDecrypt(String? encryptData) {
    if (encryptData != null && !isEmpty(encryptData)) {
      try {
        final decryptResult = encrypt_lib.Encrypter(encrypt_lib.AES(_key))
            .decrypt64(encryptData, iv: encrypt_lib.IV.fromLength(16));
        Log.d(
            'aesDecrypt encryptData：$encryptData，decryptResult：$decryptResult');
        return decryptResult;
      } catch (e) {
        Log.d('aesDecrypt catch error: ${e.toString()}');
        return '';
      }
    } else {
      Log.d('aesDecrypt encryptData is empty');
      return '';
    }
  }

  /// WangHL: 剪切文件到指定路径
  ///   如果源文件与目标文件在同一个文件系统路径下，则可以通过file.rename(newPath)完成剪切
  ///   如果源文件与目标文件在不同的文件系统路径下会抛出异常，需要拷贝后删除原文件
  static Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      // prefer using rename as it is probably faster
      return await sourceFile.rename(newPath);
    } on FileSystemException catch (e) {
      Log.d('moveFile onError: ${e.toString()}');
      // if rename fails, copy the source file and then delete it
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }
}
