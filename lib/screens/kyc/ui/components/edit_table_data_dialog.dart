import 'package:flutter/material.dart';

class EditTableDataDialog extends StatefulWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const EditTableDataDialog({Key key, this.title, this.content, this.actions}) : super(key: key);

  @override
  _EditTableDataDialogState createState() => _EditTableDataDialogState();
}

class _EditTableDataDialogState extends State<EditTableDataDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: kElevationToShadow[5],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Flexible(child: widget.content),
          SizedBox(
            height: 22,
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ButtonBar(
              buttonPadding: EdgeInsets.zero,
              children: widget.actions,
            ),
          ),
        ],
      ),
    );
  }
}
