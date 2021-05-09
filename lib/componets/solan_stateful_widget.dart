// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:salon_e/providers/auth_state.dart';
import 'package:salon_e/sevices/dimension.dart';

abstract class SalonSatefulWidget extends StatefulWidget {
  SalonSatefulWidget({Key? key}) : super(key: key);
}

abstract class SalonSatefulWidgetState<Page extends SalonSatefulWidget> extends State<Page> {
  AuthUser? get user => AuthState().user;
  int currentPage = 1;
  int lastPage = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  double get height => DimensionService().deviceHeight;
  double get width => DimensionService().deviceWidth;
}
