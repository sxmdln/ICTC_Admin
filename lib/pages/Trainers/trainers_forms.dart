import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/trainer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TrainersForm extends StatefulWidget {
  const TrainersForm({super.key, this.trainer});

  final Trainer? trainer;

  @override
  State<TrainersForm> createState() => _TrainersFormState();
}

class _TrainersFormState extends State<TrainersForm> {
  @override
  void initState() {
    super.initState();

    firstNameCon = TextEditingController();
    lastNameCon = TextEditingController();
    contactCon = TextEditingController();
    emailCon = TextEditingController();
  }

  Course? selectedCourse;

  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameCon, lastNameCon, contactCon, emailCon;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Stack(children: [
          //       const SizedBox(
          //       width: 120,
          //       height: 120,
          //         child: CircleAvatar(
          //           backgroundColor: Colors.grey,
          //           // backgroundImage: AssetImage("assets/photos/photo-1.jpg"),
          //           radius: 90.0,
          //         ),
          //       ),
          //       Positioned.fill(
          //         child: Container(
          //           alignment: Alignment.center,
          //           decoration: BoxDecoration(
          //                 border: Border.all(width: 0.5, color: Colors.grey),
          //                 borderRadius: BorderRadius.circular(90.0),
          //                 color: Colors.grey),
          //           // alignment: Alignment.topLeft,
          //           child: IconButton(icon: const Icon(Icons.add, size: 24, color: Colors.white70),
          //           // constraints: BoxConstraints(maxHeight: 15, maxWidth: 15),
          //           splashRadius: 20,
          //           // iconSize: 30,
          //           onPressed: (){},
          //           )),
          //       )
          //     ]),
          //     const Padding(padding: EdgeInsets.all(10)),
          //   ],
          // ),
          // const SizedBox(height: 20),

          // FIRST NAME
          Row(
            children: <Widget>[
              Flexible(
                child: CupertinoTextFormFieldRow(
                  controller: firstNameCon,
                  prefix: const Row(
                    children: [
                      Text("First Name",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                      SizedBox(width: 12),
                    ],
                  ),
                  // padding: EdgeInsets.only(left: 90),
                  placeholder: "e.g. John",
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

              // LAST NAME
              Flexible(
                child: CupertinoTextFormFieldRow(
                  controller: lastNameCon,
                  prefix: const Row(
                    children: [
                      Text("Last Name",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                      SizedBox(width: 12),
                    ],
                  ),
                  // padding: EdgeInsets.only(left: 90),
                  placeholder: "e.g. De La Cruz",
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
            ],
          ),

          //EMAIL ADDRESS
          CupertinoTextFormFieldRow(
            controller: emailCon,

            prefix: const Row(
              children: [
                Text("Email Address",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 24),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "e.g. jdoe@gmail.com",
            placeholderStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black45,
              fontWeight: FontWeight.w400,
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

          // CONTACT NUMBER

          CupertinoTextFormFieldRow(
            controller: contactCon,

            prefix: const Row(
              children: [
                Text("Contact Number",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 12),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "e.g. 09123456789",
            placeholderStyle: const TextStyle(
              fontSize: 14,
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

          DropdownButton(
            isExpanded: false,
            isDense: false,
            borderRadius: BorderRadius.circular(18),
            disabledHint: const Text(
              "No courses yet.",
              style: TextStyle(fontSize: 14),
            ),
            onChanged: (course) => setState(() => selectedCourse = course),
            value: selectedCourse,
            items:
                null, //TODO: Dynamically populate dropdown items with courses
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              if (widget.trainer != null)
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
          )
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
      onPressed: () {
        final supabase = Supabase.instance.client;
        Trainer? trainer = widget.trainer;

        if (trainer != null) {
          supabase
              .from('trainer')
              .update(trainer.toJson())
              .eq('id', trainer.id);
        } else {
          // TODO: Add code to insert new record
          // trainer = Trainer(id: id, firstName: firstName, middleName: middleName, lastName: lastName, email: email, contactNumber: contactNumber);
        }
      },
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
