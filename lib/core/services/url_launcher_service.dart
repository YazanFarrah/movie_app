import 'package:get/get.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/core/errors/strings.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrlService {
  static void openWeb(BuildContext context, url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        throw unexpectedFailureMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  static void makeAPhoneCall(BuildContext context, phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (!await launchUrl(phoneUri)) {
        throw unexpectedFailureMessage;
      }
    } catch (error) {
      if (!context.mounted) return;
      return ToastUtils.showError(error.toString());
    }
  }

  static void sendEmail(BuildContext context, String emailAddress) async {
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: emailAddress,
        query: 'subject=Your Subject&body=Hello, I need assistance',
      );

      if (!await launchUrl(emailUri)) {
        throw unexpectedFailureMessage;
      }
    } catch (error) {
      if (!context.mounted) return;
      return ToastUtils.showError(error.toString());
    }
  }

  static void openWhatsapp(BuildContext context) async {
    final locale = Get.locale;
    final message = locale == const Locale("en") ? "Hello" : "مرحبا";

    try {
      final Uri whatsappUri = Uri.parse(
          'https://wa.me/${AppConstants.contactUsPhoneNumber}?text=${Uri.encodeComponent(message)}');

      if (!await launchUrl(whatsappUri)) {
        throw unexpectedFailureMessage;
      }
    } catch (error) {
      if (!context.mounted) return;
      return ToastUtils.showError(error.toString());
    }
  }
}
