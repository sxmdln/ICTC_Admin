import 'package:flutter/material.dart';
import 'package:ictc_admin/utils/validators.dart';
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
  void initState() {
    super.initState();

    emailCon = TextEditingController();
    passwordCon = TextEditingController();
  }
  
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailCon, passwordCon;

  void login() async {
    if (!formKey.currentState!.validate()) return;

    final auth = Supabase.instance;

    //TODO: tigkopya ko lang sa dati, paremove nalang if 'di kailangan
    // try {
    //   await auth.signInWithEmailAndPassword(
    //       email: emailCon.text, password: passwordCon.text);
    // } on FirebaseAuthException catch (e) {
    //   snackbarKey.currentState!.showSnackBar(
    //       SnackBar(content: Text(e.message ?? "Error! ${e.code}")));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: 350,
                height: 670,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 450,
                            height: 670,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 0, bottom: 30),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/logo_ictc.png"),
                                      height: 100),
                                ),
                                const Text(
                                  "Log in to Ateneo ICTC",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                buildForm(context),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Expanded(child: Divider()),
                                        Text("     or     "),
                                        Expanded(child: Divider()),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      // hoverColor: const Color(0xff153faa).withOpacity(0.8),
                                      // highlightColor: const Color(0xff153faa).withOpacity(0.4),
                                      // splashColor: const Color(0xff153faa).withOpacity(1),
                                      onTap: _logInWithGoogle,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        width: 350,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          border: Border.all(
                                            color: const Color(0xff153faa),
                                            width: 1,
                                          ),
                                          // adding color will hide the splash effect
                                          color: Colors.transparent,
                                        ),
                                        child: const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.account_circle_rounded,
                                              color: Color(0xff153faa),
                                              size: 23,
                                            ),
                                            SizedBox(
                                              width: 9,
                                            ),
                                            Text(
                                              "Log in with Google",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff153faa)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
Form buildForm(context) {
  return Form(
      key: formKey,
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      TextFormField(
        controller: emailCon,
        validator: Validators.isAnEmail,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.email_rounded,
            color: Colors.black54,
            size: 20,
          ),
          labelText: "Email",
          labelStyle: TextStyle(
              color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w400),
          floatingLabelStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: passwordCon,
        onFieldSubmitted: (_) => login(),
        validator: Validators.hasValue, 
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        obscuringCharacter: '•',
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.key,
            color: Colors.black54,
            size: 20,
          ),
          labelText: "Password",
          labelStyle: TextStyle(
              color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w400),
          floatingLabelStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
      ),
      const SizedBox(height: 12),
      InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        // hoverColor: const Color(0xff153faa).withOpacity(0.8),
        // highlightColor: const Color(0xff153faa).withOpacity(0.4),
        // splashColor: const Color(0xff153faa).withOpacity(1),
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // adding color will hide the splash effect
            color: const Color(0xff153faa),
          ),
          child: const Text(
            "Log in",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    ],
  ));
}

}
