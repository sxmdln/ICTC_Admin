import 'package:dropdown_search/dropdown_search.dart';
import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/expense.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpensesForm extends StatefulWidget {
  const ExpensesForm({super.key, this.expense});

  final Expense? expense;

  @override
  State<ExpensesForm> createState() => _ExpensesFormState();
}

class _ExpensesFormState extends State<ExpensesForm> {
  Program? selectedProgram;
  Course? selectedCourse;

  final formKey = GlobalKey<FormState>();
  late TextEditingController orDateCon, orNumberCon, particularsCon, amountCon;

  @override
  void initState() {
    super.initState();

    orDateCon = TextEditingController(
        text: widget.expense?.orDate != null
        ? DateFormat.yMMMMd().format(widget.expense!.orDate!)
        : "None"
        );
    orNumberCon = TextEditingController(text: widget.expense?.orNumber ?? "");
    particularsCon =
        TextEditingController(text: widget.expense?.particulars ?? "");
    amountCon =
        TextEditingController(text: widget.expense?.amount.toString() ?? "");

    if (widget.expense != null) {
      if (widget.expense!.programId != null) {
        Supabase.instance.client
            .from('program')
            .select()
            .eq('id', widget.expense!.programId as Object)
            .limit(1)
            .withConverter((data) => Program.fromJson(data.first))
            .then((value) => setState(() => selectedProgram = value));
      }
      if (widget.expense!.courseId != null) {
        Supabase.instance.client
            .from('course')
            .select()
            .eq('id', widget.expense!.courseId as Object)
            .limit(1)
            .withConverter((data) => Course.fromJson(data.first))
            .then((value) => setState(() => selectedCourse = value));
      }
    }
  }

  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2024),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    orDateCon.text = DateFormat.yMMMMd().format(pickedDate);
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
          InkWell(
            onTap: () => onTapFunction(context: context),
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
          const SizedBox(height: 10),
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
              borderRadius: BorderRadius.circular(10),
              // prefixIcon: Icon(Icons.person)
            ),
          ),
          CupertinoTextFormFieldRow(
            controller: particularsCon,
            prefix: const Row(
              children: [
                Text("Particulars",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 25),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "Particulars",
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
            controller: amountCon,
            prefix: const Row(
              children: [
                Text("Total Cost",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                SizedBox(width: 30),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "Enter total cost of expense",
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
          const SizedBox(height: 20),
          Row(
            children: [
              // Expanded(child: SizedBox(child: cancelButton())),
              if (widget.expense != null)
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
          final expense = Expense(
            id: widget.expense?.id,
            programId: selectedProgram!.id!,
            courseId: selectedCourse!.id!,
            orDate: DateTime.parse(orDateCon.text),
            orNumber: orNumberCon.text,
            particulars: particularsCon.text,
            amount: double.parse(amountCon.text),
          );
print(expense.orDate.toString());
          print(expense.toJson());

          Supabase.instance.client
              .from('expense')
              .upsert(expense.toJson())
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Expense saved successfully."),
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
          final id = widget.expense!.id!;

          supabase.from('expense').delete().eq('id', id).whenComplete(() {
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
