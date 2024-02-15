import 'package:ictc_admin/main_screen.dart';
import 'package:ictc_admin/pages/auth/login_page.dart';
import 'package:ictc_admin/pages/courses_page.dart';
import 'package:ictc_admin/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/pages/programs_page.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// void main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp());
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ateneo ICTC',
        theme: ThemeData(
          fontFamily: "Montserrat",
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff153faa),
              onPrimary: const Color(0xff153faa),
              onSecondary: Colors.white,
              onPrimaryContainer: const Color(0xff153faa),
              onSecondaryContainer: Colors.white),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontSize: 64, fontWeight: FontWeight.w800, color: Colors.white),
            titleLarge: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w800,
                color: Color(0xffF9CE69)),
            labelMedium: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
            displayMedium: TextStyle(
                fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white),
            titleMedium: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Color(0xffF9CE69)),
            labelSmall: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),
            bodyLarge: TextStyle(
                fontSize: 64, fontWeight: FontWeight.w600, color: Color(0xff153faa)),
            bodyMedium: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
            ),
          useMaterial3: false,
        ),
        routes: {
          '/dashboard': (context) => const DashboardPage(),
          '/programs': (context) => const ProgramsPage(),
          '/courses': (context) => const CoursesPage(),
          '/home': (context) => const MainScreen(),
          '/login': (context) => const LoginPage(),
        },
        home: const MainApp(),
        debugShowCheckedModeBanner: false,
        );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainScreen(),
    );
  }
}
