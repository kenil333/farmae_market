import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class SetApplicationText extends StatefulWidget {
  final String id;
  SetApplicationText(this.id);
  @override
  _SetApplicationTextState createState() => _SetApplicationTextState();
}

class _SetApplicationTextState extends State<SetApplicationText> {
  TextEditingController _tearm = TextEditingController();
  bool _loading = true;
  bool _queryrun = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).fetchtearms(
          widget.id,
          'ApplicationText',
          (String value) {
            setState(() {
              _tearm.text = value;
              _loading = false;
            });
          },
          () {
            setState(() {
              _loading = false;
            });
          },
          (String error) {
            Customized().snak(error, context);
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().applicatoiontext,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Customized().sizedheight(size.height * 0.1),
                  Customized().textfeildwithtitle(
                    size,
                    ConstantValue().applicatoiontext,
                    _tearm,
                  ),
                  Customized().sizedheight(size.height * 0.1),
                  _queryrun
                      ? Customized().loading()
                      : Customized().customButton(
                          size,
                          ConstantValue().set,
                          ConstantValue().greene,
                          () {
                            setState(() {
                              _queryrun = true;
                            });
                            FocusScope.of(context).unfocus();
                            if (_tearm.text.isEmpty) {
                              Customized().wrongDialog(
                                '${ConstantValue().w5} ${ConstantValue().applicatoiontext}',
                                context,
                                size,
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            } else {
                              Provider.of<Back>(context, listen: false)
                                  .settearms(
                                widget.id,
                                'ApplicationText',
                                _tearm.text,
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
                  Customized().sizedheight(size.height * 0.1),
                ],
              ),
            ),
    );
  }
}
