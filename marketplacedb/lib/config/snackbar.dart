import 'package:flutter/material.dart';

class SnackBarAwesome extends StatefulWidget {
  final String message;
  final int type;
  const SnackBarAwesome({Key? key, required this.message, required this.type})
      : super(key: key);

  @override
  State<SnackBarAwesome> createState() =>
      SnackBarAwesomeState(message: message, type: type);
}

class SnackBarAwesomeState extends State<SnackBarAwesome> {
  final String message;
  final int type;

  SnackBarAwesomeState({required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Stack(children: [
        Container(
            padding: EdgeInsets.all(16),
            height: 90,
            decoration: BoxDecoration(
              color: Color(0xFFC72C41),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(children: [
              const SizedBox(width: 48),
              Expanded(
                  child: Column(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Flutter",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ])
              ]))
            ]))
      ]),
      behavior: SnackBarBehavior.floating,
    );
  }
}
