import 'package:flutter/material.dart';
import 'package:ictc_admin/models/program.dart';

class ProgramViewMore extends StatefulWidget {
  final Program program;
  const ProgramViewMore({required this.program, super.key});

  @override
  State<ProgramViewMore> createState() => _ProgramViewMoreState();
}

class _ProgramViewMoreState extends State<ProgramViewMore> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 500,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("PROGRAM",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline)),
                const SizedBox(height: 30),
                Text(widget.program.title,
                    style:
                        const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                Text(
                  widget.program.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: true,
                      applyHeightToLastDescent: true),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(Icons.school_rounded,
                        size: 14, color: Color(0xff153faa)),
                    SizedBox(width: 5),
                    Text(
                      "12 courses", //TODO: add counter functionality  //TODO: view all courses button
                      style: TextStyle(fontSize: 12, color: Color(0xff153faa)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: AspectRatio(
                    aspectRatio: 20 / 10,
                    child: Image.asset(
                      'assets/images/program1.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
