import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../snack_bar.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);

  final String url;
  final String title;

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  final _controller = Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            NavigationControls(controller: _controller),
          ],
        ),
        body: WebViewStack(
          controller: _controller,
          url: widget.url,
        ),
      );
}

class WebViewStack extends StatefulWidget {
  const WebViewStack({
    required this.controller,
    Key? key,
    required this.url,
  }) : super(key: key);

  final Completer<WebViewController> controller;
  final String url;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  int _loadingPercentage = 0;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
            onWebViewCreated: (webViewController) =>
                widget.controller.complete(webViewController),
            onPageStarted: (url) => setState(() {
              _loadingPercentage = 0;
            }),
            onProgress: (progress) => setState(() {
              _loadingPercentage = progress;
            }),
            onPageFinished: (url) => setState(() {
              _loadingPercentage = 100;
            }),
            javascriptMode: JavascriptMode.unrestricted,
          ),
          if (_loadingPercentage < 100)
            LinearProgressIndicator(
              value: _loadingPercentage / 100.0,
            ),
        ],
      );
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) => FutureBuilder<WebViewController>(
        future: controller.future,
        builder: (context, snapshot) {
          final WebViewController? controller = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done ||
              controller == null) {
            return Row(
              children: const <Widget>[
                Center(
                  child: Tooltip(
                    message: 'Previous page',
                    child: Icon(Icons.arrow_circle_left_sharp),
                  ),
                ),
                Center(
                  child: Tooltip(
                    message: 'Refresh',
                    child: Icon(Icons.refresh),
                  ),
                ),
              ],
            );
          }

          return Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_circle_left_sharp),
                onPressed: () async {
                  if (await controller.canGoBack()) {
                    await controller.goBack();
                  } else {
                    mySnackBar(context, 'This is the actual article page!');
                  }
                },
                tooltip: 'Previous page',
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => controller.reload(),
                tooltip: 'Refresh',
              ),
            ],
          );
        },
      );
}
