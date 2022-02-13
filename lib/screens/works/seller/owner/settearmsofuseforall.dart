import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class AllTearmsofUseset extends StatefulWidget {
  final String title;
  AllTearmsofUseset(this.title);
  @override
  _AllTearmsofUsesetState createState() => _AllTearmsofUsesetState();
}

class _AllTearmsofUsesetState extends State<AllTearmsofUseset> {
  TextEditingController _tearms = TextEditingController();
  bool _loading = true;
  bool _queryrun = false;

  String gettearm() {
    String _tearmstring = '';
    if (widget.title == '${ConstantValue().tearmsofuse} App') {
      _tearmstring = 'TearmOfApp';
    }
    if (widget.title ==
        '${ConstantValue().tearmsofuse} ${ConstantValue().seller}') {
      _tearmstring = 'TearmOfSeller';
    }
    if (widget.title ==
        '${ConstantValue().tearmsofuse} ${ConstantValue().customer}') {
      _tearmstring = 'TearmOfCustomer';
    }
    return _tearmstring;
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      Provider.of<Back>(context, listen: false).fetchapptearm(
        gettearm(),
        (String tearm) {
          setState(() {
            _tearms.text = tearm;
            _loading = false;
          });
        },
        (String error) {
          Customized().snak(
            error,
            context,
          );
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        widget.title,
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
                    widget.title,
                    _tearms,
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
                            if (_tearms.text.isEmpty) {
                              Customized().wrongDialog(
                                '${ConstantValue().w5} ${widget.title}',
                                context,
                                size,
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            } else {
                              Provider.of<Back>(context, listen: false)
                                  .apptearms(gettearm(), _tearms.text, () {
                                setState(() {
                                  _queryrun = false;
                                });
                              }, (error) {
                                Customized().snak(error, context);
                              });
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
