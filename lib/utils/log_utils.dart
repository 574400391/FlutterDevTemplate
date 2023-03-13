import 'dart:convert' as convert;
import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:encrypt/encrypt.dart' as encrypt_lib;
import 'package:flutter_dev_template/config/constant.dart';
import 'package:flutter_dev_template/utils/utils.dart';
import 'package:synchronized/synchronized.dart';

/// LOG工具类，根据是否
class Log {
  /// TODO tag需替换
  static const String tag = 'TEMPLATE-LOG';
  static final Lock _lock = Lock();

  static void init() {
    LogUtil.init(isDebug: !Constant.showLog, maxLen: 512);
  }

  static void d(Object? msg, {String tag = tag, bool saveLog = false}) {
    if (!Constant.showLog) {
      LogUtil.d(msg, tag:'【$tag】');
      if (saveLog) {
        Log.saveLog(msg.toString(), tag: tag);
      }
    }
  }

  static void e(Object msg, {String tag = tag, bool saveLog = false}) {
    if (!Constant.showLog) {
      LogUtil.e(msg, tag: tag);
      if (saveLog) {
        Log.saveLog(msg.toString(), tag: tag);
      }
    }
  }

  static String? directoryPath;
  static final _key = encrypt_lib.Key.fromUtf8(Constant.aesEncryptKey);
  static final _iv = encrypt_lib.IV.fromLength(16);

  static void saveLog(String msg, {String tag = tag}) async {
    await _lock.synchronized(() async {
      directoryPath ??= await Utils.getDirectoryPath();

      String dateStr =
          DateUtil.formatDate(DateTime.now(), format: DateFormats.y_mo_d);
      File file = File(
          "$directoryPath${Platform.pathSeparator}logs${Platform.pathSeparator}encrypt_$dateStr.log");
      if (!file.existsSync()) {
        await Utils.createDirectory(directoryPath, "logs", recursive: true);
        await file.create();
      }

      /// 加密及加密结果
      final encrypted = encrypt_lib.Encrypter(encrypt_lib.AES(_key)).encrypt(
          "------------------------------------------------------------------------------------------\n【$tag】【${Constant.currentVersionName}】 $msg",
          iv: _iv);
      await file.writeAsString(
          "${DateUtil.formatDate(DateTime.now(), format: DateFormats.h_m_s)} ${encrypted.base64}\n",
          mode: FileMode.append);
    });
  }

  /// WangHL 登录成功时创建用户文件目录
  ///   暂不需要，没有需要存储的文件
  static void initUserFileDir(String userId, String userNum) async {
    String directoryPath = await Utils.getDirectoryPath();
    await Utils.createDirectory(directoryPath, "${userId}_$userNum",
        recursive: true);
  }

  static void json(Object msg, {String tag = tag}) {
    if (Constant.showLog) {
      try {
        final dynamic data = convert.json.decode(msg as String);
        if (data is Map) {
          _printMap(data);
        } else if (data is List) {
          _printList(data);
        } else {
          LogUtil.v(msg, tag: tag);
        }
      } catch (e) {
        LogUtil.v(msg, tag: tag);
      }
    }
  }

  static void _printMap(Map data,
      {String tag = tag,
      int tabs = 1,
      bool isListItem = false,
      bool isLast = false}) {
    final bool isRoot = tabs == 1;
    final String initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) LogUtil.v('$initialIndent{', tag: tag);

    data.keys.toList().asMap().forEach((index, key) {
      final bool isLast = index == data.length - 1;
      var value = data[key];
      if (value is String) value = '"$value"';
      if (value is Map) {
        if (value.isEmpty) {
          LogUtil.v('${_indent(tabs)} $key: $value${!isLast ? ',' : ''}',
              tag: tag);
        } else {
          LogUtil.v('${_indent(tabs)} $key: {', tag: tag);
          _printMap(value, tabs: tabs);
        }
      } else if (value is List) {
        if (value.isEmpty) {
          LogUtil.v('${_indent(tabs)} $key: ${value.toString()}', tag: tag);
        } else {
          LogUtil.v('${_indent(tabs)} $key: [', tag: tag);
          _printList(value, tabs: tabs);
          LogUtil.v('${_indent(tabs)} ]${isLast ? '' : ','}', tag: tag);
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        LogUtil.v('${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}', tag: tag);
      }
    });

    LogUtil.v('$initialIndent}${isListItem && !isLast ? ',' : ''}', tag: tag);
  }

  static void _printList(List list, {String tag = tag, int tabs = 1}) {
    list.asMap().forEach((i, e) {
      final bool isLast = i == list.length - 1;
      if (e is Map) {
        if (e.isEmpty) {
          LogUtil.v('${_indent(tabs)}  $e${!isLast ? ',' : ''}', tag: tag);
        } else {
          _printMap(e, tabs: tabs + 1, isListItem: true, isLast: isLast);
        }
      } else {
        LogUtil.v('${_indent(tabs + 2)} $e${isLast ? '' : ','}', tag: tag);
      }
    });
  }

  static String _indent([int tabCount = 1]) => '  ' * tabCount;

  static void map(Map data, {String tag = tag}) {
    if (Constant.showLog) {
      _printMap(data);
    }
  }
}
