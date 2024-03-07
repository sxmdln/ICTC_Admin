import 'package:flutter/material.dart';

class TrainersForm extends StatefulWidget {
  const TrainersForm({super.key, this.trainer});

  final Object? trainer;

  @override
  State<TrainersForm> createState() => _TrainersFormState();
}

class _TrainersFormState extends State<TrainersForm> {
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
              Stack(children: [
                const CircleAvatar(
                  backgroundColor: Color(0xff153faa),
                  // backgroundImage: AssetImage("assets/photos/photo-1.jpg"),
                  radius: 90.0,
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      // alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(90.0),
                            color: Colors.green),
                      // alignment: Alignment.topLeft,
                      child: IconButton(icon: const Icon(Icons.add, size: 24, color: Colors.white),
                      // constraints: BoxConstraints(maxHeight: 15, maxWidth: 15),
                      splashRadius: 20,
                      // iconSize: 30,
                      onPressed: (){},
                      )))
              ]),
              const Padding(padding: EdgeInsets.all(10)),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
                hintText: "Enter Name",
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
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
              fontWeight: FontWeight.w300,
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
                hintStyle: TextStyle(fontSize: 18),
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
