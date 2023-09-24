import 'dart:ui';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter/widgets.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // static final NotificationService _notificationService =
  //     NotificationService._internal();

  // factory NotificationService() {
  //   return _notificationService;
  // }

  // NotificationService._internal();

  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/tickicon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // tz.initializeTimeZones();
    // tz.setLocalLocation(
    //   tz.getLocation(
    //     await FlutterNativeTimezone.getLocalTimezone(),
    //   ),
    // );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotifications(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      // var ColorProperty = const Color.fromARGB(255, 220, 104, 145),
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      "notification",
      "channel_name",
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
      color: Color.fromARGB(255, 220, 104, 145),
      icon: '@drawable/tickicon',
    );
    print("test");
    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, not);
  }

  static Future showOverdueNotification(
      {required FlutterLocalNotificationsPlugin fln}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'notification',
      'channel_name',
      // playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      // color: Color.fromARGB(255, 220, 104, 145),
      // icon: '@drawable/tickicon',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await fln.show(
      0,
      'Overdue Task',
      'This task is overdue!',
      platformChannelSpecifics,
    );
  }

//   Future<void> showScheduledLocalNotification({
//   required int id,
//   required String title,
//   required String body,
//   required String payload,
//   required tz.TZDateTime scheduledDateTime,
//   required FlutterLocalNotificationsPlugin fln
// }) async {
//    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//      "notification",
//     "channel_name",
//       // when: tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
//    );
//    await fln.zonedSchedule(
//     id,
//     title,
//     body,
//     scheduledDateTime,
//     NotificationDetails(android: androidPlatformChannelSpecifics),
//     androidAllowWhileIdle: true,
//     payload: payload,
//     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//   );

// }
}

// void init() {
//   final AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('app_icon');
  
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid, 
//         );

//     tz.initializeTimeZones();  // <------
  
//    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: selectNotification);

        
//   }



//     const NotificationDetails platformChannelSpecifics = 
//   NotificationDetails(android: androidPlatformChannelSpecifics);

// await flutterLocalNotificationsPlugin.show(
//         12345, 
//         "A Notification From My Application",
//         "This notification was sent using Flutter Local Notifcations Package", 
//         platformChannelSpecifics,
//         payload: 'data');

// await flutterLocalNotificationsPlugin.zonedSchedule(
//         12345,
//         "A Notification From My App",
//         "This notification is brought to you by Local Notifcations Package",
//         tz.TZDateTime.now(tz.local).add(const Duration(days: 3)),
//         // const NotificationDetails(
//         //     android: AndroidNotificationDetails(CHANNEL_ID, CHANNEL_NAME,
//                 // CHANNEL_DESCRIPTION)),
//         platformChannelSpecifics,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
  