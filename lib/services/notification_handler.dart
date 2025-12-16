import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'channel_notification',
    'High Importance Notification',
    description: 'Used For Notification',
    importance: Importance.defaultImportance,
  );

  final _localNotification =
      FlutterLocalNotificationsPlugin();

  Future<void> initPushNotification() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print(
      'Izin yang diberikan pengguna: '
      '${settings.authorizationStatus}',
    );

    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((message) {
      print(
        'Pesan saat aplikasi terminated: '
        '${message?.notification?.title}',
      );
    });

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription:
                _androidChannel.description,
            icon: '@mipmap/ic_launcher', // ✅ FIX SAJA DI SINI
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print(
          'Pesan dibuka dari notifikasi: '
          '${message.notification?.title}',
        );
      },
    );
  }

  Future initLocalNotification() async {
    const ios = DarwinInitializationSettings();
    const android =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // ✅ FIX

    const settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _localNotification.initialize(settings);
  }
}
