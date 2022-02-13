import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class Administratorupdate extends StatefulWidget {
  final AdminSetup admin;
  Administratorupdate(this.admin);

  @override
  _AdministratorupdateState createState() => _AdministratorupdateState();
}

class _AdministratorupdateState extends State<Administratorupdate> {
  TextEditingController _mobile = TextEditingController();
  TextEditingController _company = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  //String? _position;
  bool _lock = true;
  bool _queryrun = false;

  @override
  void initState() {
    _mobile.text = widget.admin.id;
    _company.text = widget.admin.name;
    _email.text = widget.admin.email;
    _password.text = widget.admin.password;
    //_position = widget.admin.position;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        '${ConstantValue().update} ${ConstantValue().administrator}',
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
                    ConstantValue().update,
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
                          //|| _position == null
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
                        Provider.of<Back>(context, listen: false).updateadmin(
                          _mobile.text.trim(),
                          _company.text.trim(),
                          _email.text.trim(),
                          _password.text.trim(),
                          //_position ?? 'Who',
                          () {
                            setState(() {
                              _queryrun = false;
                            });
                            Customized().truediload(
                              ConstantValue().t1,
                              context,
                              size,
                            );
                          },
                          (error) {
                            Customized().snak(error, context);
                          },
                        );
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
