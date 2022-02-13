import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class SetSaleofTearms extends StatefulWidget {
  final String id;
  SetSaleofTearms(this.id);
  @override
  _SetSaleofTearmsState createState() => _SetSaleofTearmsState();
}

class _SetSaleofTearmsState extends State<SetSaleofTearms> {
  TextEditingController _tearm = TextEditingController();
  bool _loading = true;
  bool _queryrun = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).fetchtearms(
          widget.id,
          'SaleOfTearm',
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
        ConstantValue().saletearms,
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
                    ConstantValue().saletearms,
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
                                '${ConstantValue().w5} ${ConstantValue().saletearms}',
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
                                'SaleOfTearm',
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
