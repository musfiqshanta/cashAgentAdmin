import 'package:cash_agent_admin/app/modules/home/views/home_view.dart';
import 'package:cash_agent_admin/firebase_options.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '1X CASH AGENT',
      theme: ThemeData(
        primaryColor: const Color(0xff0c314d),
        highlightColor: const Color(0xff2ecc71),
        cardTheme: const CardTheme(
          color: Color(0xff0c314d),
          elevation: 20,
          shadowColor: Color(0xff0c314d),
        ),
        disabledColor: const Color(0xff232323),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff0c314d),
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int page = 0;
  Widget child = const HomeView();
  final GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          index: page,
          items: const <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            // Icon(Icons.perm_identity, size: 30, color: Colors.white),
          ],
          color: Get.theme.primaryColor,
          buttonBackgroundColor: Get.theme.primaryColor,
          backgroundColor: Get.theme.disabledColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              page = index;
              switch (index) {
                case 0:
                  child = const HomeView();
                  break;
                // case 1:
                //   child = const ProfileView();
                //   break;
              }
            });
          },
          letIndexChange: (index) => true,
        ),
        body: child,
      ),
    );
  }
}
