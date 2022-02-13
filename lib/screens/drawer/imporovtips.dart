import 'package:flutter/material.dart';

import './../../all.dart';

class ImproveTipsScreen extends StatefulWidget {
  @override
  _ImproveTipsScreenState createState() => _ImproveTipsScreenState();
}

class _ImproveTipsScreenState extends State<ImproveTipsScreen> {
  TextEditingController _tips = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().tipsforapp,
        () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().sizedheight(size.height * 0.1),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().tips,
              _tips,
            ),
            Customized().sizedheight(size.height * 0.1),
            Customized().customButton(
              size,
              ConstantValue().send,
              ConstantValue().greene,
              () {},
            ),
            Customized().sizedheight(size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
