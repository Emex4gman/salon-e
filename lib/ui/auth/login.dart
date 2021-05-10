import 'package:flutter/material.dart';
import 'package:salon_e/componets/custom_input.dart';
import 'package:salon_e/componets/salon_stateful_widget.dart';
import 'package:salon_e/providers/auth_state.dart';
import 'package:salon_e/sevices/aws_service.dart';
import 'package:salon_e/sevices/navigation_service.dart';
import 'package:salon_e/ui/auth/signup.dart';
import 'package:salon_e/ui/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../validator.dart';

class Login extends SalonSatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends SalonSatefulWidgetState<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtr = TextEditingController(text: "emex4gman@gmail.com");
  final _passwordCtr = TextEditingController(text: "1234567890");

  final _awsService = AwsService();
  final _authState = AuthState();

  void _login() async {
    isLoading = true;
    setState(() {});
    final res = await _awsService.login(_emailCtr.text, _passwordCtr.text);
    if (res.success) {
      await _authState.setUser();
      NavigationService.navigateToWidget(ProfileScreen());
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
      body: SingleChildScrollView(
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
                      SvgPicture.asset("assets/svgs/app_logo.svg"),
                      SizedBox(height: 25),
                      CustomInputField(
                        label: "Email",
                        field: 'email',
                        validator: Validator.validateEmail,
                        textController: _emailCtr,
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        textController: _passwordCtr,
                        label: "Password",
                        validator: Validator.validatePassword,
                        hideText: true,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) _login();
                        },
                        child: Text("Login"),
                      ),
                      TextButton(
                        onPressed: () {
                          NavigationService.navigateToWidget(SignUp());
                        },
                        child: Text("Dont have an account? Signup"),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
