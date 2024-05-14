import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:ictc_admin/models/voucher.dart';
import 'package:ictc_admin/pages/Vouchers/vouchers_forms.dart';
import 'package:ictc_admin/pages/Vouchers/vouchers_viewMore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VouchersPage extends StatefulWidget {
  const VouchersPage({super.key});

  @override
  State<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage>
    with AutomaticKeepAliveClientMixin {
  // VoucherViewMore? voucherProfileWidget;
  late Stream<List<Voucher>> _vouchers;

  @override
  void initState() {
    _vouchers = Supabase.instance.client.from('voucher').stream(primaryKey: [
      'id'
    ]).map((data) => data.map((e) => Voucher.fromJson(e)).toList());

    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
  // onListRowTap(Voucher voucher) {
  //   setState(() => voucherProfileWidget =
  //       VoucherViewMore(voucher: voucher, key: ValueKey<Voucher>(voucher)));
  // }

  void closeProfile() {
    // setState(() => voucherProfileWidget = null);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 100),
                padding: const EdgeInsets.only(right: 5, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [addButton()],
                ),
              ),
              buildDataTable(),
            ],
          ),
        ),
        const VerticalDivider(
          color: Colors.black87,
          thickness: 0.1,
        ),
        // voucherProfileWidget != null
            // ? Flexible(
            //     flex: 1,
            //     child: Stack(
            //       children: [
            //         // voucherProfileWidget!,
            //         Container(
            //           padding: const EdgeInsets.only(top: 16, right: 16),
            //           alignment: Alignment.topRight,
            //           child: IconButton(
            //             onPressed: closeProfile,
            //             icon: const Icon(Icons.close),
            //           ),
            //         )
            //       ],
            //     ))
            // : Container(),
      ],
    );
  }

    Widget buildDataTable() {
    return StreamBuilder(
      stream: _vouchers,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Expanded(
            child: Center(
              child: Text('No vouchers available'),
            ),
          );
        }

        return Expanded(
          child: DataTable2(
            showCheckboxColumn: false,
            showBottomBorder: true,
            horizontalMargin: 30,
            isVerticalScrollBarVisible: true,
            columns: const [
              DataColumn2(label: Text('Voucher Code')),
              DataColumn2(label: Text('Voucher Amount')),
              // DataColumn2(label: Text('')),
              DataColumn2(label: Text('Options')),
            ],
            rows: snapshot.data!.map((e) => buildRow(e)).toList(),
          ),
        );
      },
    );
  }


  DataRow2 buildRow(Voucher voucher) {
    return DataRow2(onSelectChanged: (selected) {}, cells: [
      DataCell(Text(voucher.voucherCode)),
      DataCell(Text(voucher.percentOff.toString())),
      // DataCell(Text(voucher.percentOff.toString())),
      // const DataCell(Text('')),
      DataCell(Row(
        children: [
          editButton(voucher),
          const Padding(padding: EdgeInsets.all(5)),
          viewButton(voucher)
        ],
      )),
    ]);
  }

  Widget addButton() {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size.fromWidth(155))),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return addDialog();
          },
        );
      },

      child: Container(
        constraints: const BoxConstraints(
            maxWidth: 160, minHeight: 36.0), // min sizes for Material buttons
        alignment: Alignment.center,
        child:
            const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            CupertinoIcons.add,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(width: 6),
          Text(
            'Add a Voucher',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

  Widget addDialog() {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: const EdgeInsets.only(left: 20, right: 30, top: 40),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: FractionalOffset.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Add a Voucher",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Flexible(
        flex: 2,
        child: SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.height * 0.28,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VoucherForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget editButton(Voucher voucher) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return editDialog(voucher);
            },
          );
        },
        child: const Row(
          children: [
            Icon(
              Icons.edit,
              size: 20,
              color: Color(0xff153faa),
            ),
            SizedBox(
              width: 5,
            ),
            Text("Edit"),
          ],
        ));
  }

  Widget editDialog(Voucher voucher) {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: const EdgeInsets.only(left: 20, right: 30, top: 40),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: FractionalOffset.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          const Text(
            "Edit a Voucher",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Flexible(
        flex: 2,
        child: SizedBox(
          width: 400,
          height: MediaQuery.of(context).size.height * 0.28,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VoucherForm(voucher: voucher),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget viewButton(Voucher voucher) {
    return TextButton(
        onPressed: () {
          // onListRowTap(voucher);
        },
        child: const Row(
          children: [
            Icon(
              Icons.visibility,
              size: 20,
              color: Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "View",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ));
  }
}
