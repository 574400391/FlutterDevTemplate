import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt_lib;
import 'package:flutter_dev_template/config/constant.dart';
import 'package:flutter_dev_template/ui/res/gaps.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';
import 'package:flutter_dev_template/utils/utils.dart';

/// WangHL：
///   1. 实际业务场景中日志文件存储为高频低数据量，因此在存储时通过线程锁保障数据加密-存储顺序
///   2. 日志解密为低频大数据量，因此通过isolate切换子线程处理耗时任务
class FileDemo extends StatefulWidget {
  const FileDemo({Key? key}) : super(key: key);

  @override
  _FileDemoState createState() => _FileDemoState();
}

class _FileDemoState extends State<FileDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件存储Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                _startTimer();
                const plainText =
                    '123571653712631293879ahodihdkahdkjaslkdja阿克苏加大了建档立卡就是打卡机都卡死了；了，。/..,,]1[p]3[12';
                final key = encrypt_lib.Key.fromUtf8(Constant.aesEncryptKey);
                Log.d('Key: ${key.base64}');
                final iv = encrypt_lib.IV.fromLength(16);
                final encrypter = encrypt_lib.Encrypter(encrypt_lib.AES(key));

                /// 加密及加密结果
                final encrypted = encrypter.encrypt(plainText, iv: iv);
                Log.d('encrypted.base64: ${encrypted.base64}');
                _endTimer(bizTag: 'AES加密');

                _startTimer();

                /// 解密及解密结果
                String encryptStr =
                    "cu2wUWbpxDDzkRRekihFPbXqs/3UG1+oY+UZDfmKhaFZcbI54HICxOmiytmNti+0ZEDBTGnqOJgvfbKZU+JtyFqPqbm59XU0GogfMp6wk0eeyW+ApWCyEI77Q/xZoJXEWhDgjfY62R6Jty1apP4kjk2080dStIFZe8sEcw2vqi4=\n"
                        .trimRight();

                final decrypted = encrypt_lib.Encrypter(encrypt_lib
                        .AES(encrypt_lib.Key.fromUtf8(Constant.aesEncryptKey)))
                    .decrypt64(encryptStr, iv: encrypt_lib.IV.fromLength(16));
                Log.d('decrypted: $decrypted');
                _endTimer(bizTag: 'AES解密');
              },
              child: const Text(
                'AES加解密',
              ),
            ),
            TextButton(
              onPressed: () async {
                _startTimer();
                String directoryPath = await Utils.getDirectoryPath();
                await Utils.createDirectory(directoryPath, "logs",
                    recursive: true);
                await Utils.createDirectory(directoryPath, "1234567890",
                    recursive: true);
                Log.d('init files complete');
                _endTimer(bizTag: '初始化日志文件夹');
              },
              child: const Text('初始化日志文件夹'),
            ),
            TextButton(
              onPressed: () async {
                _startTimer();
                // 1. 创建或读取日志文件
                String directoryPath = await Utils.getDirectoryPath();
                String dateStr = DateUtil.formatDate(DateTime.now(),
                    format: DateFormats.y_mo_d);
                File file = File(
                    "$directoryPath${Platform.pathSeparator}logs${Platform.pathSeparator}$dateStr.log");
                if (!file.existsSync()) {
                  await file.create();
                }
                Log.d('file: $file');
                for (int i = 0; i < 10000; i++) {
                  var randomStr = _getRandomStr(10);
                  await file.writeAsString(_getLogStr(randomStr),
                      mode: FileMode.append);
                }
                _endTimer(bizTag: '日志明文1万条存储测试');

                _startTimer();
                await file.writeAsString(_getLogStr(_getRandomStr(100)),
                    mode: FileMode.append);
                _endTimer(bizTag: '日志明文追加存储测试');

                /// Android: 一加6t：
                ///       日志明文10万条存储测试耗时：34秒， 34975毫秒
                ///       日志明文追加存储测试耗时：0秒， 0毫秒
                /// Android: 华为mate 8：
                ///       日志明文10万条存储测试耗时：100秒， 100220毫秒
                ///       日志明文追加存储测试耗时：0秒， 1毫秒
                /// Android: 魅蓝3s：
                ///       日志明文10万条存储测试耗时：261秒， 261031毫秒
                ///       日志明文追加存储测试耗时：0秒， 4毫秒
              },
              child: const Text('日志明文存储测试'),
            ),
            TextButton(
              onPressed: () async {
                _startTimer();
                // 1. 创建或读取日志文件
                String directoryPath = await Utils.getDirectoryPath();
                String dateStr = DateUtil.formatDate(DateTime.now(),
                    format: DateFormats.y_mo_d);
                File file = File(
                    "$directoryPath${Platform.pathSeparator}logs${Platform.pathSeparator}encrypt_$dateStr.log");
                if (!file.existsSync()) {
                  await file.create();
                }
                Log.d('file: $file');
                for (int i = 0; i < 10000; i++) {
                  var randomStr = _getRandomStr(10);
                  await file.writeAsString(_getEncryptLogStr(randomStr),
                      mode: FileMode.append);
                }
                _endTimer(bizTag: '日志加密1万条存储测试');

                _startTimer();
                await file.writeAsString(_getEncryptLogStr(_getRandomStr(100)),
                    mode: FileMode.append);
                _endTimer(bizTag: '日志加密追加存储测试');

                ///Android： 一加6t
                ///       日志加密10万条存储测试耗时：67秒， 67112毫秒
                ///       日志加密追加存储测试耗时：0秒， 1毫秒
                ///Android： 华为mate8：
                ///       日志加密10万条存储测试耗时：141秒， 141403毫秒
                ///       日志加密追加存储测试耗时：0秒， 1毫秒
                ///Android： 魅蓝3s：
                ///       日志加密10万条存储测试耗时：298秒， 298671毫秒
                ///       日志加密追加存储测试耗时：0秒， 3毫秒
              },
              child: const Text('日志加密存储测试'),
            ),
            Gaps.vGap10,
            TextButton(
              onPressed: () async {
                _startTimer();
                // 1. 创建或读取日志文件
                String directoryPath = await Utils.getDirectoryPath();
                String dateStr = DateUtil.formatDate(DateTime.now(),
                    format: DateFormats.y_mo_d);
                File file = File(
                    "$directoryPath${Platform.pathSeparator}logs${Platform.pathSeparator}encrypt_$dateStr.log");
                if (!file.existsSync()) {
                  await file.create();
                }
                if (file.existsSync()) {
                  var path = file.path;
                  var filename = path.split("/").last;
                  // 创建隔离线程isolate来完成日志解密读写操作，避免日志文件较大时UI卡顿问题
                  await decryptLogOnIsolate(filename);
                  Log.d('end decrypt log');
                } else {
                  Log.d('Encrypt Log not exist');
                }
                _endTimer(bizTag: '日志解密1万条存储测试');

                /// Android 一加6t  日志解密10万条存储测试耗时：2秒， 2602毫秒
                /// Android 华为mate8 日志解密10万条存储测试耗时：4秒， 4202毫秒
              },
              child: const Text('日志解密读取测试'),
            ),
            Gaps.vGap10,
          ],
        ),
      ),
    );
  }

  // 工作子线程的任务
  static dataLoader(SendPort sendPort) {
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    // 监听所有App端发来的消息，并进行处理，可以传key，参数，做区分处理等等
    receivePort.listen((msg) async {
      String fileName = msg[0];
      String? dirPath = msg[1];
      Log.d('dataLoader: $fileName');
      SendPort callbackPort = msg[2];
      // 回调返回值给调用者
      await decryptLog(fileName, dirPath);
      callbackPort.send(null);
      Log.d('Loader5');
    });
  }

  Future decryptLogOnIsolate(String fileName) async {
    // 获取App线程
    ReceivePort receivePort = ReceivePort();
    // 创建工作子线程
    await Isolate.spawn(dataLoader, receivePort.sendPort);
    // 获取工作子线程的port
    SendPort sendPort = await receivePort.first;
    String directoryPath = await Utils.getDirectoryPath();
    // 任务监听器
    ReceivePort isolateReceivePort = ReceivePort();
    Log.d('sendReceive before send');
    // 发送要做的事情
    sendPort.send([fileName, directoryPath, isolateReceivePort.sendPort]);
    Log.d('sendReceive after send');
    // 接收到返回值，返回给调用者
    return isolateReceivePort.first;
  }

  static Future<void> decryptLog(String fileName, String? dirPath) async {
    Log.d('start decryptLog');
    // 选择需解密日志
    String? directoryPath = dirPath;
    File file = File(
        "$directoryPath${Platform.pathSeparator}logs${Platform.pathSeparator}$fileName");
    File decryptFile = File(
        "$directoryPath${Platform.pathSeparator}logs${Platform.pathSeparator}${fileName.substring(fileName.indexOf("_") + 1)}");
    if (!file.existsSync()) {
      await file.create();
    }
    if (decryptFile.existsSync()) {
      decryptFile.delete();
      await decryptFile.create();
    }
    if (await file.exists()) {
      List<String> lines = await file.readAsLines();
      Log.d('start decrypt log：');
      for (var line in lines) {
        if (line.toString().length > 9) {
          /// 解密及解密结果
          String encryptStr = line.toString().substring(9).trimRight();
          final decrypted = encrypt_lib.Encrypter(encrypt_lib
              .AES(encrypt_lib.Key.fromUtf8(Constant.aesEncryptKey)))
              .decrypt64(encryptStr, iv: encrypt_lib.IV.fromLength(16));
          decryptFile.writeAsStringSync(
              "${line.toString().substring(0, 9)} $decrypted\n",
              mode: FileMode.append);
        }
      }
      Log.d('end decrypt log');
    } else {
      Log.d('Encrypt Log not exist');
    }
  }

  DateTime? _startTime;

  void _startTimer() {
    _startTime = DateTime.now();
  }

  void _endTimer({String bizTag = ""}) {
    if (_startTime == null) {
      Log.d('未初始化Timer');
      return;
    }
    DateTime endTime = DateTime.now();
    var difference = endTime.difference(_startTime!);
    Log.d('$bizTag耗时：${difference.inSeconds}秒， ${difference.inMilliseconds}毫秒');
  }

  final String randomStrForTest =
      "赵钱孙李周吴郑王冯陈褚卫蒋沈韩杨朱秦尤许何吕施张孔曹严华金魏陶姜戚谢邹喻柏水窦章云苏潘葛奚范彭郎鲁韦昌马苗凤花方俞任袁柳酆鲍史唐费廉岑薛雷贺倪汤滕殷罗毕郝邬安常乐于时傅皮卞齐康伍余元卜顾孟平黄和穆萧尹姚邵湛汪祁毛禹狄米贝明臧计伏成戴谈宋茅庞熊纪舒屈项祝董梁杜阮蓝闵席季麻强贾路娄危江童颜郭梅盛林刁钟徐邱骆高夏蔡田樊胡凌霍虞万支柯昝管卢莫经房裘缪干解应宗丁宣贲邓郁单杭洪包诸左石崔吉钮龚程嵇邢滑裴陆荣翁荀羊於惠甄曲家封芮羿储靳汲邴糜松井段富巫乌焦巴弓牧隗山谷车侯宓蓬全郗班仰秋仲伊宫宁仇栾暴甘钭厉戎祖武符刘景詹束龙叶幸司韶郜黎蓟薄印宿白怀蒲邰从鄂索咸籍赖卓蔺屠蒙池乔阴鬱胥能苍双闻莘党翟谭贡劳逄姬申扶堵冉宰郦雍卻璩桑桂濮牛寿通边扈燕冀郏浦尚农温别庄晏柴瞿阎充慕连茹习宦艾鱼容向古易慎戈廖庾终暨居衡步都耿满弘匡国文寇广禄阙东欧殳沃利蔚越夔隆师巩厍聂晁勾敖融冷訾辛阚那简饶空曾毋沙乜养鞠须丰巢关蒯相查后荆红游竺权逯盖益桓公万俟司马上官欧阳夏侯诸葛闻人东方赫连皇甫尉迟公羊澹台公冶宗政濮阳淳于单于太叔申屠公孙仲孙轩辕令狐钟离宇文长孙慕容鲜于闾丘司徒司空丌官司寇仉督子车颛孙端木巫马公西漆雕乐正壤驷公良拓跋夹谷宰父谷梁晋楚闫法汝鄢涂钦段干百里东郭南门呼延归海羊舌微生岳帅缑亢况郈有琴梁丘左丘东门西门商牟佘佴伯赏南宫墨哈谯笪年爱阳佟第五言福百家姓终";

  /// WangHL：获取指定长度的随机中文字符串，测试日志加密存储使用
  String _getRandomStr(int length) {
    StringBuffer randomStr = StringBuffer();
    for (int i = 0; i < length; i++) {
      randomStr.write(randomStrForTest[Random().nextInt(62)]);
    }
    return randomStr.toString();
  }

  /// WangHL 拼装日志明文字符串
  String _getLogStr(String msg) {
    return "${DateUtil.formatDate(DateTime.now(), format: DateFormats.h_m_s)} $msg\n";
  }

  /// WangHL 拼装日志加密字符串
  String _getEncryptLogStr(String msg) {
    final key = encrypt_lib.Key.fromUtf8(Constant.aesEncryptKey);
    final iv = encrypt_lib.IV.fromLength(16);
    final encrypter = encrypt_lib.Encrypter(encrypt_lib.AES(key));

    /// 加密及加密结果
    final encrypted = encrypter.encrypt(msg, iv: iv);
    return "${DateUtil.formatDate(DateTime.now(), format: DateFormats.h_m_s)} ${encrypted.base64}\n";
  }
}
