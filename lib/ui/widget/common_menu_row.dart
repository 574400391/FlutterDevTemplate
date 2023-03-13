import 'package:flutter/material.dart';
import 'package:flutter_dev_template/main.dart';
import 'package:flutter_dev_template/ui/res/colors.dart';
import 'package:flutter_dev_template/ui/res/dimens.dart';
import 'package:flutter_dev_template/ui/res/gaps.dart';
import 'package:flutter_dev_template/utils/resource_utils.dart';

class CommonMenuRow extends StatelessWidget {
  final Widget? page;
  final String? iconName;
  final String title;
  final String? pageName;
  final Object? arguments;
  final String? subString;
  final Function? onTap;

  const CommonMenuRow(
      {Key? key,
      this.iconName,
      required this.title,
      this.page,
      this.pageName,
      this.arguments,
      this.subString,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String subStr = '';
    if (subString != null) {
      subStr = subString!;
    }

    return Ink(
      //用这一层的目的是为了点击效果
      color: Colours.white, //底色
      child: InkWell(
        splashColor: Colours.ripple_color,
        onTap: throttle(() async {
          if (onTap != null) {
            onTap!();
          } else {
            pageName == null
                ? Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => page!))
                : Navigator.of(context)
                .pushNamed(pageName!, arguments: arguments);
          }
        }) as void Function()?, //波纹的颜色
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              iconName == null
                  ? Gaps.empty
                  : Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        ImageHelper.getAssetsPath(iconName),
                        width: 24,
                        height: 24,
                      ),
                    ),
              Text(
                title,
                style: const TextStyle(
                  color: Colours.text_222222,
                  fontSize: Dimens.font_sp14,
                ),
              ),
              // ),
              Gaps.hGap15,
              Expanded(
                child: Text(
                  subStr,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0x99000000)),
                ),
              ),
              Gaps.hGap15,
              Image.asset(
                ImageHelper.getAssetsPath("iv_right"),
                width: 12,
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
