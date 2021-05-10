import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salon_e/sevices/navigation_service.dart';
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
      child: Stack(
        children: [
          WebView(
            initialUrl: 'https://saloneverywhere.com/sample-profiles',
          ),
          Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () => NavigationService.goBack(),
                child: Icon(
                  Icons.close,
                  size: 35,
                ),
              ))
        ],
      ),
    );
  }
}
