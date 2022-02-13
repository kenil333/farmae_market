import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class ConfirmOrder extends StatefulWidget {
  final List<CartProd> product;
  final OnlyOneMarkedCust marked;
  final SellerCust seller;
  ConfirmOrder(this.product, this.marked, this.seller);

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  double _subtot = 0;
  double _tax = 0;
  bool _loading = true;
  List<OrderProd> _iteamlist = [];
  bool _queryrun = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        widget.product.forEach(
          (e) {
            CustProd _prod =
                Provider.of<Back>(context, listen: false).singleprod(e.id);
            _iteamlist.add(
              OrderProd(
                id: _prod.id,
                name: _prod.name,
                image: _prod.image,
                price: _prod.price,
                available: _prod.available,
                total: e.price,
                qty: _prod.qty,
                unit: _prod.unit,
                tax: _prod.tax,
                taxprice: (e.price * (_prod.tax / 100)),
                count: e.count,
              ),
            );
          },
        );
        double subtot = 0;
        double tax = 0;
        _iteamlist.forEach(
          (es) {
            subtot += es.total;
            tax += es.taxprice;
          },
        );
        _subtot = subtot;
        _tax = tax;
        _loading = false;
        setState(() {});
      },
    );
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
        ConstantValue().confirmorder,
        () {
          Navigator.of(context).popUntil(
            ModalRoute.withName('/CustomerDashboard'),
          );
        },
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Hente Selv pa :',
                              style: TextStyle(
                                color: ConstantValue().text,
                                fontSize: size.width * 0.055,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                            ),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Text(
                                  widget.marked.name,
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.06,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Customized().sizedheight(size.height * 0.006),
                                Text(
                                  '${widget.marked.street}, ${widget.marked.postcode} ${widget.marked.city}',
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.05,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Customized().sizedheight(size.height * 0.01),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.01,
                                        horizontal: size.width * 0.05,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: ConstantValue().text,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        '${widget.marked.day} ${DateFormat('dd/MM/yyyy').format(widget.marked.date)}',
                                        style: TextStyle(
                                          color: ConstantValue().text,
                                          fontSize: size.width * 0.05,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Customized().sizedheight(size.height * 0.015),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: _iteamlist.length,
                            itemBuilder: (context, i) =>
                                Customized().confirmordprod(
                              size,
                              _iteamlist[i],
                            ),
                          ),
                          Customized().sizedheight(size.height * 0.025),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  width: double.infinity,
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
                      Customized().pricetag(
                        size,
                        'Sub Total',
                        _subtot.toStringAsFixed(2),
                      ),
                      Customized().pricetag(
                        size,
                        'mva',
                        _tax.toStringAsFixed(2),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: size.height * 0.005),
                              width: size.width * 0.7,
                              height: 1.5,
                              color: ConstantValue().text,
                            ),
                          ],
                        ),
                      ),
                      Customized().pricetag(
                        size,
                        'Total',
                        (_subtot + _tax).toStringAsFixed(2),
                      ),
                      Customized().sizedheight(size.height * 0.025),
                      _queryrun
                          ? Customized().loading()
                          : Customized().customButton(
                              size,
                              ConstantValue().order,
                              ConstantValue().greene,
                              () {
                                setState(() {
                                  _queryrun = true;
                                });
                                Provider.of<Back>(context, listen: false).order(
                                  (_subtot + _tax).toStringAsFixed(2),
                                  _subtot.toStringAsFixed(2),
                                  widget.marked,
                                  widget.seller,
                                  _iteamlist,
                                  (int count) {
                                    setState(() {
                                      _queryrun = false;
                                    });
                                    Customized().naviagt(
                                      context,
                                      OrderConfirmationPrompt(
                                        widget.seller,
                                        count.toString(),
                                      ),
                                    );
                                  },
                                  (String print) {
                                    Customized().wrongdouble(
                                      print,
                                      'Tilgjengelig !',
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
                              },
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
