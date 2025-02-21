import 'package:get/get.dart';
import 'package:movie_app/core/widgets/custom_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/shared/presentation/controllers/current_user_controller.dart';

class HelperFunctions {
  static String truncateText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  static Future<void> showCustomModalBottomSheet({
    required BuildContext context,
    required Widget child,
    bool showDragHandler = false,
  }) async {
    showModalBottomSheet(
      constraints: const BoxConstraints(minWidth: double.infinity),
      showDragHandle: showDragHandler,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 40,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: child,
        );
      },
    );
  }

  static void showLogoutDialog(BuildContext context) async {
    return HelperFunctions.showCustomModalBottomSheet(
      context: context,
      child: CustomModalBottomSheet(
        title: "logout",
        description: "areYouSureLogout",
        confirmButtonText: "yesLogout",
        onConfirm: () {
          Navigator.pop(context);
          Get.find<CurrentUserController>().logUserOut();
        },
        onCancel: () {
          Navigator.pop(context);
        },
        cancelButtonText: "cancel",
      ),
    );
  }
}
