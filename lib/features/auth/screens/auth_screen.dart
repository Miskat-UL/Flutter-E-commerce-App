import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constans/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.Signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  void signUpUser() async {
    authService.signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      context: context,
    );
  }

  void _logInUser() async {
    authService.signInUser(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                tileColor: _authMode == AuthMode.Signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: Text('Create account'),
                leading: Radio(
                    value: AuthMode.Signup,
                    groupValue: _authMode,
                    onChanged: (AuthMode? val) {
                      setState(() {
                        _authMode = val!;
                      });
                    }),
              ),
              if (_authMode == AuthMode.Signup)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            onBack: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                            text: 'Create account'),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _authMode == AuthMode.Login
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text('Login'),
                leading: Radio(
                    value: AuthMode.Login,
                    groupValue: _authMode,
                    onChanged: (AuthMode? val) {
                      setState(() {
                        _authMode = val!;
                      });
                    }),
              ),
              if (_authMode == AuthMode.Login)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        // CustomTextField(
                        //   controller: _nameController,
                        //   hintText: 'Name',
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            onBack: () {
                              if (_loginFormKey.currentState!.validate()) {
                                _logInUser();
                              }
                            },
                            text: 'Login'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
