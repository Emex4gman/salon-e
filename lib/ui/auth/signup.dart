import 'package:flutter/material.dart';
import 'package:salon_e/componets/app_bar.dart';
import 'package:salon_e/componets/custom_input.dart';
import 'package:salon_e/componets/salon_stateful_widget.dart';
import 'package:salon_e/models/user.dart';
import 'package:salon_e/sevices/aws_service.dart';
import 'package:salon_e/sevices/navigation_service.dart';
import '../../validator.dart';
import 'otp_screen.dart';

class SignUp extends SalonSatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends SalonSatefulWidgetState<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtr = TextEditingController();
  final _passwordCtr = TextEditingController();
  final _awsService = AwsService();

  void _signUp() async {
    isLoading = true;
    setState(() {});
    final res = await _awsService.signUp(_emailCtr.text, _passwordCtr.text);
    if (res.success) {
      NavigationService.navigateToWidget(OtpScreen(
        user: UserData(
          email: _emailCtr.text,
          password: _passwordCtr.text,
        ),
      ));
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
    return Scaffold(
      appBar: salonAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/app_logo.png"),
                        SizedBox(height: 25),
                        CustomInputField(
                          label: "Email",
                          field: 'email',
                          textController: _emailCtr,
                          validator: Validator.validateEmail,
                        ),
                        SizedBox(height: 10),
                        CustomInputField(
                          label: "Password",
                          textController: _passwordCtr,
                          validator: Validator.validatePassword,
                          hideText: true,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) _signUp();
                          },
                          child: Text("Sign Up"),
                        ),
                        TextButton(
                            onPressed: () {
                              NavigationService.goBack();
                            },
                            child: Text("Have have an account? Login"))
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailCtr.dispose();
    _passwordCtr.dispose();
    super.dispose();
  }
}
