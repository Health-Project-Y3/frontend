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

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotifications(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      "notification",
      "channel_name",
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    
    );
    print("test");
    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, not);
  }
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
  