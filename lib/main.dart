import 'package:flutter/material.dart';
import 'package:kratos_flutter/constants/kratos_svg.dart';
import 'package:kratos_flutter/screens/kyc/components/kratos_frame.dart';
import 'package:kratos_flutter/screens/kyc/interfaces/kratos_frame_card_tabs.dart';
import 'package:kratos_flutter/screens/kyc/ui/ui_kyc_share_holder_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        primarySwatch: Colors.blue,
      ),
      home: KratosFrame(
        steps: [
          IKycStep(
            title1: "Company",
            title2: "Details",
            svg: kSvgKycCompanyDetails,
            widget: UIKycShareholderDetails(),
          ),
          IKycStep(
            title1: "Shareholder",
            title2: "Details",
            svg: kSvgKycShareholderDetails,
            widget: Container(
              width: 100,
              height: 100,
              color: Colors.amber,
            ),
          ),
          IKycStep(
            title1: "Company",
            title2: "Document",
            svg: kSvgKycCompanyDocument,
            widget: Container(
              color: Colors.blue,
              width: 100,
              height: 100,
            ),
          ),
          IKycStep(
            title1: "Declaration",
            svg: kSvgKycDeclaration,
            widget: Container(
              color: Colors.green,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
