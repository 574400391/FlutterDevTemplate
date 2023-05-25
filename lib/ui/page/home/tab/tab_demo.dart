import 'package:flutter/material.dart';
import 'package:flutter_dev_template/config/constant.dart';
import 'package:flutter_dev_template/pigeon.dart';
import 'package:flutter_dev_template/ui/page/demo/db_demo/db_demo_page.dart';
import 'package:flutter_dev_template/ui/page/demo/file_demo/file_demo.dart';
import 'package:flutter_dev_template/ui/page/demo/webview_demo/webview_demo.dart';
import 'package:flutter_dev_template/ui/widget/common_menu_row.dart';
import 'package:flutter_dev_template/utils/my_native_api.dart';
import 'package:flutter_dev_template/utils/show_msg_mixin.dart';
import 'package:oktoast/oktoast.dart';

class TabDemoPage extends StatefulWidget {
  const TabDemoPage({super.key});

  @override
  TabDemoPageState createState() => TabDemoPageState();
}

class TabDemoPageState extends State<TabDemoPage> with ShowMsgMixin {
  Api api = Api();

  @override
  void initState() {
    super.initState();
    // 监听NativeApi
    NativeApi.setup(MyNativeApi(onDoSomethingResult: (Message msgResult) {
      closeLoading();
      showToast('Native返回信息：${msgResult.encode().toString()}');
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo'), centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CommonMenuRow(
                title: '编译版本信息',
                subString: Constant.currentBuildName,
                onTap: () {
                  showToast('编译版本：${Constant.currentBuildName}');
                },
              ),
              CommonMenuRow(
                title: 'MethodChannel',
                subString: '直接发送信息',
                onTap: () {
                  showLoading(msg: '等待Native层处理...');
                  api.doSomethingNoParam();
                }
              ),
              CommonMenuRow(
                title: 'MethodChannel',
                subString: '发送信息携带参数',
                onTap: () {
                  showLoading(msg: '等待Native层处理...');
                  var message = Message()
                    ..type = 0
                    ..message = '发送信息携带参数测试';
                  api.doSomethingWithParam(message);
                }
              ),
              const CommonMenuRow(
                  title: '数据库操作示例',
                  page: DbDemoPage(),
              ),
              const CommonMenuRow(
                title: '文件存储示例',
                page: FileDemo(),
              ),
              // const CommonMenuRow(
              //   title: 'WebView示例--加载本地静态资源',
              //   page: WebViewDemoPage('assets/www2/index.html', true),
              // ),
              const CommonMenuRow(
                title: 'WebView示例--加载h5在线资源',
                page: WebViewDemoPage('http://192.168.31.9:5173/', false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
