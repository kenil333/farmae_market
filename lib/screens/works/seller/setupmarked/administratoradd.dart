import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class AdministratorAdd extends StatefulWidget {
  final String id;
  AdministratorAdd(this.id);

  @override
  _AdministratorAddState createState() => _AdministratorAddState();
}

class _AdministratorAddState extends State<AdministratorAdd> {
  TextEditingController _mobile = TextEditingController();
  TextEditingController _company = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  //String? _position;
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        '${ConstantValue().add} ${ConstantValue().administrator}',
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
              ConstantValue().mobile,
              _mobile,
            ),
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
              ConstantValue().password,
              _password,
            ),
            // Customized().sizedheight(size.height * 0.04),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Customized().onlylable(
            //       size,
            //       ConstantValue().position,
            //     ),
            //     Customized().customdropdown(
            //       size,
            //       _position,
            //       (String? value) {
            //         setState(() {
            //           _position = value;
            //         });
            //       },
            //       <String>[
            //         'Super Admin',
            //         'Admin',
            //         'Overview',
            //       ],
            //       ConstantValue().position,
            //     ),
            //   ],
            // ),
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
                      if (_mobile.text.isEmpty ||
                              _company.text.isEmpty ||
                              _email.text.isEmpty ||
                              _password.text.isEmpty
                          //||_position == null
                          ) {
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
                          Provider.of<Back>(context, listen: false).addadmin(
                            widget.id,
                            _mobile.text.trim(),
                            _company.text.trim(),
                            _email.text.trim(),
                            _password.text.trim(),
                            //_position ?? 'Who',
                            () {
                              setState(() {
                                _queryrun = false;
                              });
                              Navigator.of(context).pop();
                            },
                            () {
                              Customized().wrongDialog(
                                ConstantValue().w8,
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
                      }
                    },
                  ),
            Customized().sizedheight(size.height * 0.08),
          ],
        ),
      ),
    );
  }
}
