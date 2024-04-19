import 'package:flutter/material.dart';
import 'package:ictc_admin/main_screen.dart';
import 'package:ictc_admin/pages/auth/login_page.dart';
import 'package:ictc_admin/pages/auth/unauthorized_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;

            if (data.session?.user != null) {
              final type = data.session!.user.appMetadata['user_type'];
              
              if (type == "ADMIN") {
                return const MainScreen();
              } else {
                return const UnauthorizedPage();
              }
            }
          }

          return const LoginPage();
        });
  }
}
