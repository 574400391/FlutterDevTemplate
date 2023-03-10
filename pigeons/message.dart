import 'package:pigeon/pigeon.dart';

class Message {
  int? type; // 数据类型
  String? message; // 消息内容
}


/// Flutter -> Native(Android/iOS)
@HostApi()
abstract class Api {
  /// 无需传参
  void doSomethingNoParam();

  /// 传递参数
  void doSomethingWithParam(Message msg);
}

/// Native(Android/iOS) -> Flutter
@FlutterApi()
abstract class NativeApi {

  /// native异步完成任务后发送结果给flutter层
  void doSomethingResult(Message msgResult);
}
