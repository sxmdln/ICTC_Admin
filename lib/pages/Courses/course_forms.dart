import 'package:flutter/cupertino.dart';
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
          Flexible(
            child: CupertinoTextFormFieldRow(
              prefix: const Row(
                children: [
                  Text("Course Title",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              // padding: EdgeInsets.only(left: 90),
              placeholder: "e.g. Hacking Course",
              placeholderStyle: const TextStyle(
                fontSize: 14, //
                fontWeight: FontWeight.w400,
                color: Colors.black45,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
              decoration: BoxDecoration(
                // border: ,
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
                // prefixIcon: Icon(Icons.person)
              ),
            ),
          ),

          // DESCRIPTION
          Flexible(
            child: CupertinoTextFormFieldRow(
              expands: true,
              keyboardType: TextInputType.multiline,
              minLines: null,
              maxLines: null,
              prefix: const Row(
                children: [
                  Text("Description",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 15),
                ],
              ),
              // padding: EdgeInsets.only(left: 90),
              placeholder: "Course Description",
              placeholderStyle: const TextStyle(
                fontSize: 14, //
                fontWeight: FontWeight.w400,
                color: Colors.black45,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
              decoration: BoxDecoration(
                // border: ,
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
                // prefixIcon: Icon(Icons.person)
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Expanded(child: SizedBox(child: cancelButton())),
              if (widget.course != null)
                Expanded(
                  flex: 1,
                  child: SizedBox(child: deleteButton()),
                ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: SizedBox(child: saveButton()),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


  Widget saveButton() {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.greenAccent;
          }
          return Colors.green;
        }),
      ),
      onPressed: () {},
      child: const Text(
        "Save",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget deleteButton() {
    return FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white70;
            }
            return const Color.fromARGB(255, 226, 226, 226);
          }),
        ),
        onPressed: () {},
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.black87),
        ));
  }
}