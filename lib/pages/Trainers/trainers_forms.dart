import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

    print("trainer ${widget.trainer?.id}");

    firstNameCon = TextEditingController(text: widget.trainer?.firstName);
    lastNameCon = TextEditingController(text: widget.trainer?.lastName);
    contactCon = TextEditingController(text: widget.trainer?.contactNumber);
    emailCon = TextEditingController(text: widget.trainer?.email);
    // TODO: set current course if this is called with a trainer
    // selectedCourse = widget.trainer?.course;
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

          // FutureBuilder(
          //     future: Supabase.instance.client
          //         .from('course')
          //         .select()
          //         .withConverter(
          //             (data) => data.map((e) => Course.fromJson(e)).toList()),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return const CircularProgressIndicator();
          //       }

          //       return DropdownButton(
          //         isExpanded: false,
          //         isDense: false,
          //         borderRadius: BorderRadius.circular(18),
          //         disabledHint: const Text(
          //           "No courses yet.",
          //           style: TextStyle(fontSize: 14),
          //         ),
          //         onChanged: (course) =>
          //             setState(() => selectedCourse = course),
          //         value: selectedCourse,
          //         items: snapshot.data
          //             ?.map((e) => DropdownMenuItem(child: Text(e.title.toString())))
          //             .toList(),
          //       );
          //     }),
          
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
        Trainer trainer = Trainer(
          id: widget.trainer?.id,
          firstName: firstNameCon.text,
          // TODO: middle name texteditingcontroller
          // middleName: /* controller */,
          lastName: lastNameCon.text,
          email: emailCon.text,
          contactNumber: contactCon.text,
        );

        supabase.from('trainer').upsert(trainer.toJson()).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Successfully added trainer: ${widget.trainer!.toString()}."),
              backgroundColor: Colors.green,
            ));

          Navigator.of(context).pop();
        }).catchError((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Unsuccessful adding trainer. Please try again."),
              backgroundColor: Colors.redAccent,
            ));
        });
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
        onPressed: () {
          final supabase = Supabase.instance.client;
          final id = widget.trainer!.id!;

          supabase.from('trainer').delete().eq('id', id).whenComplete(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Successfully deleted trainer: ${widget.trainer!.toString()}."),
              backgroundColor: Colors.green,
            ));

            Navigator.of(context).pop();
          }).catchError((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Unsuccessful deleting trainer: ${widget.trainer!.toString()}. Please try again."),
              backgroundColor: Colors.green,
            ));
          });
        },
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.black87),
        ));
  }
}
