import 'package:flutter/foundation.dart';

String? uValidator({
  @required String? value,
  bool isRequired = false,
  bool isEmail = false,
  int? minLength,
  String? match,
}) {
  if (isRequired) {
    if (value!.isEmpty) {
      return 'Required';
    }
    if (isEmail) {
      if (!value.contains('@') || !value.contains('.')) {
        return 'Invalid Email';
      }
    }
    if (minLength != null) {
      if (value.length < minLength) {
        return 'Min $minLength character';
      }
    }
  }
  if (match != null) {
    if (value != match) {
      return 'Password not match!';
    }
  }
  return null;
}
