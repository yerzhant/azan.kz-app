import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(AzanApp());

class AzanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xF01BA2DD));

    return MaterialApp(
      title: 'Azan.kz',
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: WebView(
          initialUrl: 'https://azan.kz',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      onWillPop: () async {
        var c = await _controller.future;
        if (await c.canGoBack()) {
          await c.goBack();
          return false;
        }
        return true;
      },
    );
  }
}
