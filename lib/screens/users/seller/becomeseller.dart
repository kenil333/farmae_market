import 'package:flutter/material.dart';

import './../../../all.dart';

class BecomeSellerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantValue().background,
      appBar: Customized().appBarOfScreens(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Customized().onlytitle(
                          size,
                          ConstantValue().blienselger,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.03,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Har du lokale råvarer som du ønsker å selge?',
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Customized().sizedheight(size.height * 0.03),
                              Text(
                                'Finn et marked i nærheten av deg!',
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontSize: size.width * 0.055,
                                ),
                              ),
                              Customized().sizedheight(size.height * 0.03),
                              Text(
                                'Med bondens marked får både kunden og du som selger en bedre handle opplevelse.',
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontSize: size.width * 0.045,
                                ),
                              ),
                              Customized().sizedheight(size.height * 0.03),
                              Text(
                                'Fordeler for selger:\n - Forhåndsbestilling\n - Hentesystem\n - Varelager',
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontSize: size.width * 0.045,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    ' ',
                                    style: TextStyle(
                                      color: ConstantValue().text,
                                      fontSize: size.width * 0.045,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '- Salgsoversikt med ferdigutfylt faktura slik at du slipper loggføring og dokumentering.',
                                      style: TextStyle(
                                        color: ConstantValue().text,
                                        fontSize: size.width * 0.045,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Customized().sizedheight(size.height * 0.03),
                              Text(
                                'Registrering og medlemskap er kostnadsfritt, med en kommisjon på 4.75%.',
                                style: TextStyle(
                                  color: ConstantValue().text,
                                  fontSize: size.width * 0.045,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Customized().sizedheight(size.height * 0.1),
                      ],
                    ),
                  ),
                ),
              ),
              Container(),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              child: Column(
                children: [
                  Customized().customButton(
                    size,
                    ConstantValue().registerseller,
                    ConstantValue().greene,
                    () {
                      Customized().naviagt(
                        context,
                        RegisterMobile(
                          ConstantValue().register,
                          ConstantValue().seller,
                        ),
                      );
                    },
                  ),
                  Customized().sizedheight(size.height * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
