import 'package:flutter/material.dart';

import './../../all.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _query = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().contactus,
        () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().sizedheight(size.height * 0.04),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().name,
              _name,
            ),
            Customized().sizedheight(size.height * 0.04),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().email,
              _email,
            ),
            Customized().sizedheight(size.height * 0.04),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().query,
              _query,
            ),
            Customized().sizedheight(size.height * 0.08),
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
