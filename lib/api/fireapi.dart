// lib/api/fireapi.dart
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// // Top-level function to handle background messages
// @pragma('vm:entry-point')
// Future<void> bgmsgs(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }
//
// class fireapi {
//   final firemsg = FirebaseMessaging.instance;
//
//   final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();
//
//   // Initialize notifications
//   Future<void> initnotif() async {
//     // Request permission
//     await firemsg.requestPermission();
//
//     // Get FCM token
//     final devtoken = await firemsg.getToken();
//     print('Token is: $devtoken');
//
//     // Initialize local notifications for foreground messages
//     await initlocalnotif();
//
//     // Handle background messages
//     FirebaseMessaging.onBackgroundMessage(bgmsgs);
//
//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Foreground message received!');
//
//       // Show notification when app is in foreground
//       if (message.notification != null) {
//         showLocalNotification(
//           title: message.notification!.title ?? 'New Message',
//           body: message.notification!.body ?? '',
//           payload: message.data.toString(),
//         );
//       }
//     });
//
//     // Handle notification tap (when app is in background/terminated)
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Notification tapped!');
//       // Navigate to chat page here if needed
//       // You can use message.data to get sender info
//     });
//
//     // Check if app was opened from a notification
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         print('App opened from notification');
//         // Handle navigation here
//       }
//     });
//   }
//
//   // Initialize local notifications
//   Future<void> initlocalnotif() async {
//     const AndroidInitializationSettings andrdseting =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
//
//     const InitializationSettings settings = InitializationSettings(
//       android: andrdseting,
//       iOS: iosSettings,
//     );
//
//     await _localNotifications.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Handle notification tap
//         print('Notification tapped: ${response.payload}');
//       },
//     );
//   }
//
//   // Show local notification
//   Future<void> showLocalNotification({
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//           'yaca_messages', // channel id
//           'YACA Messages', // channel name
//           channelDescription: 'Notifications for new messages in YACA',
//           importance: Importance.high,
//           priority: Priority.high,
//           showWhen: true,
//         );
//
//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _localNotifications.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique id
//       title,
//       body,
//       details,
//       payload: payload,
//     );
//   }
//
//   // Get current FCM token
//   Future<String?> getToken() async {
//     return await firemsg.getToken();
//   }
// }
