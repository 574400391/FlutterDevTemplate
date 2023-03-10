import 'package:flutter/material.dart';
import 'package:flutter_dev_template/ui/res/gaps.dart';

class LoadingDialog extends StatefulWidget {
  LoadingDialog({Key? key, this.valueColor, this.content}) : super(key: key);
  final Color? valueColor;
  final String? content;
  final _LoadingDialogState state = _LoadingDialogState();

  @override
  _LoadingDialogState createState() => _LoadingDialogState();

  bool isLoading() {
    return state._isActive;
  }
}

class _LoadingDialogState extends State<LoadingDialog> {
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _isActive = true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false), //禁止返回
        child: Material(
          // 设置透明
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              width: 290,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: CircularProgressIndicator(
                          strokeWidth: 4.0,
                          valueColor: AlwaysStoppedAnimation(widget.valueColor),
                        ),
                      )),
                  widget.content == null
                      ? Gaps.empty
                      : Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: Text(widget.content!),
                    ),
                  )
                ],
              ),
            ),
          )
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _isActive = false;
  }
}
