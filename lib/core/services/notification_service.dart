import 'dart:developer';

import 'package:movie_app/config/constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  void init() async {
    OneSignal.Notifications.canRequest().then((shouldRequest) {
      if (shouldRequest) {
        return;
      } else {
        OneSignal.Notifications.requestPermission(true).then((hasPermission) {
          log(
            hasPermission == true
                ? "Accepted notifications"
                : "Declined notifications",
          );
        });
      }
    });

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(AppConstants.notificationID);

    OneSignal.Notifications.addPermissionObserver((state) {
      log("Has permission $state");
    });
  }

  void enableNotification() {
    OneSignal.User.pushSubscription.optIn();
  }

  void disableNotification() {
    OneSignal.User.pushSubscription.optOut();
  }
}
