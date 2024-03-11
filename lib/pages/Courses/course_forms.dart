import 'package:flutter/material.dart';

class CourseForm extends StatefulWidget {
  const CourseForm({super.key, this.course});

  final Object? course;

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
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
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Monsterrat",
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              hintText: "Cost",
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
              hintText: "Duration",
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
              hintText: "Schedule",
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
              hintText: "Venue",
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
              if (widget.course != null) 
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
    return OutlinedButton(
      onPressed: () {}, 
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.blue)
      ), 
      child: const Text(
        "Save"
      )
    );
  }

  Widget deleteButton() {
    return OutlinedButton(
      onPressed: () {}, 
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red)
      ),
      child: const Text(
        "Delete",
        style: TextStyle(
          color: Colors.red
        ),
      )
    );
  }
}