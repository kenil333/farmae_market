import 'package:flutter/material.dart';

import './../../../all.dart';

class OwnerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Customized().sizedheight(size.height * 0.07),
          Customized().customButton(
            size,
            ConstantValue().owner,
            ConstantValue().deeporange,
            () {
              Customized().naviagt(
                context,
                OwnerButtons(),
              );
            },
          ),
          Customized().sizedheight(size.height * 0.04),
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.019),
                  child: Customized().customButton(
                    size,
                    ConstantValue().findmarkedplace,
                    ConstantValue().text,
                    () {
                      Customized().naviagt(
                        context,
                        FindMarkedPlaceScreen(),
                      );
                    },
                  ),
                ),
                // Positioned(
                //   top: 0,
                //   right: size.width * 0.08,
                //   child: Container(
                //     width: size.width * 0.072,
                //     height: size.width * 0.072,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: ConstantValue().redi,
                //     ),
                //     alignment: Alignment.center,
                //     child: Text(
                //       '0',
                //       style: TextStyle(
                //         color: ConstantValue().white,
                //         fontSize: size.width * 0.035,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Customized().sizedheight(size.height * 0.06),
          Customized().customButton(
            size,
            ConstantValue().pickupsystem,
            ConstantValue().greene,
            () {
              Customized().naviagt(
                context,
                PickUpSystemScreen(),
              );
            },
          ),
          Customized().sizedheight(size.height * 0.06),
          Customized().customButton(
            size,
            ConstantValue().productstock,
            ConstantValue().orange,
            () {
              Customized().naviagt(
                context,
                ProductStockScreen(),
              );
            },
          ),
          Customized().sizedheight(size.height * 0.06),
          Customized().customButton(
            size,
            ConstantValue().saloverview,
            ConstantValue().redi,
            () {
              Customized().naviagt(
                context,
                SaleOverButtonScreen(),
              );
            },
          ),
          Customized().sizedheight(size.height * 0.06),
          Customized().customButton(
            size,
            ConstantValue().setuparked,
            ConstantValue().bluli,
            () {
              Customized().naviagt(
                context,
                MarkedScreen(),
              );
            },
          ),
          Customized().sizedheight(size.height * 0.07),
        ],
      ),
    );
  }
}
