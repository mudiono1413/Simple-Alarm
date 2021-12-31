import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_clock/utils/constants.dart';


void initNotifications() {
  AwesomeNotifications().initialize(
    "resource://drawable/res_app_icon",
    [
      NotificationChannel(
        channelKey: kAlarmChannelKey,
        channelName: "Alarm Notifications",
        channelDescription: "my alarm notificaitons",
        importance: NotificationImportance.High,
        channelShowBadge: true,
        defaultColor: kNotifDefaultColor,
        ledColor: kNotifLedColor,
        playSound: false,
        vibrationPattern: lowVibrationPattern,
      ),
    ],
  );
}
