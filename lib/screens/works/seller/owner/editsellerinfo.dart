import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class EditSellerInfo extends StatefulWidget {
  final String sphone;
  final String scompany;
  final String sorg;
  final String semail;
  final String spassword;
  final String sstreet;
  final String scity;
  final String spostcode;
  final String who;
  final Function func;
  final Function childfunc;
  EditSellerInfo(
    this.sphone,
    this.scompany,
    this.sorg,
    this.semail,
    this.spassword,
    this.sstreet,
    this.scity,
    this.spostcode,
    this.who,
    this.func,
    this.childfunc,
  );
  @override
  _EditSellerInfoState createState() => _EditSellerInfoState();
}

class _EditSellerInfoState extends State<EditSellerInfo> {
  TextEditingController _mobile = TextEditingController();
  TextEditingController _company = TextEditingController();
  TextEditingController _orgno = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  bool _lock = true;
  bool _queryrun = false;

  @override
  void initState() {
    _mobile.text = widget.sphone;
    _company.text = widget.scompany;
    _orgno.text = widget.sorg;
    _email.text = widget.semail;
    _password.text = widget.spassword;
    _street.text = widget.sstreet;
    _city.text = widget.scity;
    _pincode.text = widget.spostcode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().editinfo,
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
            Customized().disbaledtextfield(
              size,
              ConstantValue().mobile,
              _mobile,
              false,
              () {},
            ),
            Customized().sizedheight(size.height * 0.04),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().company,
              _company,
            ),
            Customized().sizedheight(size.height * 0.04),
            widget.who == ConstantValue().seller
                ? Customized().textfeildwithtitle(
                    size,
                    ConstantValue().orgno,
                    _orgno,
                  )
                : Container(),
            widget.who == ConstantValue().seller
                ? Customized().sizedheight(size.height * 0.04)
                : Container(),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().email,
              _email,
            ),
            Customized().sizedheight(size.height * 0.04),
            Customized().disbaledtextfield(
              size,
              ConstantValue().password,
              _password,
              _lock,
              () {
                if (_lock) {
                  _lock = false;
                } else {
                  _lock = true;
                }
                setState(() {});
              },
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
                    ConstantValue().update,
                    ConstantValue().greene,
                    () {
                      setState(() {
                        _queryrun = true;
                      });
                      FocusScope.of(context).unfocus();
                      if (_company.text.isEmpty ||
                          _orgno.text.isEmpty ||
                          _email.text.isEmpty ||
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
                        bool _valid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(_email.text.trim());
                        if (_valid) {
                          Provider.of<Back>(context, listen: false)
                              .updateselcust(
                            widget.sphone,
                            _company.text.trim(),
                            _orgno.text.trim(),
                            _email.text.trim(),
                            _street.text.trim(),
                            _city.text.trim(),
                            _pincode.text.trim(),
                            widget.who == ConstantValue().seller ? true : false,
                            () {
                              Customized().truediload(
                                ConstantValue().t1,
                                context,
                                size,
                              );
                              widget.func(
                                widget.sphone,
                                _company.text.trim(),
                                _orgno.text.trim(),
                                _email.text.trim(),
                                _street.text.trim(),
                                _city.text.trim(),
                                _pincode.text.trim(),
                              );
                              widget.childfunc(
                                _company.text.trim(),
                                _orgno.text.trim(),
                                _email.text.trim(),
                                _street.text.trim(),
                                _city.text.trim(),
                                _pincode.text.trim(),
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            },
                            (String error) {
                              Customized().snak(error, context);
                            },
                          );
                        } else {
                          Customized().wrongDialog(
                            ConstantValue().w14,
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
    );
  }
}
