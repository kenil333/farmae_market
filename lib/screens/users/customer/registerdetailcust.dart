import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../all.dart';

class RegisterDetailCust extends StatefulWidget {
  final String phone;
  RegisterDetailCust(this.phone);
  @override
  _RegisterDetailCustState createState() => _RegisterDetailCustState();
}

class _RegisterDetailCustState extends State<RegisterDetailCust> {
  TextEditingController _company = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: ConstantValue().background,
        appBar: Customized().appBarOfScreens(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Customized().onlytitle(
                size,
                ConstantValue().appname,
              ),
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
                ConstantValue().password,
                _password,
              ),
              Customized().sizedheight(size.height * 0.04),
              Customized().textfeildwithtitle(
                size,
                ConstantValue().confirmpassword,
                _confirmpassword,
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
              Customized().sizedheight(size.height * 0.08),
              _queryrun
                  ? Customized().loading()
                  : Customized().customButton(
                      size,
                      ConstantValue().register,
                      ConstantValue().greene,
                      () {
                        setState(() {
                          _queryrun = true;
                        });
                        FocusScope.of(context).unfocus();
                        if (_company.text.isEmpty ||
                            _email.text.isEmpty ||
                            _password.text.isEmpty ||
                            _confirmpassword.text.isEmpty ||
                            _street.text.isEmpty ||
                            _city.text.isEmpty ||
                            _pincode.text.isEmpty) {
                          Customized().wrongDialog(
                            ConstantValue().w1,
                            context,
                            size,
                          );
                          setState(() {
                            _queryrun = false;
                          });
                        } else {
                          if (_password.text.trim() ==
                              _confirmpassword.text.trim()) {
                            bool _valid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(_email.text.trim());
                            if (!_valid) {
                              Customized().wrongDialog(
                                ConstantValue().w14,
                                context,
                                size,
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            } else {
                              Provider.of<Back>(context, listen: false)
                                  .custregister(
                                widget.phone,
                                _company.text.trim(),
                                _email.text.trim(),
                                _password.text.trim(),
                                _street.text.trim(),
                                _city.text.trim(),
                                _pincode.text.trim(),
                                () {
                                  Navigator.of(context).popUntil(
                                    ModalRoute.withName('/LoginForCustomer'),
                                  );
                                  setState(() {
                                    _queryrun = false;
                                  });
                                },
                                () {
                                  Customized().wrongDialog(
                                    ConstantValue().w10,
                                    context,
                                    size,
                                  );
                                  setState(() {
                                    _queryrun = false;
                                  });
                                },
                                (error) {
                                  Customized().snak(error, context);
                                },
                              );
                            }
                          } else {
                            Customized().wrongDialog(
                              ConstantValue().w9,
                              context,
                              size,
                            );
                            setState(() {
                              _queryrun = false;
                            });
                          }
                        }
                      },
                    ),
              Customized().sizedheight(size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
