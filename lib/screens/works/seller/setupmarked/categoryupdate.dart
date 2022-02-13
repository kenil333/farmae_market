import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../all.dart';

class CategoryUpdate extends StatefulWidget {
  final Category category;
  CategoryUpdate(this.category);
  @override
  _CategoryUpdateState createState() => _CategoryUpdateState();
}

class _CategoryUpdateState extends State<CategoryUpdate> {
  TextEditingController _name = TextEditingController();
  String? _parent;
  List<String> _category = [];
  bool _loading = true;
  bool _queryrun = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then(
      (_) {
        Provider.of<Back>(context, listen: false).fetchcategory(
          widget.category.name,
          'Category',
          (List<String> value) {
            setState(() {
              _category = value;
              _loading = false;
              _name.text = widget.category.name;
              _parent = widget.category.parent;
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
        '${ConstantValue().update} ${ConstantValue().category}',
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
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Customized().sizedheight(size.height * 0.04),
                        Customized().textfeildwithtitle(
                          size,
                          ConstantValue().name,
                          _name,
                        ),
                        Customized().sizedheight(size.height * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Customized().onlylable(
                              size,
                              'Parent Category',
                            ),
                            Customized().customdropdown(
                              size,
                              _parent,
                              (String? value) {
                                setState(() {
                                  _parent = value;
                                });
                              },
                              _category,
                              'Parent Category',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
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
                              if (_name.text.isEmpty || _parent == null) {
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
                                    .updatecategory(
                                  widget.category.id,
                                  _name.text.trim(),
                                  _parent ?? 'New Category',
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
                    Customized().sizedheight(size.height * 0.02),
                  ],
                ),
              ],
            ),
    );
  }
}
