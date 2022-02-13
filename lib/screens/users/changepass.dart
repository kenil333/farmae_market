import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../all.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String phone;
  final String who;
  ChangePasswordScreen(this.phone, this.who);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  bool _queryruun = false;

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
                ConstantValue().changepass,
              ),
              Customized().sizedheight(size.height * 0.08),
              Customized().textfeildwithtitle(
                size,
                ConstantValue().password,
                _password,
              ),
              Customized().sizedheight(size.height * 0.06),
              Customized().textfeildwithtitle(
                size,
                ConstantValue().confirmpassword,
                _confirmpassword,
              ),
              Customized().sizedheight(size.height * 0.1),
              _queryruun
                  ? Customized().loading()
                  : Customized().customButton(
                      size,
                      ConstantValue().consfirm,
                      ConstantValue().greene,
                      () {
                        setState(() {
                          _queryruun = true;
                        });
                        FocusScope.of(context).unfocus();
                        if (_password.text.isEmpty ||
                            _confirmpassword.text.isEmpty) {
                          Customized().wrongDialog(
                            ConstantValue().w1,
                            context,
                            size,
                          );
                          setState(() {
                            _queryruun = false;
                          });
                        } else {
                          if (_password.text.trim() !=
                              _confirmpassword.text.trim()) {
                            Customized().wrongDialog(
                              ConstantValue().w9,
                              context,
                              size,
                            );
                            setState(() {
                              _queryruun = false;
                            });
                          } else {
                            Provider.of<Back>(context, listen: false)
                                .changepass(
                              widget.phone,
                              _password.text.trim(),
                              () {
                                if (widget.who == ConstantValue().seller) {
                                  Navigator.of(context).popUntil(
                                    ModalRoute.withName('/SellerButton'),
                                  );
                                  Customized().naviagt(
                                    context,
                                    LoginSeller(),
                                  );
                                } else {
                                  Navigator.of(context).popUntil(
                                    ModalRoute.withName('/LoginForCustomer'),
                                  );
                                }
                                setState(() {
                                  _queryruun = false;
                                });
                              },
                              () {
                                Customized().wrongDialog(
                                  ConstantValue().w10,
                                  context,
                                  size,
                                );
                                setState(() {
                                  _queryruun = false;
                                });
                              },
                              (String error) {
                                Customized().snak(error, context);
                              },
                            );
                          }
                        }
                      },
                    ),
              Customized().sizedheight(size.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
