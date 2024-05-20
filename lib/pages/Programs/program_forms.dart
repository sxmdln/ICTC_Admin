import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgramForm extends StatefulWidget {
  const ProgramForm({super.key, this.program});

  final Program? program;

  @override
  State<ProgramForm> createState() => _ProgramFormState();
}

class _ProgramFormState extends State<ProgramForm> {
  late Future<String?> avatarUrl = getImageUrl();

  Future<String?> getImageUrl([String? path]) async {
    try {
      final url = await Supabase.instance.client.storage
          .from('programs')
          .createSignedUrl('${widget.program?.id}/image.png', 60);
      return url;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    print("program ${widget.program?.id}");

    progTitleCon = TextEditingController(text: widget.program?.title);
    progDescriptionCon =
        TextEditingController(text: widget.program?.description);
  }

  final formKey = GlobalKey<FormState>();
  late TextEditingController progTitleCon, progDescriptionCon;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CupertinoTextFormFieldRow(
              controller: progTitleCon,
              prefix: const Row(
                children: [
                  Text("Program Title",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              // padding: EdgeInsets.only(left: 90),
              placeholder: "e.g. Microcredentials",
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
          ),

          // DESCRIPTION
          Flexible(
            child: CupertinoTextFormFieldRow(
              controller: progDescriptionCon,
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
                  SizedBox(width: 22),
                ],
              ),
              // padding: EdgeInsets.only(left: 90),
              placeholder: "Program Description",
              placeholderStyle: const TextStyle(
                fontSize: 14, //
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
                final path = "${widget.program?.id}/image.$extension";

                await supa.storage
                    .from('programs')
                    .uploadBinary(path, bytes,
                        fileOptions: const FileOptions(upsert: true))
                    .whenComplete(() {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Image uploaded successfully!")));

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

          const SizedBox(height: 20),
          Row(
            children: [
              // Expanded(child: SizedBox(child: cancelButton())),
              if (widget.program != null)
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
    return ElevatedButton(
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
        Program program = Program(
          id: widget.program?.id,
          title: progTitleCon.text,
          description: progDescriptionCon.text,
        );

        print(program.toJson());

        supabase.from('program').upsert(program.toJson()).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Successfully added program"),
            backgroundColor: Colors.green,
          ));

          Navigator.of(context).pop();
        }).catchError((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Unsuccessful adding program. Please try again."),
            backgroundColor: Colors.redAccent,
          ));
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
    return ElevatedButton(
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
          final id = widget.program!.id!;

          supabase.from('program').delete().eq('id', id).whenComplete(() {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Successfully deleted program ${widget.program!.toString()}."),
              backgroundColor: Colors.orangeAccent,
            ));

            Navigator.of(context).pop();
          }).catchError((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Error deleting program: ${widget.program!.toString()}. Please try again."),
              backgroundColor: Colors.redAccent,
            ));
          });
        },
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.black87),
        ));
  }
}
