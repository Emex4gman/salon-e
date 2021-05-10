import 'package:flutter/material.dart';
import 'package:salon_e/componets/custom_input.dart';
import 'package:salon_e/componets/salon_stateful_widget.dart';
import 'package:salon_e/models/user.dart';
import 'package:salon_e/sevices/aws_service.dart';
import 'package:salon_e/sevices/navigation_service.dart';
import 'package:salon_e/ui/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../validator.dart';

class OtpScreen extends SalonSatefulWidget {
  final UserData user;
  OtpScreen({Key? key, required this.user}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends SalonSatefulWidgetState<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpCtr = TextEditingController();

  final _awsService = AwsService();

  void _verifyCode() async {
    isLoading = true;
    setState(() {});
    final res = await _awsService.verifyCode(_otpCtr.text, widget.user);
    if (res.success) {
      NavigationService.goBack();
      NavigationService.replaceWidget(ProfileScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${res.message}"),
          backgroundColor: Colors.redAccent[700],
        ),
      );
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 12,
                          margin: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                SvgPicture.asset("assets/svgs/app_logo.svg"),
                                SizedBox(height: 25),
                                CustomInputField(
                                  label: "Enter OTP",
                                  field: 'number',
                                  validator: Validator.validateOtp,
                                  textController: _otpCtr,
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() == true) {
                                      _verifyCode();
                                    }
                                  },
                                  child: Text("Confirm"),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Resend Code",
                                      style: TextStyle(color: Colors.grey),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
