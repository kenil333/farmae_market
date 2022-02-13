import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class AddMarked extends StatefulWidget {
  @override
  _AddMarkedState createState() => _AddMarkedState();
}

class _AddMarkedState extends State<AddMarked> {
  TextEditingController _name = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _country = TextEditingController();
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().addmarked,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
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
            Customized().textfeildwithtitle(
              size,
              ConstantValue().country,
              _country,
            ),
            Customized().sizedheight(size.height * 0.08),
            _queryrun
                ? Customized().loading()
                : Customized().customButton(
                    size,
                    ConstantValue().add,
                    ConstantValue().greene,
                    () {
                      setState(() {
                        _queryrun = true;
                      });
                      FocusScope.of(context).unfocus();
                      if (_name.text.isEmpty ||
                          _street.text.isEmpty ||
                          _city.text.isEmpty ||
                          _pincode.text.isEmpty ||
                          _country.text.isEmpty) {
                        Customized().wrongDialog(
                          ConstantValue().w1,
                          context,
                          size,
                        );
                        setState(() {
                          _queryrun = false;
                        });
                      } else {
                        Provider.of<Back>(context, listen: false).addMarked(
                          _name.text.trim(),
                          _street.text.trim(),
                          _city.text.trim(),
                          _pincode.text.trim(),
                          _country.text.trim(),
                          () {
                            setState(() {
                              _queryrun = false;
                            });
                            Navigator.of(context).pop();
                          },
                          () {
                            Customized().wrongDialog(
                              ConstantValue().w21,
                              context,
                              size,
                            );
                            setState(() {
                              _queryrun = false;
                            });
                          },
                          (String error) {
                            Customized().snak(
                              error,
                              context,
                            );
                          },
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
