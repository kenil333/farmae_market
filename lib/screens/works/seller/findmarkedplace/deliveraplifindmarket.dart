import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class DeliverAppliFindMarket extends StatefulWidget {
  final FindMarkedClass marked;
  DeliverAppliFindMarket(this.marked);
  @override
  _DeliverAppliFindMarketState createState() => _DeliverAppliFindMarketState();
}

class _DeliverAppliFindMarketState extends State<DeliverAppliFindMarket> {
  TextEditingController _applicationtext = TextEditingController();
  bool? _check = false;
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String _phone = Provider.of<Back>(context, listen: false).me!.phone;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().marked,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Customized().marketStemp(
              size,
              () {},
              widget.marked.name,
              '${widget.marked.street}, ${widget.marked.postcode} ${widget.marked.city}',
              '${widget.marked.dates[0].day} ${DateFormat('dd/MM/yyyy').format(widget.marked.dates[0].date)}',
            ),
            Customized().sizedheight(size.height * 0.04),
            Customized().disabledstemp(
              size,
              ConstantValue().admintext,
              widget.marked.admintext,
            ),
            Customized().sizedheight(size.height * 0.04),
            Customized().textfeildwithtitle(
              size,
              ConstantValue().applicatoiontext,
              _applicationtext,
            ),
            Customized().sizedheight(size.height * 0.02),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              width: double.infinity,
              child: Row(
                children: [
                  Checkbox(
                    value: _check,
                    onChanged: (value) {
                      setState(() {
                        _check = value;
                      });
                    },
                  ),
                  Customized().sizedwidth(size.width * 0.02),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ConstantValue().approvesellerterm,
                          style: TextStyle(
                            fontSize: size.width * 0.045,
                            color: ConstantValue().text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            '"${widget.marked.name}"',
                            style: TextStyle(
                              fontSize: size.width * 0.045,
                              color: ConstantValue().greene,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Customized().sizedheight(size.height * 0.05),
            _queryrun
                ? Customized().loading()
                : Customized().customButton(
                    size,
                    ConstantValue().deliverapplication,
                    ConstantValue().greene,
                    () {
                      setState(() {
                        _queryrun = true;
                      });
                      FocusScope.of(context).unfocus();
                      if (_applicationtext.text.isEmpty) {
                        Customized().wrongDialog(
                          ConstantValue().w18,
                          context,
                          size,
                        );
                        setState(() {
                          _queryrun = false;
                        });
                      } else {
                        if (_check == false) {
                          Customized().wrongDialog(
                            ConstantValue().w19,
                            context,
                            size,
                          );
                          setState(() {
                            _queryrun = false;
                          });
                        } else {
                          if (widget.marked.free) {
                            Provider.of<Back>(context, listen: false)
                                .deliverapplifree(
                              widget.marked.id,
                              DateFormat('yyyyMMdd')
                                  .format(widget.marked.dates[0].date),
                              widget.marked.dates[0].sels,
                              _phone,
                              _applicationtext.text,
                              () {
                                setState(() {
                                  _queryrun = false;
                                });
                                Customized()
                                    .truediload(
                                  ConstantValue().t3,
                                  context,
                                  size,
                                )
                                    .then((_) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                });
                              },
                              () {
                                Customized().wrongDialog(
                                  ConstantValue().w4,
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
                        }
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
