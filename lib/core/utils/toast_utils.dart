import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastUtils {
  // Show error snackbar
  static void showError(String error) {
    // Ensure that the controller is initialized before calling `closeAllSnackbars`
    if (Get.isSnackbarOpen) {
      // You can delay this action to allow the snackbar controller to be ready.
      Future.delayed(Duration.zero, () => Get.closeAllSnackbars());
    }
    Get.rawSnackbar(
      message: error,
      backgroundColor: Colors.red.withValues(alpha: 0.9),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }

  // Show success snackbar
  static void showSuccess(String message) {
    if (Get.isSnackbarOpen) {
      // Same as above, make sure to close snackbars with a delay to ensure initialization
      Future.delayed(Duration.zero, () => Get.closeAllSnackbars());
    }
    Get.rawSnackbar(
      message: message,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }
}
