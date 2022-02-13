import 'package:flutter/material.dart';

import './../../all.dart';

class ContactIfo extends StatefulWidget {
  @override
  _ContactIfoState createState() => _ContactIfoState();
}

class _ContactIfoState extends State<ContactIfo> {
  TextEditingController _company = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _pincode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().cotactinfo,
        () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().sizedheight(size.height * 0.03),
            Customized().sizedheight(size.height * 0.04),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().company,
              _company,
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
              ConstantValue().street,
              _street,
            ),
            Customized().sizedheight(size.height * 0.04),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.44,
                    child: Customized().dynamictextfeild(
                      size,
                      ConstantValue().city,
                      _city,
                    ),
                  ),
                  Container(
                    width: size.width * 0.44,
                    child: Customized().dynamictextfeild(
                      size,
                      ConstantValue().postcode,
                      _pincode,
                    ),
                  ),
                ],
              ),
            ),
            Customized().sizedheight(size.height * 0.04),
            Customized().disabledstemp(
              size,
              ConstantValue().mobile,
              '12345678',
            ),
            Customized().sizedheight(size.height * 0.08),
            Customized().customButton(
              size,
              ConstantValue().update,
              ConstantValue().greene,
              () {},
            ),
            Customized().sizedheight(size.height * 0.08),
          ],
        ),
      ),
    );
  }
}
