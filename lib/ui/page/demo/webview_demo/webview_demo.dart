import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDemoPage extends StatefulWidget {
  final String path;
  final bool useLocalHtml;

  const WebViewDemoPage(this.path, this.useLocalHtml, {super.key});

  @override
  WebViewDemoPageState createState() => WebViewDemoPageState();
}

const htmlString = '''
<!DOCTYPE html>
<head>
<title>webview demo</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, 
  maximum-scale=1.0, user-scalable=no,viewport-fit=cover" />
<style>
*{
  margin:0;
  padding:0;
}
body{
   background:#BBDFFC;  
   display:flex;
   justify-content:center;
   align-items:center;
   height:200px;
   color:#C45F84;
   font-size:20px;
}
</style>
</head>
<html>
<body>
<div >This is htmlString</div>
<script>
    const resizeObserver = new ResizeObserver(entries =>
          Report.postMessage(document.scrollingElement.scrollHeight))
    resizeObserver.observe(document.body)
</script>
</body>
</html>
''';

class WebViewDemoPageState extends State<WebViewDemoPage> {
  late final WebViewController controller;
  double height = 0;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    if (widget.useLocalHtml) {
      controller.loadFlutterAsset(widget.path);
    } else {
      controller.loadRequest(Uri.parse(widget.path));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Webview Simple Example'), actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            controller.reload();
          },
        ),
      ]),
      body: WebViewWidget(controller: controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
