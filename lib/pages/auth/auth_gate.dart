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
  _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final event = data.event;

      if (event == AuthChangeEvent.signedIn || data.session?.user != null) {
        final type = await Supabase.instance.client
            .rpc('get_my_claim', params: {"claim": "user_type"});

        if (type != "ADMIN") {
          await Supabase.instance.client.auth.signOut();

          if (mounted) {
            await showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                icon: Icon(Icons.warning),
                title: Text("Not an Admin account"),
                content: Text("The logged in account is not an admin account."),
              ),
            );

            return;
          }
        }
      }
    });
  }

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
              print(type);

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
