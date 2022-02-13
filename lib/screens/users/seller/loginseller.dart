import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../../all.dart';

class LoginSeller extends StatefulWidget {
  @override
  _LoginSellerState createState() => _LoginSellerState();
}

class _LoginSellerState extends State<LoginSeller> {
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarOfScreens(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().sizedheight(size.height * 0.05),
            Customized().imagecenter(size.width * 0.3),
            Customized().sizedheight(size.height * 0.05),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().mobile,
              _mobile,
            ),
            Customized().sizedheight(size.height * 0.05),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().password,
              _password,
            ),
            Container(
              padding: EdgeInsets.only(
                right: size.width * 0.05,
                top: size.height * 0.01,
              ),
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Customized().naviagt(
                    context,
                    RegisterMobile(
                      ConstantValue().forgot,
                      ConstantValue().seller,
                    ),
                  );
                },
                child: Text(
                  '${ConstantValue().forgotpass} !',
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ),
            Customized().sizedheight(size.height * 0.05),
            _queryrun
                ? Customized().loading()
                : Customized().customButton(
                    size,
                    ConstantValue().login,
                    ConstantValue().greene,
                    () {
                      setState(() {
                        _queryrun = true;
                      });
                      FocusScope.of(context).unfocus();
                      if (_mobile.text.isEmpty || _password.text.isEmpty) {
                        Customized().wrongDialog(
                          ConstantValue().w1,
                          context,
                          size,
                        );
                        setState(() {
                          _queryrun = false;
                        });
                      } else {
                        Provider.of<Back>(context, listen: false).sellerlogin(
                          _mobile.text.trim(),
                          _password.text.trim(),
                          () {
                            Navigator.of(context).popUntil(
                              ModalRoute.withName('/UserType'),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                settings: RouteSettings(
                                  name: '/SellerDashboard',
                                ),
                                builder: (context) => SellerDashboard(),
                              ),
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
                          () {
                            Customized().wrongDialog(
                              ConstantValue().w7,
                              context,
                              size,
                            );
                            setState(() {
                              _queryrun = false;
                            });
                          },
                          () {
                            Customized().wrongDialog(
                              ConstantValue().w11,
                              context,
                              size,
                            );
                            setState(() {
                              _queryrun = false;
                            });
                          },
                          () {
                            Customized().wrongDialog(
                              ConstantValue().w12,
                              context,
                              size,
                            );
                            setState(() {
                              _queryrun = false;
                            });
                          },
                          () {
                            Customized().wrongDialog(
                              ConstantValue().w13s,
                              context,
                              size,
                            );
                            setState(() {
                              _queryrun = false;
                            });
                          },
                          (String error) {
                            Customized().snak(error, context);
                          },
                        );
                      }
                    },
                  ),
            Customized().sizedheight(size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
