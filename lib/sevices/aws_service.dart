import 'dart:developer';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_flutter/amplify.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:salon_e/models/responce_model.dart';
import 'package:salon_e/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:image_picker/image_picker.dart';
// import '../amplifyconfiguration.dart';

class AwsService {
  factory AwsService() => _instance;
  static final AwsService _instance = AwsService._internal();
  AwsService._internal();
  String _amplifyconfig = String.fromEnvironment("AMPLIFY_CONFIG");

  Future<ApiResponse> login(email, password) async {
    try {
      final res = await Amplify.Auth.signIn(username: email, password: password);
      return ApiResponse(success: res.isSignedIn);
    } on AuthException catch (e) {
      print(e.message);
      return ApiResponse(errors: e, message: e.message);
    } catch (e) {
      return ApiResponse(errors: e as Exception, message: e.toString());
    }
  }

  Future<ApiResponse> signUp(email, password) async {
    // String.fromEnvironment(name);
    try {
      Map<String, String> userAttributes = {
        'email': email,
        // 'phone_number': '+14164518953',
        // additional attributes as needed
      };
      SignUpResult res = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      print(res.nextStep);
      return ApiResponse(success: true);
    } on AuthException catch (e) {
      print(e.message);
      return ApiResponse(errors: e, message: e.message);
    } catch (e) {
      return ApiResponse(errors: e as Exception, message: e.toString());
    }
  }

  Future<ApiResponse> verifyCode(String otp, UserData user) async {
    try {
      print(user.email);
      SignUpResult res = await Amplify.Auth.confirmSignUp(username: user.email, confirmationCode: otp);
      // login UserData
      await Amplify.Auth.signIn(username: user.email, password: user.password);
      return ApiResponse(success: res.isSignUpComplete);
    } on AuthException catch (e) {
      print(e.message);
      return ApiResponse(errors: e, message: e.message);
    } catch (e) {
      return ApiResponse(errors: e as Exception, message: e.toString());
    }
  }

  Future<ApiResponse> resendOtp(UserData user) async {
    try {
      print(user.email);
      await Amplify.Auth.resendSignUpCode(username: user.email);

      await Amplify.Auth.signIn(username: user.email, password: user.password);
      return ApiResponse(success: true, message: "New Otp sent to email");
    } on AuthException catch (e) {
      print(e.message);
      return ApiResponse(errors: e, message: e.message);
    } catch (e) {
      return ApiResponse(errors: e as Exception, message: e.toString());
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
    print('_amplifyconfig_amplifyconfig_amplifyconfig');
    print(_amplifyconfig);
    Amplify.addPlugin(AmplifyAuthCognito());
    Amplify.addPlugin(AmplifyStorageS3());
    Amplify.addPlugin(AmplifyAnalyticsPinpoint());

    try {
      // if (!Amplify.isConfigured) await Amplify.configure(_amplifyconfig);
      print(Amplify.isConfigured);
    } on AmplifyAlreadyConfiguredException {
      print("Amplify was already configured. Was the app restarted?");
    }
  }

  Future<ApiResponse> logout() async {
    try {
      await Amplify.Auth.signOut();
      return ApiResponse(success: true, message: "Signed Out");
    } catch (e) {
      return ApiResponse(errors: e as Exception, message: e.toString());
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
      GetUrlResult result2 = await Amplify.Storage.getUrl(key: key);
      return result2.url;
    } catch (e) {
      return null;
    }
  }
}
