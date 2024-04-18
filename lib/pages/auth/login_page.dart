import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _logInWithGoogle() async {
    await Supabase.instance.client.auth.signInWithOAuth(OAuthProvider.google);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: buildBody(context)),
        ],
      )),
    );
  }

  Widget buildBody(context) {
    return Card(
      margin: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height * 0.2,
      ),
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 0.5,
      // surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SizedBox(
          width: 400,
          height: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0, bottom: 30),
                child: Image(
                    image: AssetImage("assets/images/logo_ictc.png"),
                    height: 100),
              ),
              const Text(
                "Log in to Ateneo ICTC",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton.icon(
                      onPressed: _logInWithGoogle,
                      icon: const Icon(Icons.login_rounded),
                      label: const Text('Login with Google'))),
            ],
          ),
        ),
      ),
    );
  }
}

// Form buildForm(context) {
//   return Form(
//       // key: (state.formKey),
//       child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       TextFormField(
//         // controller: state.emailCon,
//         // validator: Validators.isAnEmail,
//         keyboardType: TextInputType.emailAddress,
//         style: const TextStyle(
//             fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(),
//           prefixIcon: Icon(
//             Icons.email_rounded,
//             color: Colors.black54,
//             size: 20,
//           ),
//           labelText: "Email",
//           labelStyle: TextStyle(
//               color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w400),
//           floatingLabelStyle: TextStyle(
//             color: Colors.black54,
//             fontSize: 16,
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         ),
//       ),
//       const SizedBox(height: 12),
//       TextFormField(
//         // controller: state.passwordCon,
//         // onFieldSubmitted: (_) => state.login(),
//         // validator: Validators.hasValue,
//         style: const TextStyle(
//             fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
//         keyboardType: TextInputType.visiblePassword,
//         obscureText: true,
//         obscuringCharacter: '•',
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(),
//           prefixIcon: Icon(
//             Icons.key,
//             color: Colors.black54,
//             size: 20,
//           ),
//           labelText: "Password",
//           labelStyle: TextStyle(
//               color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w400),
//           floatingLabelStyle: TextStyle(
//             color: Colors.black54,
//             fontSize: 16,
//           ),
//         ),
//       ),
//       const SizedBox(height: 12),
//       InkWell(
//         customBorder: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(0),
//         ),
//         // hoverColor: const Color(0xff153faa).withOpacity(0.8),
//         // highlightColor: const Color(0xff153faa).withOpacity(0.4),
//         // splashColor: const Color(0xff153faa).withOpacity(1),
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               //TODO: Add authentication
//               builder: (context) => const MainScreen(),
//             ),
//           );
//         },
//         child: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           width: 400,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             // adding color will hide the splash effect
//             color: const Color(0xff153faa),
//           ),
//           child: const Text(
//             "Log in",
//             style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
//           ),
//         ),
//       ),
//     ],
//   ));
//}
