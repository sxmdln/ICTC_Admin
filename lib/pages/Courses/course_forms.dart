import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/trainer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CourseForm extends StatefulWidget {
  const CourseForm({Key? key, this.course}) : super(key: key);

  final Course? course;

  @override
  _CourseFormState createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  late TextEditingController courseTitleCon,
      descriptionCon,
      costCon,
      durationCon,
      scheduleCon,
      venueCon;
  List<Program>? programs;
  List<Trainer>? trainers;
  int? programValue = 1; // Set a default value for programValue
  int? trainerValue;

  @override
  void initState() {
    super.initState();

    print("course ${widget.course?.id}");

    courseTitleCon = TextEditingController();
    descriptionCon = TextEditingController();
    costCon = TextEditingController();
    durationCon = TextEditingController();
    scheduleCon = TextEditingController();
    venueCon = TextEditingController();

    // Fetch the list of programs from the database
    fetchPrograms();
    fetchTrainers();

    // Initialize programValue to the first program in the programs list or the course's programId
    if (widget.course != null) {
      programValue = widget.course!.programId;
    }

    // Initialize trainerValue to the first trainer in the trainers list or the course's trainerId
    if (widget.course != null) {
      trainerValue = widget.course!.trainerId;
    }
  }

  Future<void> fetchPrograms() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('program').select('*');

    setState(() {
      programs = response.map((e) => Program.fromJson(e)).toList();
    });
  }

  Future<void> fetchTrainers() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('trainer').select('*');

    setState(() {
      trainers = response.map((e) => Trainer.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: DropdownButtonFormField<int>(
              value: programValue,
              decoration: InputDecoration(
                labelText: "Program Name",
                border: OutlineInputBorder(),
              ),

              items: programs?.map((program) {
                return DropdownMenuItem<int>(
                  value: program.id,
                  child: Text(program.title!),
                );

              }).toList(),
              onChanged: (value) {
                setState(() {
                  programValue = value!;
                });
              },
            ),
          ),

          Flexible(
            child: DropdownButtonFormField<int>( 
              value: trainerValue,
              decoration: InputDecoration(
                labelText: "Trainer",
                border: OutlineInputBorder(),
              ),

              items: trainers?.map((trainer) {
                return DropdownMenuItem<int>( 
                  value: trainer.id,
                  child: Text('${trainer.firstName} ${trainer.lastName}'),
                );

              }).toList(),

              onChanged: (value) {
                setState(() {
                  trainerValue = value!;
                });
              },
            ),
          ),

          Flexible(
            child: CupertinoTextFormFieldRow(
              controller: courseTitleCon,
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
        int? programId = programValue;
        int? trainerId = trainerValue;

        if (programId == null || trainerId == null) {
          // Handle the case where programId or trainerId is null
          return;
        }

        Course course = Course(
          id: widget.course?.id,
          programId: programId,
          trainerId: trainerId,
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
        onPressed: () {},
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.black87),
        ));
  }
}