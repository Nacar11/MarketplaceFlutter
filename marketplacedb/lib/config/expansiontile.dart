import 'package:flutter/material.dart';

class Expantiontile extends StatefulWidget {
  final String titleText;
  const Expantiontile({Key? key, required this.titleText}) : super(key: key);

  @override
  State<Expantiontile> createState() => ExpantiontileState();
}

class ExpantiontileState extends State<Expantiontile> {
  bool _customIcon = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: Text(widget.titleText), // Use the titleText parameter here
          trailing: Icon(
            _customIcon ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
          ),
          children: const <Widget>[
            ListTile(
              title: Text('Test'),
            )
          ],
          onExpansionChanged: (bool expanded) {
            setState(() {
              _customIcon = expanded;
            });
          },
        ),
      ],
    );
  }
}
