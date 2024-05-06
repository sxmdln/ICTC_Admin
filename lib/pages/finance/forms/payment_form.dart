import 'package:dropdown_search/dropdown_search.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/payment.dart';
import 'package:ictc_admin/models/trainer.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key, this.payment, this.course, this.program});
  final Program? program;
  final Course? course;
  final Payment? payment;

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  Trainer? selectedTrainer;
  Program? selectedProgram;
  Course? selectedCourse;

  final formKey = GlobalKey<FormState>();

  late TextEditingController orDateCon,
      orNumberCon,
      courseCostCon,
      discountCon,
      totalAmountCon,
      approvedCon;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    orDateCon = TextEditingController(
        text: widget.payment?.orDate.toString() ??
            DateFormat('yyyy-MM-dd').format(DateTime.now()));
    orNumberCon = TextEditingController(text: widget.payment?.orNumber ?? "");
    courseCostCon =
        TextEditingController(text: widget.course?.cost.toString() ?? "0.0");
    discountCon = TextEditingController(
        text: widget.payment?.discount.toString() ?? "0.0");
    totalAmountCon = TextEditingController(
        text:
            (double.parse(courseCostCon.text) - double.parse(discountCon.text))
                    .toString() ??
                "0.0");
    approvedCon = TextEditingController(
        text: widget.payment?.approved.toString() ?? "false");

    if (widget.payment != null) {
      Supabase.instance.client
          .from('program')
          .select()
          .eq('id', widget.course!.programId!)
          .limit(1)
          .withConverter((data) => Program.fromJson(data.first))
          .then((value) => setState(() => selectedProgram = value));
      Supabase.instance.client
          .from('course')
          .select()
          .eq('trainer_id', widget.course!.trainerId!)
          .limit(1)
          .withConverter((data) => Trainer.fromJson(data.first))
          .then((value) => setState(() => selectedTrainer = value));
      Supabase.instance.client
          .from('course')
          .select()
          .eq('program_id', widget.program!.id!)
          .withConverter((data) => Course.fromJson(data.first))
          .then((value) => setState(() => selectedCourse = value));
    }
  }

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

// TRAINERS
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

// COURSES
  Future<List<Course>> fetchCourses({String? filter}) async {
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
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Program",
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
          DropdownSearch<Course>(
            asyncItems: (filter) => fetchCourses(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Course",
                filled: false,
              ),
            ),
            onChanged: (value) {
              setState(() => selectedCourse = value);
              setState(() {
                courseCostCon.text = selectedCourse!.cost.toString();
              });
            },
            selectedItem: selectedCourse,
            popupProps: const PopupProps.dialog(showSearchBox: true),
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
          DropdownSearch<Trainer>(
            asyncItems: (filter) => fetchTrainers(),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Trainer",
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
          TextField(
            controller: orDateCon,
            readOnly: true,
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              hintText: "OR Date",
              hintStyle: TextStyle(fontSize: 14, height: 2),
              filled: false,
              isDense: true,
              prefixIcon: Icon(Icons.calendar_month, size: 20),
            ),
            onTap: () => onTapFunction(context: context),
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
                SizedBox(width: 20),
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
              borderRadius: BorderRadius.circular(18),
              // prefixIcon: Icon(Icons.person)
            ),
          ),
          CupertinoTextFormFieldRow(
            readOnly: true,
            controller: courseCostCon,
            prefix: const Row(
              children: [
                Text("Course Cost",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 18),
              ],
            ),
            //TODO: Automatically get the COURSE Cost or the course registration fee.

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
          CupertinoTextFormFieldRow(
            onChanged: (value) {
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
            // padding: EdgeInsets.only(left: 90),
            //TODO: Automatically get the DISCOUNT price based on the trainee_type/voucher code used.
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
            ),
          ),
          CupertinoTextFormFieldRow(
            controller: totalAmountCon,
            readOnly: true,
            prefix: const Row(
              children: [
                Text("Total Amount",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 27),
              ],
            ),
            // padding: EdgeInsets.only(left: 90)
            // TODO: Add a formula to get the sum of (registration fee - discount fee), then display it here.
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
            orDate: DateTime.parse(orDateCon.text),
            orNumber: orNumberCon.text,
            discount: double.parse(discountCon.text),
            totalAmount: double.parse(totalAmountCon.text),
            approved: false,
            courseId: selectedCourse!.id!,
            studentId: selectedTrainer!.id!,
            programId: selectedProgram!.id!,
          );
          print(payment.toJson());

          Supabase.instance.client
              .from('payment')
              .upsert(payment.toJson())
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Payment saved successfully."),
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
        onPressed: () {},
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.black87),
        ));
  }

  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2024),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    orDateCon.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}
