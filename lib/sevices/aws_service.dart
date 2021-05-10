import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_flutter/amplify.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:salon_e/models/responce_model.dart';
import 'package:salon_e/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:image_picker/image_picker.dart';
import '../amplifyconfiguration.dart' as fig;

class AwsService {
  factory AwsService() => _instance;
  static final AwsService _instance = AwsService._internal();
  AwsService._internal();
  static const AMPLIFY_CONFIG = fig.amplifyconfig;
  // static const AMPLIFY_CONFIG = String.fromEnvironment('AMPLIFY_CONFIG', defaultValue: "Not Set");
  Future<AppResponse> login(email, password) async {
    try {
      final res = await Amplify.Auth.signIn(username: email, password: password);
      return AppResponse(success: res.isSignedIn);
    } on AuthException catch (e) {
      return AppResponse(errors: e, message: e.message);
    } catch (e) {
      return AppResponse(errors: e as Exception, message: e.toString());
    }
  }

  Future<AppResponse> signUp(email, password) async {
    try {
      Map<String, String> userAttributes = {'email': email};
      await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      return AppResponse(success: true);
    } on AuthException catch (e) {
      return AppResponse(errors: e, message: e.message);
    } catch (e) {
      return AppResponse(errors: e as Exception, message: e.toString());
    }
  }

  Future<AppResponse> verifyCode(String otp, UserData user) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(username: user.email, confirmationCode: otp);
      // login UserData
      await Amplify.Auth.signIn(username: user.email, password: user.password);
      return AppResponse(success: res.isSignUpComplete);
    } on AuthException catch (e) {
      return AppResponse(errors: e, message: e.message);
    } catch (e) {
      return AppResponse(errors: e as Exception, message: e.toString());
    }
  }

  Future<AppResponse> resendOtp(UserData user) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: user.email);
      return AppResponse(success: true, message: "New Otp sent to email");
    } on AuthException catch (e) {
      return AppResponse(errors: e, message: e.message);
    } catch (e) {
      return AppResponse(errors: e as Exception, message: e.toString());
    }
  }

  void recordEvent() async {
    AnalyticsEvent event = AnalyticsEvent('test');
    event.properties.addBoolProperty('boolKey', true);
    event.properties.addDoubleProperty('doubleKey', 10.0);
    event.properties.addIntProperty('intKey', 10);
    event.properties.addStringProperty('stringKey', 'stringValue');
    Amplify.Analytics.recordEvent(event: event);
  }

  Future<void> configureAmplify() async {
    Amplify.addPlugin(AmplifyAuthCognito());
    Amplify.addPlugin(AmplifyStorageS3());
    Amplify.addPlugin(AmplifyAnalyticsPinpoint());

    try {
      if (!Amplify.isConfigured) await Amplify.configure(AMPLIFY_CONFIG);
    } on AmplifyAlreadyConfiguredException {
      debugPrint("Amplify was already configured. Was the app restarted?");
    }
  }

  Future<AppResponse> logout() async {
    try {
      await Amplify.Auth.signOut();
      return AppResponse(success: true, message: "Signed Out");
    } catch (e) {
      return AppResponse(errors: e as Exception, message: e.toString());
    }
  }

  Future<void> uploadImage(ImageSource source, String key) async {
    final picker = ImagePicker();
    final file = await picker.getImage(source: source, imageQuality: 50);
    if (file != null) {
      await Amplify.Storage.uploadFile(key: key, local: File(file.path));
    }
  }

  Future<String?> getFileUrl(String key) async {
    try {
      GetUrlResult storageS3 = await Amplify.Storage.getUrl(key: key);
      return storageS3.url;
    } catch (e) {
      return null;
    }
  }
}
