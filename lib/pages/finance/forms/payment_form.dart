import 'package:ictc_admin/models/trainer.dart';
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
          TextField(
            controller: datePickerController,
            readOnly: true,
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              hintText: "Date of Sale",
              hintStyle: TextStyle(fontSize: 14, height: 2),
              filled: true,
              isDense: true,
              prefixIcon: Icon(Icons.calendar_month, size: 20),
            ),
            onTap: () => onTapFunction(context: context),
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
          CupertinoTextFormFieldRow(
            controller: totalStudentsCon,
            prefix: const Row(
              children: [
                Text("Total Students",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 18),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "e.g. 10",
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
                Text("Total Sale",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 46),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "Enter the total payment acquired",
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
            controller: totalDiscountCon,
            prefix: const Row(
              children: [
                Text("Total Discount",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 20),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "Enter the total discounted cost",
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

            prefix: const Row(
              children: [
                Text("Total Income",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 27),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "Enter total income acquired.",
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
          const SizedBox(height: 90),
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
