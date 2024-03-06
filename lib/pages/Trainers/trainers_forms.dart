import 'package:flutter/material.dart';

class TrainerForm extends StatefulWidget {
  const TrainerForm({Key? key, this.trainer}) : super(key: key);

  final Object? trainer;

  @override
  State<TrainerForm> createState() => _TrainerFormState();
}

class _TrainerFormState extends State<TrainerForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                  radius: 80,
                ),
              const Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () {}, 
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                      ),
                      Text("Add Photo")
                    ],
                  )),
              )
            ],
          ),
                    const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                ),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
                hintText: "Email Address",
                hintStyle: TextStyle(fontSize: 18, fontFamily: "Montserrat"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
                hintText: "Contact Number",
                hintStyle: TextStyle(fontSize: 18, fontFamily: "Montserrat"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone)),
          ),

          
          const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
                hintText: "Handled Course",
                hintStyle: TextStyle(fontSize: 18, fontFamily: "Montserrat"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.book)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
                hintText: "Description",
                hintStyle: TextStyle(fontSize: 18, fontFamily: "Montserrat"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
                hintText: "Date",
                hintStyle: TextStyle(fontSize: 18, fontFamily: "Montserrat"),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_month)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: SizedBox(child: cancelButton())),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(child: saveButton()),
              ),
              const SizedBox(width: 10),
              if (widget.trainer != null)
                Expanded(
                  child: SizedBox(child: deleteButton()),
                ),
            ],
          )
        ],
      ),
    );
  }

  Widget saveButton() {
    return FilledButton(
      onPressed: () {},
      child: const Text(
        "Save",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget cancelButton() {
    return FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey;
            }
            return Colors.grey;
          }),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.white,
          ),
        ));
  }

  Widget deleteButton() {
    return FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.red;
            }
            return Colors.red;
          }),
        ),
        onPressed: () {},
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.white),
        ));
  }
}
