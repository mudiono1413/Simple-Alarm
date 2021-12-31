import 'package:flutter/material.dart';
import 'package:flutter_clock/controller/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: EdgeInsets.all(8.0.h),
          child: SizedBox(
            height: 90.h,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "My Alarm : ",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      controller.alarmDateTime.value,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.alarmDateTime.value == "--:--"
                        ? GestureDetector(
                            onTap: () {
                              controller.onClickSetAlarm();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w,
                                    right: 10.w,
                                    top: 4.h,
                                    bottom: 4.h),
                                child: Text("set alarm",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              controller.resetAlaram();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w,
                                    right: 10.w,
                                    top: 4.h,
                                    bottom: 4.h),
                                child: Text("Reset",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.hours.value,
                          style: TextStyle(
                              fontSize: 60.sp, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  controller.incrementHour();
                                },
                                child:  Icon(Icons.arrow_drop_up,
                                color: Theme.of(context).primaryColor,)),
                            GestureDetector(
                                onTap: () {
                                  controller.decrementHour();
                                },
                                child: const Icon(Icons.arrow_drop_down,
                                color: Colors.red,)),
                          ],
                        ),
                        Text(
                          controller.minutes.value,
                          style: TextStyle(
                              fontSize: 60.sp, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  controller.incrementMinutes();
                                },
                                child:  Icon(Icons.arrow_drop_up,
                                color: Theme.of(context).primaryColor,)),
                            GestureDetector(
                                onTap: () {
                                  controller.decrementMinutes();
                                },
                                child: const Icon(Icons.arrow_drop_down,
                                color: Colors.red,)),
                          ],
                        ),
                        // Text(
                        //   controller.second.value,
                        //   style:
                        //       const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                        // ),
                        // Column(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     GestureDetector(
                        //         onTap: () {
                        //           controller.incrementSeconds();
                        //         },
                        //         child: const Icon(Icons.arrow_drop_up)),
                        //     GestureDetector(
                        //         onTap: () {
                        //           controller.decrementSeconds();
                        //         },
                        //         child: const Icon(Icons.arrow_drop_down)),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
      body: Obx(() {
        return SafeArea(
            child: Padding(
          padding: EdgeInsets.all(8.0.h),
          child: Stack(
            children: [
              Container(
                  alignment: Alignment(0, 0.h),
                  child: Image.asset('assets/images/clock.jpg')),
              // DOT
              Container(
                alignment: const Alignment(0, 0),
                child: Container(
                  height: 15.h,
                  width: 15.w,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              // seconds
              Transform.rotate(
                angle: controller.secondAngle.value,
                child: Container(
                  alignment: const Alignment(0, -0.15),
                  child: Container(
                    height: 140.h,
                    width: 2.w,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              // hours
              Transform.rotate(
                angle: controller.hoursAngle.value,
                child: Container(
                  alignment: const Alignment(0, -0.12),
                  child: Container(
                    height: 70.h,
                    width: 7.w,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              // minutes
              Transform.rotate(
                angle: controller.minutesAngle.value,
                child: Container(
                  alignment: const Alignment(0, -0.16),
                  child: Container(
                    height: 95.h,
                    width: 5.h,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ));
      }),
    );
  }
}
