import 'package:flutter/material.dart';
import 'package:ictc_admin/main_screen.dart';
import 'package:ictc_admin/pages/auth/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;

      if (event == AuthChangeEvent.signedIn || data.session?.user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ));
      }
    });

    print("setup auth listener");
  }

  @override
  void initState() {
    // _setupAuthListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.data?.session?.user != null) {
          return const MainScreen();
        }

        return const LoginPage();
      },
    );
  }
}
