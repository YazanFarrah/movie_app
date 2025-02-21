import 'package:get/get.dart';
import 'package:movie_app/core/utils/regex_patterns.dart';
import 'package:flutter/material.dart';

String? emailValidator(String? value) {
  RegExp emailRegex = RegExp(RegexPatterns.emailPattern);

  // Check if the value is a valid email
  if ((value != null || value!.isEmpty) && emailRegex.hasMatch(value)) {
    return null; // Valid email, return null
  } else {
    return "";
  }
}

String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return Get.locale == const Locale('en')
        ? "Phone number can't be empty"
        : "رقم الهاتف مطلوب";
  }

  // Check if the value is a valid phone number
  if (isPhoneNumber(value)) {
    return null; // Valid phone number, return null
  } else {
    return Get.locale == const Locale('en')
        ? "Invalid phone number"
        : "رقم هاتف غير صحيح";
  }
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return Get.locale == const Locale('en')
        ? "Name can't be empty"
        : "الاسم مطلوب";
  }
  return null;
}

String? isNotEmpty(String value) {
  if (value.isEmpty) {
    return "";
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value != null && value.length < 8) {
    return "";
  }

  return null;
}

String? confirmPasswordValidator(
  String? value,
  String? password,
  BuildContext context,
) {
  if (value == null || value.isEmpty) {
    return "";
  } else if (value != password) {
    return "passwordDoesntMatch";
  }
  return null;
}

bool isEmail(String value) {
  RegExp emailRegex = RegExp(RegexPatterns.emailPattern);
  return emailRegex.hasMatch(value);
}

bool isPhoneNumber(String value) {
  // Remove any '+' from the phone number before checking
  String cleanedNumber = value.replaceAll('+', '');

  // Check if the cleaned number contains only numeric characters
  RegExp onlyNumbersRegex = RegExp(RegexPatterns.onlyNumbers);
  if (onlyNumbersRegex.hasMatch(cleanedNumber)) {
    return true;
  }

  // Check if the cleaned number contains at least one numeric character
  RegExp containsNumbersRegex = RegExp(RegexPatterns.containsNumbers);
  return containsNumbersRegex.hasMatch(cleanedNumber);
}
