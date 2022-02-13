import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../all.dart';

class MakeInvoiceSel extends StatefulWidget {
  final InvoiceMarked marked;
  MakeInvoiceSel(this.marked);
  @override
  _MakeInvoiceSelState createState() => _MakeInvoiceSelState();
}

class _MakeInvoiceSelState extends State<MakeInvoiceSel> {
  TextEditingController _number = TextEditingController();
  bool _mail = false;
  bool _device = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().makeinvoice,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/SellerDashboard'),
          );
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Customized().marketStemp(
                    size,
                    () {
                      // Customized().naviagt(
                      //   context,
                      //   MarketDetailScreen(),
                      // );
                    },
                    widget.marked.name,
                    widget.marked.address,
                    '${widget.marked.day} ${DateFormat('dd/MM/yyyy').format(widget.marked.date)}',
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.02,
                    ),
                    child: Text(
                      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nLorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nLorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nLorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nLorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                      style: TextStyle(
                        color: ConstantValue().text,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: size.height * 0.03),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: ConstantValue().text,
                  width: 1.5,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.035,
                          ),
                          width: double.infinity,
                          child: Customized().dynamictextfeild(
                            size,
                            ConstantValue().fakturano,
                            _number,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: size.width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _mail,
                                  onChanged: (value) {
                                    if (value == true)
                                      setState(
                                        () {
                                          _mail = true;
                                          _device = false;
                                        },
                                      );
                                  },
                                ),
                                Text(
                                  ConstantValue().lastnedpdf,
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _device,
                                  onChanged: (value) {
                                    if (value == true)
                                      setState(
                                        () {
                                          _device = true;
                                          _mail = false;
                                        },
                                      );
                                  },
                                ),
                                Text(
                                  ConstantValue().sendpamail,
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Customized().sizedheight(size.height * 0.04),
                Customized().customButton(
                  size,
                  ConstantValue().butinvoicescreen,
                  ConstantValue().greene,
                  () {},
                ),
                Customized().sizedheight(size.height * 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
