import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kratos_flutter/screens/kyc/ui/components/custom_form_fields.dart';
import 'package:kratos_flutter/screens/kyc/ui/components/edit_table_data_dialog.dart';

// Interface
class _ColumnCellPairs {
  final String cellTitle;
  final String modelClassKey;
  final String identifier;

  _ColumnCellPairs({this.cellTitle, this.modelClassKey, this.identifier = 'text'});
}

// Model
class _MCompanyDirectors {
  final String name;
  final String country;
  final String dob;
  final String nationality;
  final String passportNumber;
  final String passportDocument;
  final String authorizedSignatory;

  _MCompanyDirectors({this.name, this.country, this.dob, this.nationality, this.passportNumber, this.passportDocument, this.authorizedSignatory});

  Map<String, dynamic> _toMap() {
    return {
      "name": this.name,
      "country": this.country,
      "dob": this.dob,
      "nationality": this.nationality,
      "passportNumber": this.passportNumber,
      "passportDocument": this.passportDocument,
      "authorizedSignatory": this.authorizedSignatory,
    };
  }

  dynamic get(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

// UI
class CompanyUltimateBeneficiaryTable extends StatefulWidget {
  @override
  _CompanyUltimateBeneficiaryTableState createState() => _CompanyUltimateBeneficiaryTableState();
}

class _CompanyUltimateBeneficiaryTableState extends State<CompanyUltimateBeneficiaryTable> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _mobileFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _cpasswordFocus = FocusNode();

  List<_ColumnCellPairs> _columnCellPairs = [
    _ColumnCellPairs(cellTitle: "Name", modelClassKey: "name"),
    _ColumnCellPairs(cellTitle: "Country of Residence", modelClassKey: "country"),
    _ColumnCellPairs(cellTitle: "Date of Birth", modelClassKey: "dob"),
    _ColumnCellPairs(cellTitle: "Nationality", modelClassKey: "nationality"),
    _ColumnCellPairs(cellTitle: "Passport Number", modelClassKey: "passportNumber"),
    _ColumnCellPairs(cellTitle: "Passport Document", modelClassKey: "passportDocument", identifier: 'uploaded_doc'),
    _ColumnCellPairs(cellTitle: "Authorized Signatory", modelClassKey: "authorizedSignatory"),
  ];

  List<TableCell> columns = [];
  List<TableRow> rows = [];
  List<_MCompanyDirectors> data = [
    _MCompanyDirectors(
      name: "Shareholder 1",
      country: "Albania",
      dob: "10-Mar-2021",
      nationality: "Albanian",
      passportNumber: "1234567890",
      passportDocument: "Director Passport",
      authorizedSignatory: "Yes",
    ),
    _MCompanyDirectors(
      name: "Shareholder 2",
      country: "Albania",
      dob: "10-Mar-2021",
      nationality: "Albanian",
      passportNumber: "1234567890",
      passportDocument: "Director Passport",
      authorizedSignatory: "No",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _generateColumns();
    _addActionsColumn();
    _generateDataCells();
  }

  void _generateColumns() {
    columns = _columnCellPairs.map((_ColumnCellPairs pair) {
      return TableCell(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 80),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey[300], width: 1),
              ),
            ),
            child: Text(
              pair.cellTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "OpenSans"),
            ),
          ),
        ),
      );
    }).toList();
  }

  void _addActionsColumn() {
    columns.add(
      TableCell(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 80),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey[300], width: 1),
              ),
            ),
            child: Text(
              "+Add",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "OpenSans"),
            ),
          ),
        ),
      ),
    );
  }

  void _generateDataCells() {
    rows = data.map((element) {
      List<TableCell> _tempTableCells = _columnCellPairs.map((_ColumnCellPairs pair) {
        Widget cellChild = Text(
          element.get(pair.modelClassKey),
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "OpenSans"),
        );

        if (pair.identifier == 'uploaded_doc') {
          cellChild = Row(
            children: [
              Text(
                element.get(pair.modelClassKey),
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "OpenSans", color: Colors.teal[300]),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.upload_file)
            ],
          );
        }
        return TableCell(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 80),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey[300], width: 1),
                ),
              ),
              child: cellChild,
            ),
          ),
        );
      }).toList();

      // Listing Display
      return TableRow(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300], width: 1),
          ),
        ),
        children: [
          ..._tempTableCells,
          TableCell(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 80, maxWidth: 300),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    TextButton(
                      onPressed: () {
                        _showEditDataDialog();
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: Colors.grey[400],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: Colors.grey[400],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: IntrinsicColumnWidth(),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              children: columns,
            ),
            ...rows,
          ],
        ),
      ),
    );
  }

  Future<void> _showEditDataDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return EditTableDataDialog(
          title: "Custom Dialog Demo",
          content: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomFormFields(
                          label: "Name",
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusTo: _emailFocus,
                          validatorFunction: (String string) {
                            log(string);
                            string = string.trim();
                            if (string == "" || string == null) {
                              return "Name is required";
                            }
                            return null;
                          },
                          onSaveFunction: (String value) {},
                        ),
                      ),
                      Expanded(
                        child: CustomFormFields(
                          label: "Name",
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusTo: _emailFocus,
                          validatorFunction: (String string) {
                            log(string);
                            string = string.trim();
                            if (string == "" || string == null) {
                              return "Name is required";
                            }
                            return null;
                          },
                          onSaveFunction: (String value) {},
                        ),
                      ),
                      Expanded(
                        child: CustomFormFields(
                          label: "Name",
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusTo: _emailFocus,
                          validatorFunction: (String string) {
                            log(string);
                            string = string.trim();
                            if (string == "" || string == null) {
                              return "Name is required";
                            }
                            return null;
                          },
                          onSaveFunction: (String value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
                if (_formKey.currentState.validate()) {}
              },
            ),
          ],
        );
      },
    );
  }
}
