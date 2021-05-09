import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_e/providers/auth_state.dart';
import 'package:salon_e/sevices/aws_service.dart';
import 'package:salon_e/sevices/dimension.dart';
import 'package:salon_e/sevices/navigation_service.dart';
import 'package:salon_e/ui/auth/login.dart';
import 'package:salon_e/ui/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  AwsService _awsService = AwsService();
  AuthState _authState = AuthState();

  _initApp() async {
    await _awsService.configureAmplify();
    await _authState.setUser();

    Future.delayed(Duration(seconds: 4), () {
      if (_authState.user == null) {
        NavigationService.navigateToWidget(Login());
      } else {
        NavigationService.navigateToWidget(ProfileScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  @override
  Widget build(BuildContext context) {
    /// SET THE HEIGHT AND WIDTH
    DimensionService().height = MediaQuery.of(context).size.height;
    DimensionService().width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.redAccent[700],
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.redAccent[700],
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          height: DimensionService().deviceHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svgs/app_logo.svg"),
            ],
          ),
        ),
      ),
    );
  }
}
