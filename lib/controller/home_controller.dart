import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_clock/models/notifikasi_model.dart';
import 'package:flutter_clock/utils/constants.dart';

import 'package:flutter_clock/utils/helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxDouble minutesAngle = 0.0.obs;
  RxDouble secondAngle = 0.0.obs;
  RxDouble hoursAngle = 0.0.obs;

  RxString hours = "00".obs;
  RxString minutes = "00".obs;
  RxString second = "00".obs;

  RxInt hourIncrement = 0.obs;
  RxInt minuteIncrement = 0.obs;
  RxInt secondIncrement = 0.obs;

  RxString alarmDateTime = "--:--".obs;

  late Timer timer;
  final now = DateTime.now().obs;

  RxBool flagChange = false.obs;

  RxString timeAlarm = "00:00".obs;

  @override
  void onInit() {
    initClock();
    super.onInit();
  }

  Future<void> onClickSetAlarm() async {
    NotifikasiModel? _notif =
        await pickAlarm(hours.toString() + ":" + minutes.toString());
    try {
      if (_notif != null) setNotificationAlarm(_notif);
    } catch (e) {
      print(e);
    }
  }

  Future<NotifikasiModel?> pickAlarm(String time) async {
    print("time " + time);
    int dayOfTheWeek = 0;
    NotifikasiModel? _notif;

    DateTime _currentDateTime = DateTime.now();
    TimeOfDay _timeOfDay = Helper().stringToTimeOfDay(time);

    dayOfTheWeek = _currentDateTime.weekday;

    String _time = "${_timeOfDay.hour}:${_timeOfDay.minute}:00";

    String formattedDate =
        DateFormat('kk:mm').format(DateFormat("HH:mm:ss").parse(_time));

    alarmDateTime.value = formattedDate;

    _notif = NotifikasiModel(
        dayOfTheWeek: dayOfTheWeek,
        timeOfDay: _timeOfDay,
        dateTime: _currentDateTime);

    return _notif;
  }

  Future<void> setNotificationAlarm(NotifikasiModel notif) async {
    String _notif = jsonEncode(notif.toJson());
    print("pram notif " + _notif);

    await AwesomeNotifications()
        .createNotification(
      content: NotificationContent(
        id: Helper().createUniqueId(10),
        channelKey: kAlarmChannelKey,
        payload: {"notif": _notif},
        title: "My Alarm",
        body: alarmDateTime.value,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        weekday: notif.dayOfTheWeek,
        hour: notif.timeOfDay.hour,
        minute: notif.timeOfDay.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
      ),
    )
        .then((value) {
      print("value callback " + value.toString());
      resetIncrement();
    });
    // print("onClickNotificationAlarm: ${notif.dayOfTheWeek}");
  }

  void incrementHour() {
    if (now.value.hour == 0) {
      hourIncrement.value = 0;
      now.value = DateTime.now();
    } else {
      hourIncrement.value = hourIncrement.value + 1;
    }
  }

  void decrementHour() {
    if (now.value.hour == 0) {
      hourIncrement.value = 0;
      now.value = DateTime.now();
    } else {
      hourIncrement.value = hourIncrement.value - 1;
    }
  }

  void incrementMinutes() {
    minuteIncrement.value = minuteIncrement.value + 1;
  }

  void decrementMinutes() {
    minuteIncrement.value = minuteIncrement.value - 1;
  }

  void incrementSeconds() {
    secondIncrement.value = secondIncrement.value + 1;
  }

  void decrementSeconds() {
    secondIncrement.value = secondIncrement.value - 1;
  }

  void resetIncrement() {
    hourIncrement.value = 0;
    minuteIncrement.value = 0;
    secondIncrement.value = 0;
  }

  void resetAlaram()async{
       await AwesomeNotifications().cancelAllSchedules();
    alarmDateTime.value = "--:--";
  }

  void initClock() {
    timer = Timer.periodic(const Duration(microseconds: 500), (timer) {
      now.value = DateTime.now().add(Duration(
          hours: hourIncrement.value,
          minutes: minuteIncrement.value,
          seconds: secondIncrement.value));
      // if (flagChange.value) {
      //   print("masukk flag true");
      //   secondAngle.value = (pi / 30) * double.parse(second.value);
      //   minutesAngle.value = pi / 30 * double.parse(minutes.value);
      //   hoursAngle.value = (pi / 6 * double.parse(hours.value)) +
      //       (pi / 45 * minutesAngle.value);
      // } else {
      secondAngle.value = (pi / 30) * now.value.second;
      minutesAngle.value = pi / 30 * now.value.minute;
      hoursAngle.value =
          (pi / 6 * now.value.hour) + (pi / 45 * minutesAngle.value);
      hours.value = now.value.hour.toString().length == 1
          ? "0" + now.value.hour.toString()
          : now.value.hour.toString();
      minutes.value = now.value.minute.toString().length == 1
          ? "0" + now.value.minute.toString()
          : now.value.minute.toString();
      second.value = now.value.second.toString().length == 1
          ? "0" + now.value.second.toString()
          : now.value.second.toString();
      // }
    });
  }
}
