import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../const/app_consts.dart';
import 'local_notifications.dart';
import 'shared_preferences_helper.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize Firebase and set up message handlers
  Future<void> initialize() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Request notification permissions for iOS
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Set foreground notification presentation options for iOS
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Receiv');
      print('Message data: meed a message while in the');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        LocalNotificationService.display(message);
      }
    });

    // Handle messages that are opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Print the token each time the application loads
    String token = await getToken();
    SharedPreferencesHelper.saveData(key: 'FIREBASE_TOKEN', value: token);
    print("Firebase Messaging Token: $token");
  }

  /// This handler must be a top-level function
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  /// Get the FCM token for this device
  Future<String> getToken() async {
    String token = await _firebaseMessaging.getToken() ?? "";
    SharedPreferencesHelper.saveData(key: AppKeys.fbToken, value: token);
    return token;
  }
}
