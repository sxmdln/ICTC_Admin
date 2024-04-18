import 'package:ictc_admin/main_screen.dart';
import 'package:ictc_admin/pages/auth/login_page.dart';
import 'package:ictc_admin/pages/courses/courses_page.dart';
import 'package:ictc_admin/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/pages/programs/programs_page.dart';
import 'package:ictc_admin/supabase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// void main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp());
// }

Future<void> main() async {
  Supabase.initialize(
      url: SupabaseOptions.SUPABASE_URL,
      anonKey: SupabaseOptions.SUPABASE_ANON_KEY);

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
        fontFamily: "Archivo",
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff153faa),
            onPrimary: const Color(0xff153faa),
            onSecondary: Colors.white,
            onPrimaryContainer: const Color(0xff153faa),
            onSecondaryContainer: Colors.white),
        textTheme: const TextTheme(
          // displayLarge: TextStyle(
          //     fontSize: 64, fontWeight: FontWeight.w800, color: Colors.white),
          // titleLarge: TextStyle(
          //     fontSize: 64,
          //     fontWeight: FontWeight.w800,
          //     color: Color(0xffF9CE69)),
          // labelMedium: TextStyle(
          //     fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
          // displayMedium: TextStyle(
          //     fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white),
          // titleMedium: TextStyle(
          //     fontSize: 40,
          //     fontWeight: FontWeight.w800,
          //     color: Color(0xffF9CE69)),
          // labelSmall: TextStyle(
          //     fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),
          // bodyLarge: TextStyle(
          //     fontSize: 12,
          //     fontWeight: FontWeight.w600,
          //     color: Color(0xff153faa)),
          bodyMedium: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        dataTableTheme: DataTableThemeData(
          headingRowColor: MaterialStateColor.resolveWith((states) {
            // If the button is pressed, return size 40, otherwise 20
            if (states.contains(MaterialState.hovered)) {
              return const Color(0xff19306B);
            }
            return const Color(0xff19306B);
          }),
          headingTextStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
          dataRowColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.grey.shade400;
            }
            return null;
          }),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  // If the button is pressed, return green, otherwise blue
                  if (states.contains(MaterialState.pressed)) {
                    return const Color.fromARGB(255, 57, 167, 74);
                  }
                  return const Color.fromARGB(255, 33, 175, 23);
                },
              ),
              fixedSize: MaterialStateProperty.all(const Size.fromWidth(145))),
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
