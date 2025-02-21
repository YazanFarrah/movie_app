import 'package:get/get.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension ClearClose on RxList {
  void clearClose() {
    clear();
    close();
  }
}
