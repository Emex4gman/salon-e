import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SampleProfie extends StatefulWidget {
  @override
  _SampleProfieState createState() => _SampleProfieState();
}

class _SampleProfieState extends State<SampleProfie> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: 'https://saloneverywhere.com/sample-profiles',
      ),
    );
  }
}
