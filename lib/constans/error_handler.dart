import 'dart:convert';

import 'package:amazon_clone/constans/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required VoidCallback onSuccess,
  required BuildContext context,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackbar(context: context, text: jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackbar(context: context, text: jsonDecode(response.body)['error']);
      break;
    default:
      showSnackbar(context: context, text: response.body);
      break;
  }
}
