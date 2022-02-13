import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class JoinFreeorApprove extends StatefulWidget {
  final String id;
  JoinFreeorApprove(this.id);
  @override
  _JoinFreeorApproveState createState() => _JoinFreeorApproveState();
}

class _JoinFreeorApproveState extends State<JoinFreeorApprove> {
  bool _loading = true;
  bool _free = false;
  TextEditingController _admintext = TextEditingController();
  bool _queryrun = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      Provider.of<Back>(context, listen: false).joinfreescreenfetch(
        widget.id,
        (bool tof, String tearm) {
          _free = tof;
          _admintext.text = tearm;
          _loading = false;
          setState(() {});
        },
        (String error) {
          Customized().snak(error, context);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().joinfreeapprove,
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
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.02,
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Free to Join : ',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: ConstantValue().text,
                          ),
                        ),
                        Customized().sizedwidth(size.width * 0.05),
                        Checkbox(
                          value: _free,
                          onChanged: (bool? value) {
                            if (_free) {
                              _free = false;
                            } else {
                              _free = true;
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.0,
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Need Approvement : ',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: ConstantValue().text,
                          ),
                        ),
                        Customized().sizedwidth(size.width * 0.05),
                        Checkbox(
                          value: !_free,
                          onChanged: (bool? value) {
                            if (_free) {
                              _free = false;
                            } else {
                              _free = true;
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Customized().textfeildwithtitle(
                    size,
                    ConstantValue().admintext,
                    _admintext,
                  ),
                  Customized().sizedheight(size.height * 0.1),
                  _queryrun
                      ? Customized().loading()
                      : Customized().customButton(
                          size,
                          'Done',
                          ConstantValue().greene,
                          () {
                            setState(() {
                              _queryrun = true;
                            });
                            FocusScope.of(context).unfocus();
                            if (_admintext.text.isEmpty) {
                              Customized().wrongDialog(
                                '${ConstantValue().w5} ${ConstantValue().admintext}',
                                context,
                                size,
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            } else {
                              Provider.of<Back>(context, listen: false)
                                  .setjoinfreescreen(
                                widget.id,
                                _free,
                                _admintext.text,
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
                                  Customized().snak(error, context);
                                },
                              );
                            }
                          },
                        ),
                  Customized().sizedheight(size.height * 0.06),
                ],
              ),
            ),
    );
  }
}
