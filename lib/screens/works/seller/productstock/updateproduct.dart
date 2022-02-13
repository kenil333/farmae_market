import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../all.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product prod;
  UpdateProductScreen(this.prod);
  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _available = TextEditingController();
  TextEditingController _qtyvalue = TextEditingController();
  TextEditingController _id = TextEditingController();
  TextEditingController _description = TextEditingController();
  String? _tax = '15';
  String? _unit = 'Stk';
  String? _temzone;
  String? _category;
  DateTime? _expary;
  List<String> _categorylist = [];
  bool _loading = true;
  File? _image;
  bool _queryrun = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).fetchcategory(
          'Category',
          'Prod',
          (List<String> value) {
            _categorylist = value;
            _name.text = widget.prod.name;
            _price.text = widget.prod.price.toStringAsFixed(2);
            _available.text = widget.prod.available.toString();
            _tax = widget.prod.tax.toString();
            _qtyvalue.text = widget.prod.qty.toString();
            _unit = widget.prod.unit;
            _id.text = widget.prod.prodid;
            _temzone = widget.prod.tempzone;
            _category = widget.prod.category;
            _description.text = widget.prod.description;
            _expary = widget.prod.expiry;
            _loading = false;
            setState(() {});
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      //endDrawer: EndAppDrawer(),
      appBar: Customized().appBarforlimit(
        size,
        ConstantValue().updateproduct,
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
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.02,
                        ),
                        width: double.infinity,
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                          color: ConstantValue().white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              color: ConstantValue().text.withOpacity(0.23),
                            ),
                          ],
                        ),
                        child: _image == null
                            ? CachedNetworkImage(
                                imageUrl: widget.prod.imageurl,
                                placeholder: (context, url) => Container(
                                  color: Colors.black12,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.contain,
                              )
                            : Image.file(
                                _image!,
                                fit: BoxFit.contain,
                              ),
                      ),
                      Positioned(
                        top: size.height * 0.005,
                        right: size.width * 0.01,
                        child: Container(
                          child: IconButton(
                            onPressed: () {
                              Provider.of<Back>(context, listen: false)
                                  .pickimage(
                                (XFile? pick) {
                                  if (pick != null) {
                                    _image = File(pick.path);
                                  } else {
                                    Customized().wrongDialog(
                                      ConstantValue().w17,
                                      context,
                                      size,
                                    );
                                  }
                                  setState(() {});
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: ConstantValue().text,
                              size: size.width * 0.075,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Customized().textfeildwithtitle(
                    size,
                    ConstantValue().prodname,
                    _name,
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Customized().textfeildwithtitle(
                    size,
                    ConstantValue().price,
                    _price,
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Customized().textfeildwithtitle(
                    size,
                    ConstantValue().available,
                    _available,
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Customized().onlylable(
                        size,
                        ConstantValue().tax,
                      ),
                      Customized().customdropdown(
                        size,
                        _tax,
                        (String? value) {
                          setState(() {
                            _tax = value;
                          });
                        },
                        <String>[
                          '15',
                          '25',
                        ],
                        ConstantValue().tax,
                      ),
                    ],
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: size.width * 0.04),
                          width: size.width * 0.45,
                          child: Customized().dynamictextfeild(
                            size,
                            ConstantValue().verdi,
                            _qtyvalue,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Customized().onlylable(
                                  size,
                                  ConstantValue().unit,
                                ),
                                Customized().customdropdown(
                                  size,
                                  _unit,
                                  (String? value) {
                                    setState(() {
                                      _unit = value;
                                    });
                                  },
                                  <String>[
                                    'Gram',
                                    'Kg',
                                    'Stk',
                                    'Liters',
                                  ],
                                  ConstantValue().unit,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Customized().disbaledtextfield(
                    size,
                    ConstantValue().prodid,
                    _id,
                    false,
                    () {},
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Customized().onlylable(
                        size,
                        ConstantValue().tempzone,
                      ),
                      Customized().customdropdown(
                        size,
                        _temzone,
                        (String? value) {
                          setState(() {
                            _temzone = value;
                          });
                        },
                        <String>[
                          'Dry',
                          'Cold',
                        ],
                        ConstantValue().tempzone,
                      ),
                    ],
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Customized().onlylable(
                        size,
                        ConstantValue().category,
                      ),
                      Customized().customdropdown(
                        size,
                        _category,
                        (String? value) {
                          setState(() {
                            _category = value;
                          });
                        },
                        _categorylist,
                        ConstantValue().category,
                      ),
                    ],
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Customized().textfeildwithtitle(
                    size,
                    ConstantValue().description,
                    _description,
                  ),
                  Customized().sizedheight(size.height * 0.04),
                  Customized().choosedate(
                    size,
                    ConstantValue().expirydate,
                    _expary == null
                        ? ConstantValue().expirydate
                        : DateFormat('dd.MM.yyyy').format(_expary!),
                    () {
                      Customized().datepicker(
                        context,
                        (DateTime? value) {
                          setState(() {
                            _expary = value;
                          });
                        },
                        'Reg',
                      );
                    },
                  ),
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
                            if (_name.text.isEmpty ||
                                _price.text.isEmpty ||
                                _available.text.isEmpty ||
                                _tax == null ||
                                _qtyvalue.text.isEmpty ||
                                _unit == null ||
                                _temzone == null ||
                                _category == null ||
                                _description.text.isEmpty ||
                                _expary == null) {
                              Customized().wrongDialog(
                                ConstantValue().w1,
                                context,
                                size,
                              );
                              setState(() {
                                _queryrun = false;
                              });
                            } else {
                              Provider.of<Back>(context, listen: false)
                                  .updateproduct(
                                widget.prod.prodid,
                                widget.prod.imageurl,
                                _image,
                                _name.text.trim(),
                                _price.text.trim(),
                                _available.text.trim(),
                                _tax ?? 'Tax',
                                _qtyvalue.text.trim(),
                                _unit ?? 'Unit',
                                _temzone ?? 'Temp-Zone',
                                _category ?? 'Category',
                                _description.text.trim(),
                                DateFormat('yyyyMMdd')
                                    .format(_expary ?? DateTime.now()),
                                () {
                                  Customized().truediload(
                                    ConstantValue().t1,
                                    context,
                                    size,
                                  );
                                  setState(() {
                                    _queryrun = false;
                                  });
                                },
                                () {
                                  Customized().wrongDialog(
                                    ConstantValue().w10,
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
                          },
                        ),
                  Customized().sizedheight(size.height * 0.1),
                ],
              ),
            ),
    );
  }
}
