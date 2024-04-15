import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebView extends StatefulWidget {
  String title;
  String url;

  CommonWebView({super.key, required this.title, required this.url});

  @override
  State<CommonWebView> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  late WebViewController webViewController;

  @override
  void initState() {
    webViewController =WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(widget.url))
    ..enableZoom(true)
    ..clearCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title.toString(),
        ),
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
