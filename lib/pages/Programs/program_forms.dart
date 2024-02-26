import 'package:flutter/material.dart';

class ProgramForm extends StatefulWidget {
  const ProgramForm({super.key, this.program});

  final Object? program;

  @override
  State<ProgramForm> createState() => _ProgramFormState();
}

class _ProgramFormState extends State<ProgramForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Monsterrat",
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              hintText: "Enter Title",
              hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Monsterrat"),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Monsterrat",
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              hintText: "Enter Description",
              hintStyle: TextStyle(fontSize: 18, fontFamily: "Monsterrat"),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: saveButton()
                ),
              ),
              const SizedBox(width: 10,),
              if (widget.program != null) 
              Expanded(
                child: SizedBox(
                  child: deleteButton()
                )
              )
            ],
          )
        ],
      ),
    );
  }

  Widget saveButton() {
    return OutlinedButton(onPressed: () {}, child: const Text("Save"));
  }

  Widget deleteButton() {
    return OutlinedButton(onPressed: () {}, child: const Text("Delete"));
  }
}
