import 'package:flutter/material.dart';
import 'package:flutter_dev_template/ui/res/colors.dart';
import 'package:flutter_dev_template/ui/widget/custom_msg_dialog.dart';
import 'package:flutter_dev_template/ui/widget/loading_dialog.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';
import 'package:flutter_dev_template/utils/toast_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// WangHL: StatefulWidget可以使用该State来控制Msg弹窗逻辑和Loading逻辑
mixin ShowMsgMixin<T extends StatefulWidget> on State<T> {
  bool _isShowLoading = false;
  bool _isShowSimpleLoading = false; //不带文字的简单的弹出
  bool _isShowDialog = false;

  BuildContext getContext() {
    return context;
  }

  void showErrorMsg({
    required String? title,
    String? msg = '',
    bool singleBtn = true,
    // String cancelBtnText = '确认',
    String confirmBtnText = '确认',
    bool canTapBackgroundCancel = true,
    OnCancelCallback? onCancelCallback,
  }) {
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      showDialog(
          context: context,
          builder: (_) => Scaffold(
                backgroundColor: Colors.transparent,
                body: CustomMsgDialog(
                  title: title,
                  canTapBackgroundCancel: canTapBackgroundCancel,
                  msg: msg,
                  singleBtn: singleBtn,
                  confirmBtnText: confirmBtnText,
                  // cancelBtnText: cancelBtnText,
                  onClipBackCallback: () {
                    if (canTapBackgroundCancel) {
                      closeMsgDialog();
                    }
                  },
                  onCancelCallback: () {
                    closeMsgDialog();
                  },
                  onConfirmCallback: () {
                    closeMsgDialog();
                  },
                ),
              ));
    }
  }

  /// title 对话框标题
  /// customWidget 自定义对话框展示内容
  /// msg 对话框文本内容（如果customWidget为空则展示文本信息）
  /// canTapBackgroundCancel 是否允许点击外侧区域或者返回键取消对话框展示
  /// singleBtn 是否展示单按钮（单按钮情况使用 confirmBtnText 和 onConfirmCallback）
  /// confirmBtnText 右侧按钮文本
  /// cancelBtnText 左侧按钮文本
  /// onConfirmCallback 右侧按钮点击事件
  /// onCancelCallback 左侧按钮点击事件
  void showMsgDialog(
      {required String title,
      String? msg = '',
      required OnConfirmCallback onConfirmCallback,
      OnCancelCallback? onCancelCallback,
      bool canTapBackgroundCancel = true,
      bool singleBtn = false,
      String confirmBtnText = '确认',
      String cancelBtnText = '取消',
      Widget? customWidget}) {
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      showDialog(
          context: context,
          builder: (_) => Scaffold(
                backgroundColor: Colors.transparent,
                body: CustomMsgDialog(
                  title: title,
                  canTapBackgroundCancel: canTapBackgroundCancel,
                  msg: msg,
                  singleBtn: singleBtn,
                  onConfirmCallback: onConfirmCallback,
                  onCancelCallback: onCancelCallback,
                  confirmBtnText: confirmBtnText,
                  cancelBtnText: cancelBtnText,
                  customWidget: customWidget,
                  onClipBackCallback: () {
                    if (canTapBackgroundCancel) {
                      /// 如果支持滑动返回，会自动调用NavigatorUtils.pop(context); 导致_isShowDialog值没有更新，无法再次展示dialog
                      /// 拦截滑动返回事件回传给业务层，避免_isShowDialog值没有更新
                      onCancelCallback!();
                    }
                  },
                ),
              ));
    }
  }

  void closeMsgDialog() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).pop();
    }
  }

  void showLoading({String? msg}) {
    /// 避免重复弹出
    if (mounted && !_isShowLoading) {
      _isShowLoading = true;
      showDialog(context: context, builder: (_) => LoadingDialog(content: msg));
    }
  }

  void closeLoading() {
    Log.d('mounted: $mounted, _isShowLoading: $_isShowLoading');
    if (mounted && _isShowLoading) {
      _isShowLoading = false;
      Navigator.of(context).pop();
    }
  }

  void showSimpleLoading() {
    /// 避免重复弹出
    if (mounted && !_isShowSimpleLoading) {
      _isShowSimpleLoading = true;
      showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.transparent,
          builder: (_) => const SpinKitCircle(color: Colours.app_main));
    }
  }

  void closeSimpleLoading() {
    Log.d('mounted: $mounted, _isShowSimpleLoading: $_isShowSimpleLoading');
    if (mounted && _isShowSimpleLoading) {
      _isShowSimpleLoading = false;
      Navigator.of(context).pop();
    }
  }

  void showToast(String? string) {
    Toast.show(string);
  }

  showErrorDlg(String title, VoidCallback? Function() onCancel,
      VoidCallback? Function() onRetry) {
    showMsgDialog(
        title: '提示信息',
        msg: title,
        confirmBtnText: '重试',
        onCancelCallback: () {
          closeMsgDialog();
          onCancel();
        },
        onConfirmCallback: () {
          closeMsgDialog();
          onRetry();
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }
}
