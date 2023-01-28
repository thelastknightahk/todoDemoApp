import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:todo_test/controller/todo_controller.dart';
import 'package:todo_test/firebase_options.dart';
import 'package:todo_test/presentation/splash/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Basic Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
      debug: true);
       FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(  GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp()));
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  
}
class MyApp extends StatelessWidget {
    MyApp({super.key});

  // This widget is the root of your application.
 
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      title: 'Hoshin Labs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
 