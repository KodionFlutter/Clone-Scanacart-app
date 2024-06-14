import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scan_cart_clone/Screens/splash%20screen/splash_screen.dart';
import 'package:scan_cart_clone/Utils/constant.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'ScanCart clone App ',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
        ),
        home: SplashScreen());
  }
}
// MD5: 4C:56:8E:A2:98:58:25:4B:65:4B:1B:42:C6:AE:B7:7A
// SHA1: 30:48:24:D2:84:78:34:60:BA:30:9C:C0:1C:4A:50:C7:D2:B8:CD:39
// SHA-256: 59:98:18:34:EF:AE:17:1E:11:8B:2B:F2:94:CB:FF:E2:DD:1D:40:55:75:E7:B1:CB:D2:D6:3A:D8:C5:88:6D:2C
