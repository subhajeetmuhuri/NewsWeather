import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class WebViewWindows extends StatefulWidget {
  const WebViewWindows({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);

  final String url;
  final String title;

  @override
  State<WebViewWindows> createState() => _WebViewWindows();
}

class _WebViewWindows extends State<WebViewWindows> {
  final WebviewController _controller = WebviewController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    await _controller.initialize();
    _controller.url.listen((url) {});

    await _controller.setBackgroundColor(Colors.transparent);
    await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
    await _controller.loadUrl(widget.url);

    if (!mounted) return;
    setState(() {});
  }

  Widget compositeView(BuildContext context) {
    final double height = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;
    final double width = MediaQuery.of(context).size.width;

    if (!_controller.value.isInitialized) {
      return Container();
    } else {
      return SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            Webview(
              _controller,
              permissionRequested: _onPermissionRequested,
            ),
            StreamBuilder<LoadingState>(
              stream: _controller.loadingState,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == LoadingState.loading) {
                  return const LinearProgressIndicator();
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_circle_left_sharp),
                onPressed: () async => await _controller.goBack(),
                tooltip: 'Previous page',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => _controller.reload(),
                tooltip: 'Refresh',
              ),
            ),
            const SizedBox(
              width: 7.0,
            )
          ],
        ),
        body: Builder(
          builder: (context) => Center(
            child: compositeView(context),
          ),
        ),
      );

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }
}
