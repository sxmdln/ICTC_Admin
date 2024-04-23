import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesForm extends StatefulWidget {
  const ExpensesForm({super.key, this.expense});

  final Object? expense;

  @override
  State<ExpensesForm> createState() => _ExpensesFormState();
}

class _ExpensesFormState extends State<ExpensesForm> {
  @override
  void initState() {
    super.initState();

    datePickerController = TextEditingController();
    nameCon = TextEditingController();
    courseCon = TextEditingController();
    costCon = TextEditingController();


  }

  final formKey = GlobalKey<FormState>();
  late TextEditingController datePickerController, nameCon, courseCon,costCon;

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

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 2),
            controller: datePickerController,
            readOnly: true,
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              hintText: "Date of Expense: ",
              hintStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 2),
              filled: false,
              isDense: true,
              prefixIcon: Icon(Icons.calendar_month, size: 20),
            ),
            onTap: () => onTapFunction(context: context),
          ),
          const SizedBox(height: 10),
          CupertinoTextFormFieldRow(
            controller: nameCon,
            prefix: const Row(
              children: [
                Text("Name of Expense",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 20),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "Enter name of expense",
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
            controller: courseCon,
            prefix: const Row(
              children: [
                Text("Course Name",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 45),
              ],
            ),
            // padding: EdgeInsets.only(left: 90),
            placeholder: "Enter course name",
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
            controller: costCon,
            prefix: const Row(
              children: [
                Text("Total Cost",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(width: 66),
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
              borderRadius: BorderRadius.circular(18),
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
}
