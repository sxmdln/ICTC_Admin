import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/trainer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CourseForm extends StatefulWidget {
  const CourseForm({super.key, this.course});

  final Course? course;

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  @override
  void initState() {
    super.initState();

    print("course ${widget.course?.id}");

    courseTitleCon = TextEditingController(text: widget.course?.title);
    descriptionCon = TextEditingController(text: widget.course?.description);
    costCon = TextEditingController(text: widget.course?.cost?.toString());
    durationCon = TextEditingController(text: widget.course?.duration);
    scheduleCon = TextEditingController(text: widget.course?.schedule);
    venueCon = TextEditingController(text: widget.course?.venue);

    if (widget.course != null) {
      Supabase.instance.client
          .from('program')
          .select()
          .eq('id', widget.course!.programId!)
          .limit(1)
          .withConverter((data) => Program.fromJson(data.first))
          .then((value) => setState(() => selectedProgram = value));
      Supabase.instance.client
          .from('trainer')
          .select()
          .eq('id', widget.course!.trainerId!)
          .limit(1)
          .withConverter((data) => Trainer.fromJson(data.first))
          .then((value) => setState(() => selectedTrainer = value));
    }
  }

  final formKey = GlobalKey<FormState>();

  Program? selectedProgram;
  Trainer? selectedTrainer;
  late TextEditingController courseTitleCon,
      descriptionCon,
      costCon,
      durationCon,
      scheduleCon,
      venueCon;

  Future<List<Program>> fetchPrograms({String? filter}) async {
    final supabase = Supabase.instance.client;
    List<Program> programs = await supabase
        .from('program')
        .select()
        .withConverter((data) => data.map((e) => Program.fromJson(e)).toList());

    return filter == null
        ? programs
        : programs.where((element) => element.title.contains(filter)).toList();
  }

  Future<List<Trainer>> fetchTrainers({String? filter}) async {
    final supabase = Supabase.instance.client;
    List<Trainer> trainers;
    trainers = await supabase
        .from('trainer')
        .select()
        .withConverter((data) => data.map((e) => Trainer.fromJson(e)).toList());

    return filter == null
        ? trainers
        : trainers
            .where((element) => element.toString().contains(filter))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // dropdown for programs
          // FutureBuilder(
          //   future: fetchPrograms(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else {
          //       final programs = snapshot.data!;
          //       return DropdownButtonFormField2<int>(
          //         isExpanded: true,
          //         decoration: InputDecoration(
          //           contentPadding: const EdgeInsets.symmetric(vertical: 16),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //         ),
          //         hint: const Text(
          //           'Select Program',
          //           style: TextStyle(fontSize: 14),
          //         ),
          //         value: programValue,
          //         onChanged: (value) {
          //           setState(() {
          //             programValue = value!;
          //           });
          //         },
          //         items: programs.map((program) {
          //           return DropdownMenuItem<int>(
          //             value: program.id,
          //             child: Text(
          //               program.title,
          //               style: const TextStyle(
          //                 fontSize: 14,
          //               ),
          //             ),
          //           );
          //         }).toList(),
          //         validator: (value) {
          //           if (value == null) {
          //             return 'Please select a program.';
          //           }
          //           return null;
          //         },
          //       );
          //     }
          //   },
          // ),

          //FutureBuilder(
          // future: Supabase.instance.client
          //     .from('program')
          //     .select()
          //     .withConverter(
          //         (data) => data.map((e) => Program.fromJson(e)).toList()),
          // builder: (context, snapshot) {
          //   if (!snapshot.hasData) {
          //     return const CircularProgressIndicator();
          //   }

          //   return DropdownButton(
          //     isExpanded: false,
          //     isDense: false,
          //     borderRadius: BorderRadius.circular(18),
          //     disabledHint: const Text(
          //       "No courses yet.",
          //       style: TextStyle(fontSize: 14),
          //     ),
          //     onChanged: (program) =>
          //         setState(() => programId = program),
          //     value: programId,
          //     items: snapshot.data
          //         ?.map((e) => DropdownMenuItem(child: Text(e.title.toString())))
          //         .toList(),
          //   );
          // }),

          // dropdown for trainers
          // FutureBuilder (
          //   future: fetchTrainers(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else if (snapshot.data!.isEmpty) {
          //       return const Text("No trainers yet.");
          //     } else {
          //       final trainers = snapshot.data!;
          //       return DropdownSearch<int>(
          //         isExpanded: true,
          //         decoration: InputDecoration(
          //           contentPadding: const EdgeInsets.symmetric(vertical: 16),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //         ),
          //         hint: const Text(
          //           'Select Trainer',
          //           style: TextStyle(fontSize: 14),
          //         ),
          //         value: trainerValue,
          //         onChanged: (value) {
          //           setState(() {
          //             trainerValue = value!;
          //           });
          //         },

          //         items: trainers.map((trainer) {
          //           return DropdownMenuItem<int>(
          //             value: trainer.id,
          //             child: Text(
          //               '${trainer.firstName} ${trainer.lastName}',
          //               style: const TextStyle(
          //                 fontSize: 14,
          //               ),
          //             ),
          //           );
          //         }).toList(),
          //         validator: (value) {
          //           if (value == null) {
          //             return 'Please select a trainer.';
          //           }
          //           return null;
          //         },
          //       );
          //     }
          //   },
          // ),

          DropdownSearch<Program>(
            asyncItems: (filter) => fetchPrograms(),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Program",
                filled: true,
              ),
            ),
            onChanged: (value) => setState(() => selectedProgram = value),
            selectedItem: selectedProgram,
            popupProps: const PopupProps.dialog(showSearchBox: true),
            compareFn: (item1, item2) => item1.id == item2.id,
            validator: (value) {
              if (value == null) {
                return "Select a program.";
              }

              return null;
            },
          ),

          const SizedBox(
            height: 6,
          ),

          DropdownSearch<Trainer>(
            asyncItems: (filter) => fetchTrainers(),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Trainer",
                filled: true,
              ),
            ),
            onChanged: (value) => setState(() => selectedTrainer = value),
            selectedItem: selectedTrainer,
            popupProps: const PopupProps.dialog(showSearchBox: true),
            
            compareFn: (item1, item2) => item1.id == item2.id,
            validator: (value) {
              if (value == null) {
                return "Select a trainer.";
              }

              return null;
            },
          ),

          const SizedBox(
            height: 6,
          ),
          
          Flexible(
            child: CupertinoTextFormFieldRow(
              controller: courseTitleCon,
              validator: isNotEmpty,
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
              placeholder: "e.g. Hacking Course",
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
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          Flexible(
            child: CupertinoTextFormFieldRow(
              controller: descriptionCon,
              validator: isNotEmpty,
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
              placeholder: "Course Description",
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
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          Flexible(
            child: CupertinoTextFormFieldRow(
              controller: costCon,
              validator: isNotEmpty,
              prefix: const Row(
                children: [
                  Text("Cost",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              placeholder: "Course Cost",
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
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          Flexible(
            child: CupertinoTextFormFieldRow(
              controller: durationCon,
              validator: isNotEmpty,
              prefix: const Row(
                children: [
                  Text("Duration",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              placeholder: "Course Duration",
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
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          Flexible(
            child: CupertinoTextFormFieldRow(
              controller: scheduleCon,
              validator: isNotEmpty,
              prefix: const Row(
                children: [
                  Text("Schedule",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              placeholder: "Course Schedule",
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
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          Flexible(
            child: CupertinoTextFormFieldRow(
              controller: venueCon,
              validator: isNotEmpty,
              prefix: const Row(
                children: [
                  Text("Venue",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              placeholder: "Course Venue",
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
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
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

  String? isNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter text.";
    }

    return null;
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

        if (!formKey.currentState!.validate()) {
          return;
        }

        Course course = Course(
          id: widget.course?.id,
          programId: selectedProgram!.id,
          trainerId: selectedTrainer!.id,
          title: courseTitleCon.text,
          description: descriptionCon.text,
          cost: int.tryParse(costCon.text),
          duration: durationCon.text,
          schedule: scheduleCon.text,
          venue: venueCon.text,
        );

        print(course.toJson());

        supabase.from('course').upsert(course.toJson()).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Upsert successful!")),
          );

          Navigator.of(context).pop();
        }).catchError((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("An error occurred.")),
          );
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
          final id = widget.course!.id!;

          supabase.from('course').delete().eq('id', id).whenComplete(() {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Delete successful!")));

            Navigator.of(context).pop();
          }).catchError((_) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("An error occured.")));
          });
        },
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.black87),
        ));
  }
}
