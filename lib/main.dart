import 'package:firebase_admin/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _firebaseConfigWeb = FirebaseOptions(
    apiKey: "AIzaSyCdrvlZPltji85BFFERgLgiS1mXRLoQ4do",
    authDomain: "getx-admin.firebaseapp.com",
    projectId: "getx-admin",
    storageBucket: "getx-admin.appspot.com",
    messagingSenderId: "401769481318",
    appId: "1:401769481318:web:62dbc3cf92d7b7173f99a7");

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  kIsWeb ? await Firebase.initializeApp(options: _firebaseConfigWeb) : null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
