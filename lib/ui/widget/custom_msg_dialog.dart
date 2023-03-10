import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_template/ui/res/gaps.dart';

/// 点击确认按钮事件回调
typedef OnConfirmCallback = Function();

/// 点击取消按钮事件回调
typedef OnCancelCallback = Function();

/// 滑动返回事件回调
typedef OnClipBackCallback = Function();

class CustomMsgDialog extends StatefulWidget {
  const CustomMsgDialog(
      {Key? key,
      this.title,
      this.msg,
      this.canTapBackgroundCancel = true,
      this.singleBtn = false, // 默认展示两个按钮
      this.cancelBtnText,
      this.confirmBtnText,
      this.customWidget,
      required this.onConfirmCallback,
      required this.onCancelCallback,
      required this.onClipBackCallback})
      : super(key: key);

  final String? title;
  final String? msg;
  final bool canTapBackgroundCancel;
  final OnConfirmCallback onConfirmCallback;
  final OnCancelCallback? onCancelCallback;
  final OnClipBackCallback onClipBackCallback;
  final bool singleBtn;
  final String? cancelBtnText;
  final String? confirmBtnText;
  final Widget? customWidget;

  @override
  _CustomMsgDialogState createState() => _CustomMsgDialogState();
}

class _CustomMsgDialogState extends State<CustomMsgDialog> {
  bool _canTapBackgroundCancel = false;

  @override
  void initState() {
    super.initState();
    _canTapBackgroundCancel = widget.canTapBackgroundCancel;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (_canTapBackgroundCancel) {
            // 如果支持滑动返回时取消dialog展示，则发送事件回调
            widget.onClipBackCallback();
          }
          return Future.value(_canTapBackgroundCancel);
        }, //禁止返回
        child:
            Material(type: MaterialType.transparency, child: customDialog()));
  }

  /// 自定义的dialog
  Widget customDialog() {
    return Center(
      child: Container(
          width: 290,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF8F8F8),
                ),
                alignment: Alignment.center,
                child: Text(widget.title!),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: widget.customWidget ??
                    Text(
                      widget.msg!,
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF333333)),
                    ),
              ),
              const Divider(
                height: 1,
                color: Color(0xFFededed),
              ),
              Container(
                height: 44,
                constraints: const BoxConstraints(
                  minWidth: double.infinity, //宽度尽可能大
                ),
                child: Row(
                  children: [
                    widget.singleBtn
                        ? Gaps.empty
                        : Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                widget.onCancelCallback!();
                              },
                              child: Text(
                                widget.cancelBtnText!,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6e6e70)),
                              ),
                            )),
                    widget.singleBtn
                        ? Gaps.empty
                        : const VerticalDivider(
                            width: 2,
                            color: Color(0xFFededed),
                          ),
                    Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            widget.onConfirmCallback();
                          },
                          child: Text(widget.confirmBtnText!,
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF20a0e9))),
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
