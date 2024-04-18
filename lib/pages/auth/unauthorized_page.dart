import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UnauthorizedPage extends StatelessWidget {
  const UnauthorizedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Your account is not authorized to access this page!"),
              ElevatedButton(
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                  },
                  child: const Text("Log out"))
            ],
          ),
        ),
      ),
    );
  }
}
