import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import './../../../all.dart';

class OrderDataProdStemp extends StatefulWidget {
  final String title;
  final String name;
  final String image;
  final String price;
  final String qty;
  final String unit;
  OrderDataProdStemp(
    this.title,
    this.name,
    this.image,
    this.price,
    this.qty,
    this.unit,
  );
  @override
  _OrderDataProdStempState createState() => _OrderDataProdStempState();
}

class _OrderDataProdStempState extends State<OrderDataProdStemp> {
  bool _taped = false;

  Color? findcolor() {
    if (widget.title == ConstantValue().missinggoods && _taped) {
      return ConstantValue().sloworange;
    } else if (widget.title == ConstantValue().retungood && _taped) {
      return ConstantValue().slowored;
    } else {
      return ConstantValue().white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Customized().sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            if (!_taped) {
              _taped = true;
            } else {
              _taped = false;
            }
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.015,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: findcolor(),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: ConstantValue().text.withOpacity(0.23),
                ),
              ],
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.image,
                  placeholder: (context, url) => Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: size.width * 0.25,
                  height: size.width * 0.25,
                  fit: BoxFit.contain,
                ),
                Customized().sizedwidth(size.width * 0.05),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            color: ConstantValue().text,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                        Customized().sizedheight(size.height * 0.01),
                        Text(
                          'Kr ${widget.price}  -  ${widget.qty} ${widget.unit}',
                          style: TextStyle(
                            color: ConstantValue().text,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Customized().sizedheight(size.height * 0.015),
      ],
    );
  }
}
