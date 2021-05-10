import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar salonAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    brightness: Brightness.light,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    toolbarHeight: 0,
    backgroundColor: Colors.redAccent[700],
  );
}
