import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/trainer.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:file_picker/file_picker.dart';

class CourseForm extends StatefulWidget {
  const CourseForm({super.key, this.course});

  final Course? course;

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  late Future<String?> avatarUrl = getImageUrl();

  Future<String?> getImageUrl([String? path]) async {
    try {
      final url = await Supabase.instance.client.storage
          .from('images')
          .createSignedUrl('${widget.course?.id}/image.png', 60);
      return url;
    } catch (e) {
      return null;
    }
  }

  // String getImageUrl(String path) {
  //   final supa = Supabase.instance.client;
  //   return supa.storage.from('images').getPublicUrl(path).data!;
  // }

  final formKey = GlobalKey<FormState>();
  final DateRangePickerController dateRangeController =
      DateRangePickerController();
  Program? selectedProgram;
  Trainer? selectedTrainer;
  late TextEditingController courseTitleCon,
      descriptionCon,
      costCon,
      durationCon,
      scheduleCon,
      venueCon;

  late String? startDateCon, endDateCon;
  // late String avatarUrl;

  @override
  void initState() {
    super.initState();

    print("course end date ${widget.course?.endDate.toString()}");
    // print(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
    // print(DateTime.parse(endDateCon));

    courseTitleCon = TextEditingController(text: widget.course?.title);
    descriptionCon = TextEditingController(text: widget.course?.description);
    costCon = TextEditingController(text: widget.course?.cost.toString());
    durationCon = TextEditingController(text: widget.course?.duration);
    scheduleCon = TextEditingController(text: widget.course?.schedule);
    venueCon = TextEditingController(text: widget.course?.venue);

    startDateCon = widget.course?.startDate != null
        ? DateFormat.yMMMMd().format(widget.course!.startDate!)
        : "None";

    endDateCon = widget.course?.endDate != null
        ? DateFormat.yMMMMd().format(widget.course!.endDate!)
        : "None";

    dateRangeController.selectedRange = PickerDateRange(
        widget.course?.startDate ?? DateTime.now(),
        widget.course?.endDate ?? DateTime.now().add(const Duration(days: 3)));

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

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startDateCon = DateFormat.yMMMMd('en_US').format(args.value.startDate);
      endDateCon = DateFormat.yMMMMd('en_US')
          .format(args.value.endDate ?? args.value.startDate);
    });
  }

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
          DropdownSearch<Program>(
            asyncItems: (filter) => fetchPrograms(),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                prefixIcon: const Icon(
                  Icons.school,
                  size: 15,
                  color: Color(0xff153faa),
                ),
                labelText: "Program",
                labelStyle: const TextStyle(fontSize: 14),
                filled: false,
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
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: const Icon(
                  Icons.person,
                  size: 15,
                  color: Color(0xff153faa),
                ),
                labelStyle: const TextStyle(fontSize: 14),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: false,
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
                borderRadius: BorderRadius.circular(10),
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
                borderRadius: BorderRadius.circular(10),
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
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Material(
            color: Colors.black12,
            child: InkWell(
              splashColor: Colors.black26,
              onTap: () async {
                // Select an image
                final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['png']);

                if (result == null || result.files.isEmpty) {
                  return;
                }

                final file = result.files.first;
                final bytes = file.bytes;
                final extension = file.extension;

                if (bytes == null || extension == null) {
                  return;
                }

                // Upload image to Supabase
                final supa = Supabase.instance.client;
                final path = "${widget.course?.id}/image.$extension";

                await supa.storage
                    .from('images')
                    .uploadBinary(path, bytes,
                        fileOptions: const FileOptions(upsert: true))
                    .whenComplete(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Image uploaded successfully!")));

                  setState(() {
                    avatarUrl = getImageUrl(path);
                  });
                });
              },
              child: Container(
                color: Colors.transparent,
                height: 40,
                width: MediaQuery.of(context).size.width * 0.2,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Upload Image",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            // IMAGE
            margin: EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width * 0.2,
            height: 360,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
            ),
            child: FutureBuilder<String?>(
              future: avatarUrl,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final url = snapshot.data!;
                  return Image.network(
                    url,
                    fit: BoxFit.cover,
                  );
                }

                return const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_rounded),
                      SizedBox(width: 5),
                      Text('Add a picture.'),
                    ],
                  ),
                );
              },
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
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(
            height: 6,
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
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Column(
            children: <Widget>[
              SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(
                        'Start Date: ' '$startDateCon',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )),
                      Container(
                          child: Text(
                        'End Date: ' '$endDateCon',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ))
                    ],
                  )),
              Card(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                child: SfDateRangePicker(
                  controller: dateRangeController,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: selectionChanged,
                  allowViewNavigation: false,
                ),
              )
            ],
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
          cost: int.tryParse(costCon.text)!,
          duration: durationCon.text,
          schedule: scheduleCon.text,
          venue: venueCon.text,
          startDate: DateFormat.yMMMMd('en_US').parse(startDateCon!),
          endDate: DateFormat.yMMMMd('en_US').parse(endDateCon!),
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

  // startDate({required BuildContext context}) async {
  //   DateTime? pickedStartDate = await showDatePicker(
  //     context: context,
  //     lastDate: DateTime.now(),
  //     firstDate: DateTime(2024),
  //     initialDate: DateTime.now(),
  //   );
  //   if (pickedStartDate == null) return;
  //   startDateCon = DateFormat('yyyy-MM-dd').format(pickedStartDate);
  // }

  // endDate({required BuildContext context}) async {
  //   DateTime? pickedEndDate = await showDatePicker(
  //     context: context,
  //     lastDate: DateTime.now(),
  //     firstDate: DateTime(2024),
  //     initialDate: DateTime.now(),
  //   );
  //   if (pickedEndDate == null) return;
  //   endDateCon.text = DateFormat('yyyy-MM-dd').format(pickedEndDate);
  // }
}
