import 'package:ictc_admin/pages/auth/auth_gate.dart';

import 'package:flutter/material.dart';

import 'package:ictc_admin/supabase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseOptions.SUPABASE_URL,
    anonKey: SupabaseOptions.SUPABASE_ANON_KEY,
    debug: true,
  );

  runApp(const ICTCApp());
}

class ICTCApp extends StatelessWidget {
  const ICTCApp({super.key});

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
          bodyMedium: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        dataTableTheme: DataTableThemeData(
          dividerThickness: 0.5,
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
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
