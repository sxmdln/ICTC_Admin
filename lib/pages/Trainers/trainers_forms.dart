import 'package:flutter/material.dart';

class TrainerForm extends StatefulWidget {
  const TrainerForm({super.key, this.trainer});

  final Object? trainer;

  @override
  State<TrainerForm> createState() => _TrainerFormState();
}

class _TrainerFormState extends State<TrainerForm> {
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
              hintText: "Enter Name",
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
              hintText: "Enter Handled Programs",
              hintStyle: TextStyle(fontSize: 18, fontFamily: "Monsterrat"),
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
              hintText: "Enter Handled Course",
              hintStyle: TextStyle(fontSize: 18, fontFamily: "Monsterrat"),
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
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Monsterrat",
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              hintText: "Enter Date",
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
              if (widget.trainer != null) 
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