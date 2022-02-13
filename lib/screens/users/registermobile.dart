import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../all.dart';

class RegisterMobile extends StatefulWidget {
  final String instruct;
  final String who;
  RegisterMobile(this.instruct, this.who);
  @override
  _RegisterMobileState createState() => _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {
  TextEditingController _phone = TextEditingController();
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarOfScreens(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Customized().firstbadge(
              size,
              widget.instruct == ConstantValue().register
                  ? widget.who == ConstantValue().customer
                      ? ConstantValue().regicusttitle
                      : ConstantValue().regiselttitle
                  : ConstantValue().forgotpass,
              context,
            ),
            Customized().sizedheight(size.height * 0.1),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().mobile,
              _phone,
            ),
            Customized().sizedheight(size.height * 0.15),
            _queryrun
                ? Customized().loading()
                : Customized().customButton(
                    size,
                    widget.instruct == ConstantValue().register
                        ? ConstantValue().register
                        : ConstantValue().forgot,
                    ConstantValue().greene,
                    () {
                      setState(() {
                        _queryrun = true;
                      });
                      FocusScope.of(context).unfocus();
                      if (_phone.text.isEmpty) {
                        Customized().wrongDialog(
                          ConstantValue().w6,
                          context,
                          size,
                        );
                        setState(() {
                          _queryrun = false;
                        });
                      } else {
                        Provider.of<Back>(context, listen: false).checkmobile(
                          _phone.text.trim(),
                          () {
                            if (widget.instruct == ConstantValue().register) {
                              Customized().naviagt(
                                context,
                                OTPScreen(
                                  _phone.text.trim(),
                                  ConstantValue().register,
                                  widget.who,
                                ),
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            } else {
                              Customized().wrongDialog(
                                ConstantValue().w7,
                                context,
                                size,
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            }
                          },
                          () {
                            if (widget.instruct == ConstantValue().register) {
                              Customized().wrongDialog(
                                ConstantValue().w8,
                                context,
                                size,
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            } else {
                              Customized().naviagt(
                                context,
                                OTPScreen(
                                  _phone.text.trim(),
                                  ConstantValue().forgot,
                                  widget.who,
                                ),
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            }
                          },
                          (String error) {
                            Customized().snak(error, context);
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
