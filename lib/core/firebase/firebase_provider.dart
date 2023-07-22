// firebase_controller.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:qr_code_app/utils/logger.dart';

class FirebaseProvider {
  Future<void> initFirebase() async {
    try {
      await Firebase.initializeApp();
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    } catch (e) {
      // Handle any initialization errors here
      logger.e('Firebase initialization error: $e');
    }
  }

  static Future<String> setupToken() async {
    try {
      String? fMToken = await FirebaseMessaging.instance.getToken();

      if (fMToken!.isEmpty) {
        throw Exception('Error generate token');
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
        logger.d(token);
      });

      return fMToken;
    } catch (e) {
      // Handle any token setup errors here
      logger.e('Firebase token setup error: $e');
      // Return a default or error token value
      return 'DEFAULT_TOKEN'; // Change 'DEFAULT_TOKEN' to the desired value.
    }
  }
}
