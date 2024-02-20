import 'package:flutter/material.dart';

class FormsLayout extends StatefulWidget {
  const FormsLayout({Key? key}) : super(key: key);

  @override
  State<FormsLayout> createState() => _FormsLayoutState();
}

class _FormsLayoutState extends State<FormsLayout> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return formDialog(context);
          },
        );
      },
      child: const Icon(
        Icons.edit, 
        color: Colors.white,
      ),
    );
  }

  Widget formDialog(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 406,
        height: 498,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(27, 25, 27, 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: forms(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget forms() {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Enter Title",
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "Monsterrat"
              ),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Enter Description",
              hintStyle: TextStyle(
                fontSize: 18,
                fontFamily: "Monsterrat"
              ),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: saveButton()
          )
        ],
      ),
    );
  }

  Widget saveButton() {
    return OutlinedButton(
      onPressed: (){}, 
      child: const Text(
        "Save"
      )
    );
  }
}
