import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/widgets.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/payment.dart';
import 'package:ictc_admin/models/register.dart';
import 'package:ictc_admin/models/trainee.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key, this.payment});
  final Payment? payment;

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  Trainee? selectedTrainee;
  Program? selectedProgram;
  Course? selectedCourse;

  final formKey = GlobalKey<FormState>();

  late TextEditingController orDateCon,
      orNumberCon,
      courseCostCon,
      discountCon,
      totalAmountCon,
      approvedCon;

  late DateTime? selectedDate;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    selectedDate = widget.payment?.orDate;

    orDateCon = TextEditingController(
        text: widget.payment?.orDate != null
            ? DateFormat.yMMMMd().format(widget.payment!.orDate)
            : "None");
    orNumberCon = TextEditingController(text: widget.payment?.orNumber ?? "");
    discountCon = TextEditingController(
        text: widget.payment?.discount.toString() ?? 0.toString());
    approvedCon = TextEditingController(
        text: widget.payment?.approved.toString() ?? "false");
    courseCostCon = TextEditingController();
    totalAmountCon = TextEditingController();

    if (widget.payment != null) {
      Supabase.instance.client
          .from('program')
          .select()
          .eq('id', widget.payment!.programId)
          .limit(1)
          .withConverter((data) => Program.fromJson(data.first))
          .then((value) => setState(() => selectedProgram = value));

      Supabase.instance.client
          .from('course')
          .select()
          .eq('id', widget.payment!.courseId)
          .limit(1)
          .withConverter((data) => Course.fromJson(data.first))
          .then((value) => setState(() {
                selectedCourse = value;
                courseCostCon.text = selectedCourse!.cost.toString();
                totalAmountCon.text = (double.parse(courseCostCon.text) -
                        double.parse(discountCon.text))
                    .toString();
              }));

      Supabase.instance.client
          .from('student')
          .select()
          .eq('id', widget.payment!.studentId)
          .limit(1)
          .withConverter((data) => Trainee.fromJson(data.first))
          .then((value) => setState(() => selectedTrainee = value));
    }

    print(widget.payment?.toJson());
  }

  orDate({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2024),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;

    setState(() {
      selectedDate = pickedDate;
      orDateCon.text = DateFormat.yMMMMd().format(pickedDate);
    });


// PROGRAMS
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

// TRAINEES
  Future<List<Trainee>> fetchTrainees({String? filter}) async {
    if (selectedCourse == null) return [];

    final supabase = Supabase.instance.client;

    final registrations = await supabase
        .from('registration')
        .select()
        .eq('course_id', selectedCourse!.id!)
        .eq('is_approved', false)
        .withConverter(
            (data) => data.map((e) => Register.fromJson(e)).toList());

    final List<Trainee> trainees = [];
    for (final register in registrations) {
      final trainee = await supabase
          .from('student')
          .select()
          .eq('id', register.studentId)
          .limit(1)
          .withConverter((data) => Trainee.fromJson(data.first));
      trainees.add(trainee);
    }

    return filter == null
        ? trainees
        : trainees
            .where((element) => element.toString().contains(filter))
            .toList();
  }

// COURSES
  Future<List<Course>> fetchCourses({String? filter}) async {
    if (selectedProgram == null) return [];

    final supabase = Supabase.instance.client;
    late final List<Course> programCourses;
    programCourses = await supabase
        .from('course')
        .select()
        .eq('program_id', selectedProgram!.id!)
        .withConverter((data) => data.map((e) => Course.fromJson(e)).toList());
    return filter == null
        ? programCourses
        : programCourses
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
            popupProps: PopupProps.dialog(
                title: Container(
                  padding: const EdgeInsets.all(30),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Select a Program",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                showSearchBox: true,
                constraints: const BoxConstraints(
                    maxHeight: 450,
                    maxWidth: 500,
                    minWidth: 500,
                    minHeight: 400)),
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
          DropdownSearch<Course>(
            asyncItems: (filter) => fetchCourses(),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(
                  Icons.book,
                  size: 15,
                  color: Color(0xff153faa),
                ),
                labelStyle: const TextStyle(fontSize: 14),
                labelText: "Course",
                filled: false,
              ),
            ),
            onChanged: (value) {
              setState(() => selectedCourse = value);
              setState(() {
                courseCostCon.text = selectedCourse!.cost.toString();
              });
              setState(() {
                totalAmountCon.text = (double.parse(courseCostCon.text) -
                        double.parse(discountCon.text))
                    .toString();
              });
            },
            selectedItem: selectedCourse,
            popupProps: PopupProps.dialog(
                showSearchBox: true,
                title: Container(
                  padding: const EdgeInsets.all(30),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Select a Course",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                constraints: const BoxConstraints(
                    maxHeight: 450,
                    maxWidth: 500,
                    minWidth: 500,
                    minHeight: 400)),
            compareFn: (item1, item2) => item1.id == item2.id,
            validator: (value) {
              if (value == null) {
                return "Select a course.";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 6,
          ),
          DropdownSearch<Trainee>(
            asyncItems: (filter) => fetchTrainees(),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: const Icon(
                  Icons.person,
                  size: 15,
                  color: Color(0xff153faa),
                ),
                labelStyle: const TextStyle(fontSize: 14),
                labelText: "Trainee",
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: false,
              ),
            ),
            onChanged: (value) => setState(() => selectedTrainee = value),
            selectedItem: selectedTrainee,
            popupProps: PopupProps.dialog(
                showSearchBox: true,
                title: Container(
                  padding: const EdgeInsets.all(30),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Select a Trainee",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                constraints: const BoxConstraints(
                    maxHeight: 450,
                    maxWidth: 500,
                    minWidth: 500,
                    minHeight: 400)),
            compareFn: (item1, item2) => item1.id == item2.id,
            validator: (value) {
              if (value == null) {
                return "Select a student.";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 6,
          ),
          InkWell(
            onTap: () => orDate(context: context),
            child: IgnorePointer(
              child: TextField(
                controller: orDateCon,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  alignLabelWithHint: true,
                  hintText: "OR Date",
                  hintStyle: const TextStyle(fontSize: 14, height: 0),
                  labelStyle: const TextStyle(fontSize: 14, height: 0),
                  filled: false,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(
                    Icons.calendar_month,
                    size: 15,
                    color: Color(0xff153faa),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          CupertinoTextFormFieldRow(
            controller: orNumberCon,
            prefix: const Row(
              children: [
                Text("OR Number",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 45),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "Enter OR Number",
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
              borderRadius: BorderRadius.circular(10),
              // prefixIcon: Icon(Icons.person)
            ),
          ),
          CupertinoTextFormFieldRow(
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() => discountCon.text = "0");
              }

              setState(() {
                totalAmountCon.text = (double.parse(courseCostCon.text) -
                        double.parse(discountCon.text))
                    .toString();
              });
            },
            controller: discountCon,
            prefix: const Row(
              children: [
                Text("Discounted Fee",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 25),
              ],
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
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          CupertinoTextFormFieldRow(
            enabled: false,
            readOnly: true,
            controller: courseCostCon,
            prefix: const Row(
              children: [
                Text("Course Cost",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 45),
              ],
            ),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            decoration: BoxDecoration(
              // border: ,
              border: Border.all(
                color: Colors.white,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10),
              // prefixIcon: Icon(Icons.person)
            ),
          ),
          CupertinoTextFormFieldRow(
            enabled: false,
            controller: totalAmountCon,
            readOnly: true,
            prefix: const Row(
              children: [
                Text("Total Amount",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                SizedBox(width: 37),
              ],
            ),
            // padding: EdgeInsets.only(left: 90)

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            decoration: BoxDecoration(
              // border: ,
              border: Border.all(
                color: Colors.white,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Expanded(child: SizedBox(child: cancelButton())),
              if (widget.payment != null)
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
        if (formKey.currentState!.validate()) {
          final payment = Payment(
            id: widget.payment?.id,
            orDate: selectedDate!,
            orNumber: orNumberCon.text,
            discount: double.parse(discountCon.text),
            totalAmount: double.parse(totalAmountCon.text),
            approved: true,
            courseId: selectedCourse!.id!,
            studentId: selectedTrainee!.id,
            programId: selectedProgram!.id!,
          );
          print(payment.toJson());

          Supabase.instance.client
              .from('payment')
              .upsert(payment.toJson())
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Successfully added!"),
              backgroundColor: Colors.green,
            ));
            Navigator.pop(context);
          });
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
        onPressed: () {

            final supabase = Supabase.instance.client;
          final id = widget.payment!.id!;

          supabase.from('payment').delete().eq('id', id).whenComplete(() {
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
