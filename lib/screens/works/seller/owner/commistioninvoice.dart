import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class CommitionInvoiceScreen extends StatefulWidget {
  final MarkedInCommistion marked;
  final SellerInOwnerCommition seller;
  final Function func;
  final Function first;
  final Function second;
  CommitionInvoiceScreen(
    this.marked,
    this.seller,
    this.func,
    this.first,
    this.second,
  );
  @override
  _CommitionInvoiceScreenState createState() => _CommitionInvoiceScreenState();
}

class _CommitionInvoiceScreenState extends State<CommitionInvoiceScreen> {
  String? _invoice;
  String _org = '';
  String _email = '';
  String _address = '';
  bool _loading = true;

  @override
  void initState() {
    bool _in = widget.func(widget.seller.phone);
    _invoice = _in ? 'Done' : 'Undone';
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).onlyseller(
          widget.seller.phone,
          (String org, String email, String address) {
            _org = org;
            _email = email;
            _address = address;
            _loading = false;
            setState(() {});
          },
          (error) {
            Customized().snak(error, context);
          },
        );
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
        '${ConstantValue().commision} Detail',
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
                  Customized().marketStemp(
                    size,
                    () {},
                    widget.marked.name,
                    '${widget.marked.street}, ${widget.marked.postcode} ${widget.marked.city}',
                    '${widget.marked.day} ${DateFormat('dd/MM/yyyy').format(widget.marked.date)}',
                  ),
                  Customized().sizedheight(size.height * 0.02),
                  Customized().customdropdown(
                    size,
                    _invoice,
                    (String value) {
                      Provider.of<Back>(context, listen: false).updateinvoice(
                        widget.marked.id,
                        widget.seller.phone,
                        DateFormat('yyyyMMdd').format(widget.marked.date),
                        value == 'Done' ? true : false,
                        (String error) {
                          Customized().snak(error, context);
                        },
                      );
                      setState(() {
                        _invoice = value;
                      });
                      widget.first(
                        widget.marked.id,
                        widget.seller.phone,
                        value == 'Done' ? true : false,
                      );
                      widget.second(
                        widget.seller.phone,
                        value == 'Done' ? true : false,
                      );
                    },
                    ['Done', 'Undone'],
                    'Done / Undone',
                  ),
                  Customized().sizedheight(size.height * 0.02),
                  Customized().sellerstempcommition(
                    size,
                    () {},
                    widget.seller.name,
                    widget.seller.total.toStringAsFixed(2),
                    _invoice == 'Done' ? true : false,
                  ),
                  Customized().sizedheight(size.height * 0.02),
                  Customized().stempincommisiondetail(
                    size,
                    ConstantValue().orgno,
                    _org,
                  ),
                  Customized().stempincommisiondetail(
                    size,
                    ConstantValue().email,
                    _email,
                  ),
                  Customized().stempincommisiondetail(
                    size,
                    ConstantValue().address,
                    '$_address.',
                  ),
                  Customized().stempincommisiondetail(
                    size,
                    ConstantValue().mobile,
                    widget.seller.phone,
                  ),
                  // Customized().stempincommisiondetail(
                  //   size,
                  //   ConstantValue().contactperson,
                  //   ConstantValue().contactperson,
                  // ),
                ],
              ),
            ),
    );
  }
}
