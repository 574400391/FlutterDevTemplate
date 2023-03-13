import 'package:flutter_dev_template/pigeon.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';

typedef NativeApiCompleteCallBack = void Function(Message resultMsg);

class MyNativeApi extends NativeApi {

  static const String _tag = 'MyNativeApi';

  NativeApiCompleteCallBack?
      onDoSomethingResult; // Native层执行完成doSomethingResult任务后返回结果回调

  MyNativeApi({
    this.onDoSomethingResult,
  });

  @override
  void doSomethingResult(Message msgResult) {
    Log.d("doSomethingResult: ${msgResult.encode().toString()}",
        tag: _tag, saveLog: true);
    onDoSomethingResult!(msgResult);
  }
}
