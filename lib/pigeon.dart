// Autogenerated from Pigeon (v9.0.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class Message {
  Message({
    this.type,
    this.message,
  });

  int? type;

  String? message;

  Object encode() {
    return <Object?>[
      type,
      message,
    ];
  }

  static Message decode(Object result) {
    result as List<Object?>;
    return Message(
      type: result[0] as int?,
      message: result[1] as String?,
    );
  }
}

class _ApiCodec extends StandardMessageCodec {
  const _ApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Message) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return Message.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

/// Flutter -> Native(Android/iOS)
class Api {
  /// Constructor for [Api].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  Api({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _ApiCodec();

  /// 无需传参
  Future<void> doSomethingNoParam() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.Api.doSomethingNoParam', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// 传递参数
  Future<void> doSomethingWithParam(Message arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.Api.doSomethingWithParam', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_msg]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}

class _NativeApiCodec extends StandardMessageCodec {
  const _NativeApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Message) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return Message.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

/// Native(Android/iOS) -> Flutter
abstract class NativeApi {
  static const MessageCodec<Object?> codec = _NativeApiCodec();

  /// native异步完成任务后发送结果给flutter层
  void doSomethingResult(Message msgResult);

  static void setup(NativeApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.NativeApi.doSomethingResult', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.NativeApi.doSomethingResult was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final Message? arg_msgResult = (args[0] as Message?);
          assert(arg_msgResult != null,
              'Argument for dev.flutter.pigeon.NativeApi.doSomethingResult was null, expected non-null Message.');
          api.doSomethingResult(arg_msgResult!);
          return;
        });
      }
    }
  }
}
