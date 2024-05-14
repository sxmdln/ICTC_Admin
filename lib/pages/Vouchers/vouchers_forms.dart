import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ictc_admin/models/voucher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VoucherForm extends StatefulWidget {

  const VoucherForm({super.key, this.voucher});

  final Voucher? voucher;

  @override
  State<VoucherForm> createState() => _VoucherFormState();

}

class _VoucherFormState extends State<VoucherForm> {

  @override
  void initState() {

    super.initState();

    print("voucher ${widget.voucher?.id}");

    progTitleCon = TextEditingController(text: widget.voucher?.voucherCode);
    progDescriptionCon = TextEditingController(text: widget.voucher?.percentOff.toString());
    
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
                  Text("Voucher Title",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 12),
                ],
              ),
              // padding: EdgeInsets.only(left: 90),
              placeholder: "e.g. 100PercentOff",
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
                  Text("Amount",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  SizedBox(width: 22),
                ],
              ),
              // padding: EdgeInsets.only(left: 90),
              placeholder: "Amount",
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

          const SizedBox(height: 20),
          Row(
            children: [
              // Expanded(child: SizedBox(child: cancelButton())),
              if (widget.voucher != null)
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
        Voucher voucher = Voucher(
          id: widget.voucher?.id,
          voucherCode: progTitleCon.text,
          percentOff: double.tryParse(progDescriptionCon.text) ?? 0.0,

        );

        print(voucher.toJson());

        supabase.from('voucher').upsert(voucher.toJson()).whenComplete(() {
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
          final id = widget.voucher!.id!;
          

          supabase.from('voucher').delete().eq('id', id).whenComplete(() {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Delete successful!")));

            Navigator.of(context).pop();
          }).catchError((_) {
            ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("An error occured.")));
          });
        },
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.black87),
        ));
  }
}
