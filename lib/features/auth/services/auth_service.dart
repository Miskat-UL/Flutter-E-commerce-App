import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_widget_bar.dart';
import 'package:amazon_clone/constans/error_handler.dart';
import 'package:amazon_clone/constans/global_variables.dart';
import 'package:amazon_clone/constans/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../home/home_screen.dart';

class AuthService {
  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        type: '',
        token: '',
        address: '',
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/user'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandler(
          response: res,
          onSuccess: () {
            showSnackbar(
                context: context, text: "Account created successfully");
          },
          context: context);
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandler(
          response: res,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          },
          context: context);
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenValidation'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var res = jsonDecode(tokenRes.body);

      if (res == true) {
        http.Response httpRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(httpRes.body);
      }

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
      // print(res.body);
      // httpErrorHandler(
      //     response: res,
      //     onSuccess: () async {
      //       SharedPreferences prefs = await SharedPreferences.getInstance();
      //       await prefs.setString(
      //           'x-auth-token', jsonDecode(res.body)['token']);
      //       Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //       Navigator.pushNamedAndRemoveUntil(
      //           context, HomeScreen.routeName, (route) => false);
      //     },
      //     context: context);
    } catch (e) {
      showSnackbar(context: context, text: e.toString());
    }
  }
}
