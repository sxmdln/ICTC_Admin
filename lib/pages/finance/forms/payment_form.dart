import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/trainer.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key, this.payment});

  final Object? payment;

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  @override
  void initState() {
    super.initState();

    datePickerController = TextEditingController();
    totalStudentsCon = TextEditingController();
    totalSaleCon = TextEditingController();
    totalDiscountCon = TextEditingController();
    totalIncomeCon = TextEditingController();
  }

  Trainer? selectedTrainer;
  Program? selectedProgram;
  Course? selectedCourse;

  final formKey = GlobalKey<FormState>();
  late TextEditingController datePickerController,
      totalStudentsCon,
      totalSaleCon,
      totalDiscountCon,
      totalIncomeCon;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 19,
              ),
              const Text(
                "Name of Program",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                width: 12,
              ),
              DropdownButton(
                isExpanded: false,
                isDense: false,
                borderRadius: BorderRadius.circular(18),
                disabledHint: const Text(
                  "No programs yet.",
                  style: TextStyle(fontSize: 14),
                ),
                onChanged: (program) =>
                    setState(() => selectedProgram = program),
                value: selectedProgram,
                items:
                    null, //TODO: Dynamically populate dropdown items with program names
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 19,
              ),
              const Text(
                "Name of Course",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                width: 12,
              ),
              DropdownButton(
                isExpanded: false,
                isDense: false,
                borderRadius: BorderRadius.circular(18),
                disabledHint: const Text(
                  "No courses under this program yet.",
                  style: TextStyle(fontSize: 14),
                ),
                onChanged: (course) =>
                    setState(() => selectedCourse = course),
                value: selectedCourse,
                items:
                    null, //TODO: Dynamically populate dropdown items with: (courses under a program) names
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 19,
              ),
              const Text(
                "Name of Trainer",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                width: 12,
              ),
              DropdownButton(
                isExpanded: false,
                isDense: false,
                borderRadius: BorderRadius.circular(18),
                disabledHint: const Text(
                  "No trainers yet.",
                  style: TextStyle(fontSize: 14),
                ),
                onChanged: (trainer) =>
                    setState(() => selectedTrainer = trainer),
                value: selectedTrainer,
                items:
                    null, //TODO: Dynamically populate dropdown items with trainer names
              ),
            ],
          ),
          TextField(
            controller: datePickerController,
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
            controller: totalDiscountCon,
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
            controller: totalStudentsCon,
            prefix: const Row(
              children: [
                Text("Training Fee",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 18),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "", //TODO: Automatically get the COURSE Cost or the course registration fee.
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
            controller: totalSaleCon,
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
            placeholder: "", //TODO: Automatically get the DISCOUNT price based on the trainee_type/voucher code used.
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
            controller: totalIncomeCon,
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
            // padding: EdgeInsets.only(left: 90),
            placeholder: ".",
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
              // prefixIcon: Icon(Icons.person)
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

  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2024),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}
