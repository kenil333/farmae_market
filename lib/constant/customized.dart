import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shimmer/shimmer.dart';

import './../all.dart';

class Customized {
  appBarOfScreens() {
    return PreferredSize(
      child: AppBar(
        backgroundColor: ConstantValue().background,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        elevation: 0,
      ),
      preferredSize: Size.fromHeight(0),
    );
  }

  appbarwithicon(Size size, String title, Function func) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(
        color: ConstantValue().text,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: ConstantValue().text,
          fontSize: size.width * 0.06,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: ConstantValue().background,
      // ignore: deprecated_member_use
      brightness: Brightness.light,
      actions: [
        IconButton(
          onPressed: () {
            func();
          },
          icon: Icon(
            Icons.add_circle,
            size: size.width * 0.075,
            color: ConstantValue().greene,
          ),
        ),
      ],
    );
  }

  appBarwithdrawer(Size size, String title) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(
          ConstantValue().appicon1,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading:
          title == ConstantValue().appname ? false : true,
      iconTheme: IconThemeData(
        color: ConstantValue().zeri,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: ConstantValue().zeri,
          fontSize: size.width * 0.06,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: ConstantValue().background,
      // ignore: deprecated_member_use
      brightness: Brightness.light,
    );
  }

  appBarforlimit(Size size, String title, Function func) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading:
          title == ConstantValue().appname ? false : true,
      iconTheme: IconThemeData(
        color: ConstantValue().text,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: ConstantValue().text,
          fontSize: size.width * 0.06,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: ConstantValue().background,
      // ignore: deprecated_member_use
      brightness: Brightness.light,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.03),
          child: InkWell(
            onTap: () {
              func();
            },
            child: Icon(
              Icons.home_outlined,
              color: ConstantValue().text,
              size: size.width * 0.075,
            ),
          ),
        )
      ],
    );
  }

  sizedwidth(double value) {
    return SizedBox(
      width: value,
    );
  }

  sizedheight(double value) {
    return SizedBox(
      height: value,
    );
  }

  naviagt(BuildContext context, Widget widget) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  navigatereplas(BuildContext context, Widget widget) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  naviagtwithsetting(
    BuildContext context,
    Widget widget,
    String name,
  ) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: name),
        builder: (context) => widget,
      ),
    );
  }

  imagecenter(double size) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        ConstantValue().appicon,
        width: size,
        fit: BoxFit.contain,
      ),
    );
  }

  customButton(Size size, String title, Color color, Function func) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          primary: color,
        ),
        onPressed: () {
          func();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.018),
          child: Text(
            title,
            style: TextStyle(fontSize: size.width * 0.05),
          ),
        ),
      ),
    );
  }

  customButtonwithicon(Size size, String title, Color color, Function func) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          primary: color,
        ),
        onPressed: () {
          func();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.018),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                size: size.width * 0.06,
                color: ConstantValue().white,
              ),
              sizedwidth(size.width * 0.04),
              Text(
                title,
                style: TextStyle(fontSize: size.width * 0.05),
              ),
            ],
          ),
        ),
      ),
    );
  }

  firstbadge(Size size, String title, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.03,
      ),
      width: double.infinity,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ConstantValue().text,
              size: size.width * 0.08,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: size.width * 0.05),
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  color: ConstantValue().text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  textfeildwithtitle(
    Size size,
    String title,
    TextEditingController controller,
  ) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title :',
            style: TextStyle(
              color: ConstantValue().text,
              fontSize: size.width * 0.045,
            ),
          ),
          sizedheight(size.height * 0.01),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: size.width * 0.045,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ConstantValue().white,
              borderRadius: BorderRadius.circular(8),
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
                title == ConstantValue().mobile
                    ? Container(
                        padding: EdgeInsets.only(right: size.width * 0.03),
                        margin: EdgeInsets.only(right: size.width * 0.04),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 1,
                              color: ConstantValue().text,
                            ),
                          ),
                        ),
                        child: Text(
                          '+47',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ConstantValue().text,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                      )
                    : SizedBox(),
                Expanded(
                  child: TextField(
                    keyboardType: (title == ConstantValue().mobile ||
                            title == ConstantValue().price ||
                            title == ConstantValue().commisionfee ||
                            title == ConstantValue().available ||
                            title == ConstantValue().commision)
                        ? TextInputType.number
                        : title == ConstantValue().password
                            ? TextInputType.visiblePassword
                            : TextInputType.emailAddress,
                    obscureText:
                        title == ConstantValue().password ? true : false,
                    controller: controller,
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: ConstantValue().text,
                    ),
                    decoration: InputDecoration(
                      hintText: title,
                      border: InputBorder.none,
                    ),
                    textCapitalization: (title == ConstantValue().tips ||
                            title == ConstantValue().query ||
                            title == ConstantValue().description ||
                            title == ConstantValue().admintext ||
                            title == ConstantValue().applicatoiontext ||
                            title == ConstantValue().saletearms ||
                            title == '${ConstantValue().tearmsofuse} App' ||
                            title ==
                                '${ConstantValue().tearmsofuse} ${ConstantValue().seller}' ||
                            title ==
                                '${ConstantValue().tearmsofuse} ${ConstantValue().customer}')
                        ? TextCapitalization.sentences
                        : TextCapitalization.words,
                    maxLines: (title == ConstantValue().tips ||
                            title == ConstantValue().query ||
                            title == ConstantValue().description ||
                            title == ConstantValue().admintext ||
                            title == ConstantValue().applicatoiontext ||
                            title == ConstantValue().saletearms ||
                            title == '${ConstantValue().tearmsofuse} App' ||
                            title ==
                                '${ConstantValue().tearmsofuse} ${ConstantValue().seller}' ||
                            title ==
                                '${ConstantValue().tearmsofuse} ${ConstantValue().customer}')
                        ? 10
                        : 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onlylable(Size size, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(
        children: [
          Text(
            '$title :',
            style: TextStyle(
              color: ConstantValue().text,
              fontSize: size.width * 0.045,
            ),
          ),
          sizedheight(size.height * 0.01),
        ],
      ),
    );
  }

  otpfeild(Size size, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.circle,
          fieldHeight: size.width * 0.15,
          fieldWidth: size.width * 0.15,
          activeFillColor: ConstantValue().white,
          activeColor: ConstantValue().grey,
          selectedColor: ConstantValue().black,
          selectedFillColor: ConstantValue().blurgrey,
          inactiveFillColor: ConstantValue().blurgrey,
          inactiveColor: ConstantValue().grey,
        ),
        keyboardType: TextInputType.number,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        onCompleted: (pin) {
          print(pin);
        },
        onChanged: (value) {},
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return true;
        },
      ),
    );
  }

  dynamictextfeild(Size size, String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title :',
          style: TextStyle(
            color: ConstantValue().text,
            fontSize: size.width * 0.045,
          ),
        ),
        sizedheight(size.height * 0.01),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: size.width * 0.012,
            horizontal: size.width * 0.045,
          ),
          decoration: BoxDecoration(
            color: ConstantValue().white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 20,
                color: ConstantValue().text.withOpacity(0.23),
              ),
            ],
          ),
          child: TextField(
            keyboardType: (title == ConstantValue().postcode ||
                    title == ConstantValue().verdi ||
                    title == ConstantValue().fakturano)
                ? TextInputType.number
                : TextInputType.emailAddress,
            obscureText: false,
            controller: controller,
            style: TextStyle(
              fontSize: size.width * 0.045,
              color: ConstantValue().text,
            ),
            decoration: InputDecoration(
              hintText: title,
              border: InputBorder.none,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  onlytitle(Size size, String title) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.03,
      ),
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontSize: title == ConstantValue().blienselger
              ? size.width * 0.08
              : size.width * 0.06,
          color: ConstantValue().text,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  orderstemp(
    Size size,
    Function func,
    String name,
    String date,
  ) {
    return Column(
      children: [
        sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.03,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ConstantValue().white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: ConstantValue().text.withOpacity(0.23),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                sizedheight(size.height * 0.015),
                Text(
                  date,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        sizedheight(size.height * 0.015),
      ],
    );
  }

  markedonlynameaddress(Size size, Function func) {
    return Column(
      children: [
        sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.03,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ConstantValue().white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: ConstantValue().text.withOpacity(0.23),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Reko ringen Sandnes',
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                sizedheight(size.height * 0.015),
                Text(
                  'Fogovegen 31, 4340 Sandnes',
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        sizedheight(size.height * 0.015),
      ],
    );
  }

  orderwithsellerstemp(
    Size size,
    Function func,
    String name,
    String id,
  ) {
    return Column(
      children: [
        sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.02,
            ),
            width: double.infinity,
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
            child: perticularSeller(
              size,
              name,
              id,
            ),
          ),
        ),
        sizedheight(size.height * 0.015),
      ],
    );
  }

  perticularSeller(
    Size size,
    String name,
    String orderid,
  ) {
    return Row(
      children: [
        Image.asset(
          ConstantValue().selpic,
          width: size.width * 0.25,
          fit: BoxFit.contain,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: size.width * 0.05),
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: ConstantValue().text,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          alignment: Alignment.center,
          child: Text(
            '#$orderid',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.06,
              color: ConstantValue().text,
            ),
          ),
        ),
      ],
    );
  }

  ordertitle(
    Size size,
    String name,
    String address,
    String date,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              color: ConstantValue().text,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              address,
              style: TextStyle(
                color: ConstantValue().text,
                fontSize: size.width * 0.05,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              color: ConstantValue().text,
              fontSize: size.width * 0.05,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  onlymarketnameaddress(
    Size size,
    Function func,
    String name,
    String address,
  ) {
    return Column(
      children: [
        Customized().sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            width: double.infinity,
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
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Customized().sizedheight(size.height * 0.015),
                Text(
                  address,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Customized().sizedheight(size.height * 0.015),
      ],
    );
  }

  marketStemp(
    Size size,
    Function func,
    String name,
    String address,
    String date,
  ) {
    return Column(
      children: [
        Customized().sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            width: double.infinity,
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
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Customized().sizedheight(size.height * 0.015),
                Text(
                  address,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
                Customized().sizedheight(size.height * 0.015),
                Text(
                  date,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Customized().sizedheight(size.height * 0.015),
      ],
    );
  }

  findnewmarketStemp(
    Size size,
    Function func,
    bool free,
    String name,
    String address,
  ) {
    return Column(
      children: [
        Customized().sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            width: double.infinity,
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
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Customized().sizedheight(size.height * 0.015),
                Text(
                  address,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
                Customized().sizedheight(size.height * 0.015),
                Text(
                  free
                      ? ConstantValue().frrejoin
                      : ConstantValue().needapprovement,
                  style: TextStyle(
                    color: free ? ConstantValue().greene : ConstantValue().redi,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Customized().sizedheight(size.height * 0.015),
      ],
    );
  }

  customdropdown(
    Size size,
    String? change,
    Function func,
    List<String> list,
    String hint,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: 6,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ConstantValue().white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: ConstantValue().text.withOpacity(0.23),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Icon(
            Icons.arrow_downward_rounded,
            color: ConstantValue().text,
          ),
          isExpanded: true,
          value: change,
          style: TextStyle(
            color: ConstantValue().text,
            fontSize: size.width * 0.045,
          ),
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                hint == ConstantValue().tax ? '$value %' : value,
                style: TextStyle(
                  color: ConstantValue().text,
                  fontSize: size.width * 0.045,
                ),
              ),
            );
          }).toList(),
          hint: Text('$hint'),
          onChanged: (String? value) {
            func(value);
          },
        ),
      ),
    );
  }

  sellerStempinMarket(
    Size size,
    Function func,
    String name,
  ) {
    return Column(
      children: [
        sizedheight(size.height * 0.015),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          width: double.infinity,
          child: InkWell(
            onTap: () {
              func();
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ConstantValue().white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    color: ConstantValue().text.withOpacity(0.23),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: Image.asset(
                        ConstantValue().banner,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  sizedheight(size.height * 0.02),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                    ),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Image.asset(
                          ConstantValue().selpic,
                          width: size.width * 0.2,
                          fit: BoxFit.contain,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Customized().sizedheight(size.height * 0.002),
                                Text(
                                  'Microbines, Urter, Postjon',
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedheight(size.height * 0.015),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                    ),
                    width: double.infinity,
                    child: Text(
                      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley',
                      style: TextStyle(
                        color: ConstantValue().text,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ),
                  sizedheight(size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
        sizedheight(size.height * 0.015),
      ],
    );
  }

  makeorderfirststemp(
    Size size,
    SellerCust seller,
    OnlyOneMarkedCust marked,
  ) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.3,
            child: Image.asset(
              ConstantValue().banner,
              fit: BoxFit.fill,
            ),
          ),
          sizedheight(size.height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
            ),
            width: double.infinity,
            child: Row(
              children: [
                Image.asset(
                  ConstantValue().selpic,
                  width: size.width * 0.2,
                  fit: BoxFit.contain,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seller.company,
                          style: TextStyle(
                            color: ConstantValue().text,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Customized().sizedheight(size.height * 0.002),
                        Text(
                          'Microbines, Urter, Postjon',
                          style: TextStyle(
                            color: ConstantValue().text,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          sizedheight(size.height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
            ),
            width: double.infinity,
            child: Text(
              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley',
              style: TextStyle(
                color: ConstantValue().text,
                fontSize: size.width * 0.04,
              ),
            ),
          ),
          Customized().sizedheight(size.height * 0.015),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
            ),
            child: Row(
              children: [
                Text(
                  'Sted :   ',
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.045,
                  ),
                ),
                Text(
                  marked.name,
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.045,
                  ),
                ),
              ],
            ),
          ),
          Customized().sizedheight(size.height * 0.005),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
            ),
            child: Row(
              children: [
                Text(
                  'Nar :   ',
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.045,
                  ),
                ),
                Text(
                  '${marked.day} ${DateFormat('dd/MM/yyyy').format(marked.date)}',
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.045,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pricetag(Size size, String title, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.004),
      child: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          Row(
            children: [
              Container(
                width: size.width * 0.3,
                alignment: Alignment.centerLeft,
                child: Text(
                  '$title :',
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.045,
                  ),
                ),
              ),
              Container(
                width: size.width * 0.3,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kr $value',
                  style: TextStyle(
                    color: ConstantValue().text,
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  confirmordprod(
    Size size,
    OrderProd prod,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.015,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.02,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ConstantValue().white,
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
              imageUrl: prod.image,
              placeholder: (context, url) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: size.width * 0.2,
              height: size.width * 0.2,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  prod.name,
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Customized().sizedheight(size.height * 0.002),
                                Text(
                                  'Kr ${prod.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: ConstantValue().text,
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.005,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ConstantValue().greene,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            '${prod.count}',
                            style: TextStyle(
                              color: ConstantValue().greene,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.05,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Customized().sizedheight(size.height * 0.012),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                            ),
                            child: Text(
                              '${prod.count} stk x ${prod.price.toStringAsFixed(2)} Kr = ',
                              style: TextStyle(
                                color: ConstantValue().text,
                                fontSize: size.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Kr ${prod.total.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: ConstantValue().text,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sellernameimage(
    Size size,
    Function func,
    String name,
  ) {
    return InkWell(
      onTap: () {
        func();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.03,
        ),
        width: double.infinity,
        child: Row(
          children: [
            Image.asset(
              ConstantValue().selpic,
              width: size.width * 0.25,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: ConstantValue().text,
                        fontSize: size.width * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Customized().sizedheight(size.height * 0.002),
                    Text(
                      'Microbines, Urter, Postjon',
                      style: TextStyle(
                        color: ConstantValue().text,
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  stempOfNameIcon(Size size, String title, Function func) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.025),
      child: InkWell(
        onTap: () {
          func();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 20,
                color: Color(0xFF305F72).withOpacity(0.23),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.025,
            horizontal: size.width * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  color: Color(0xFF305F72),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: size.width * 0.075,
                color: Color(0xFF305F72),
              ),
            ],
          ),
        ),
      ),
    );
  }

  disabledstemp(Size size, String title, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title :',
            style: TextStyle(
              color: ConstantValue().text,
              fontSize: size.width * 0.045,
            ),
          ),
          sizedheight(size.height * 0.01),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02,
              horizontal: size.width * 0.045,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ConstantValue().white,
              borderRadius: BorderRadius.circular(8),
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
                title == ConstantValue().mobile
                    ? Container(
                        padding: EdgeInsets.only(right: size.width * 0.03),
                        margin: EdgeInsets.only(right: size.width * 0.04),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 1,
                              color: ConstantValue().text,
                            ),
                          ),
                        ),
                        child: Text(
                          '+47',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ConstantValue().text,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                      )
                    : SizedBox(),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        color: ConstantValue().text,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  inProdStockstemp(
    Size size,
    Function func,
    bool show,
    String name,
    String price,
    String id,
    String available,
    String image,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.015,
      ),
      child: InkWell(
        onTap: () {
          func();
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
            vertical: size.height * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ConstantValue().white,
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
                imageUrl: image,
                placeholder: (context, url) => Container(
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: size.width * 0.2,
                height: size.width * 0.2,
                fit: BoxFit.contain,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: ConstantValue().text,
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Customized().sizedheight(size.height * 0.002),
                      Text(
                        'Kr $price',
                        style: TextStyle(
                          color: ConstantValue().text,
                          fontSize: size.width * 0.04,
                        ),
                      ),
                      //show?
                      Column(
                        children: [
                          Customized().sizedheight(size.height * 0.002),
                          Text(
                            id,
                            style: TextStyle(
                              color: ConstantValue().text,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ],
                      )
                      // : Container(),
                    ],
                  ),
                ),
              ),
              Text(
                available,
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  color: ConstantValue().text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizedwidth(size.width * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  choosedate(Size size, String title, String value, Function func) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title :',
            style: TextStyle(
              color: ConstantValue().text,
              fontSize: size.width * 0.045,
            ),
          ),
          sizedheight(size.height * 0.01),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.008,
              horizontal: size.width * 0.045,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ConstantValue().white,
              borderRadius: BorderRadius.circular(8),
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
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        color: ConstantValue().text,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    func();
                  },
                  icon: Icon(
                    Icons.date_range,
                    color: ConstantValue().text,
                    size: size.width * 0.08,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  datechooserow(
    Size size,
    String value,
    Function choose,
    Function submit,
    bool load,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.008,
                horizontal: size.width * 0.045,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ConstantValue().white,
                borderRadius: BorderRadius.circular(8),
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
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: ConstantValue().text,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      choose();
                    },
                    icon: Icon(
                      Icons.date_range,
                      color: ConstantValue().text,
                      size: size.width * 0.08,
                    ),
                  ),
                ],
              ),
            ),
          ),
          sizedwidth(size.width * 0.05),
          load
              ? CircularProgressIndicator()
              : InkWell(
                  onTap: () {
                    submit();
                  },
                  child: Icon(
                    Icons.add_circle,
                    size: size.width * 0.15,
                    color: ConstantValue().greene,
                  ),
                ),
        ],
      ),
    );
  }

  datepicstemp(Size size, String title, Function func) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.018,
      ),
      width: size.width * 0.45,
      decoration: BoxDecoration(
        color: ConstantValue().white,
        borderRadius: BorderRadius.circular(8),
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
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  color: ConstantValue().text,
                  fontSize: size.width * 0.04,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              func();
            },
            child: Icon(
              Icons.date_range,
              color: ConstantValue().text,
              size: size.width * 0.07,
            ),
          ),
        ],
      ),
    );
  }

  datepicker(
    BuildContext context,
    Function func,
    String title,
  ) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: title == 'Sta'
          ? DateTime.parse('20210601')
          : DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime.now().add(
        Duration(
          days: 365,
        ),
      ),
    ).then(
      (DateTime? date) {
        func(date);
      },
    );
  }

  joinorjoinedmarketstemp(
    Size size,
    Function func,
    String date,
    bool joined,
    bool run,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.03,
      ),
      width: double.infinity,
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
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: size.width * 0.03),
              child: Text(
                date,
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  color: ConstantValue().text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          run
              ? CircularProgressIndicator()
              : InkWell(
                  onTap: () {
                    func();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: joined
                          ? ConstantValue().greene
                          : ConstantValue().orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      joined ? ConstantValue().joined : ConstantValue().join,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: ConstantValue().white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  markeddatelist(Size size, Function func, String date, String sellers) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.width * 0.03),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      width: double.infinity,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              func();
            },
            child: Icon(
              Icons.remove_circle,
              size: size.width * 0.08,
              color: ConstantValue().redi,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                date,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.06,
                  color: ConstantValue().text,
                ),
              ),
            ),
          ),
          Text(
            sellers,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.06,
              color: ConstantValue().text,
            ),
          ),
        ],
      ),
    );
  }

  searchwidget(
    Size size,
    String hint,
    TextEditingController controller,
    Function func,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: 5,
      ),
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: size.width * 0.045,
                color: ConstantValue().text,
              ),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
              maxLines: 1,
            ),
          ),
          sizedwidth(size.width * 0.04),
          InkWell(
            onTap: () {
              func();
            },
            child: Icon(
              Icons.search,
              size: size.width * 0.07,
              color: ConstantValue().text,
            ),
          ),
        ],
      ),
    );
  }

  detailStemp(Size size, String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.05),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: size.height * 0.01),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              '$title :',
              style: TextStyle(
                fontSize: size.width * 0.045,
                color: ConstantValue().text,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: size.width * 0.04,
              horizontal: size.width * 0.045,
            ),
            decoration: BoxDecoration(
              color: ConstantValue().white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: ConstantValue().text.withOpacity(0.23),
                ),
              ],
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: ConstantValue().text,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  stempincommisiondetail(Size size, String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.03),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      width: double.infinity,
      child: Row(
        children: [
          Text(
            '$title : ',
            style: TextStyle(
              fontSize: size.width * 0.045,
              color: ConstantValue().text,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: ConstantValue().text,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  singlecategory(Size size, String cate, Function func) {
    return InkWell(
      onTap: () {
        func();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.025,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: ConstantValue().text,
            ),
          ),
        ),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Text(
                cate,
                style: TextStyle(
                  color: ConstantValue().text,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.055,
                ),
              ),
            ),
            sizedwidth(size.width * 0.04),
            Icon(
              Icons.arrow_forward_ios,
              color: ConstantValue().text,
              size: size.width * 0.06,
            ),
          ],
        ),
      ),
    );
  }

  timestemp(
    Size size,
    Function func,
    String date,
  ) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Customized().sizedwidth(size.width * 0.05),
          Expanded(
            child: InkWell(
              onTap: () {
                func();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.03,
                ),
                decoration: BoxDecoration(
                  color: ConstantValue().white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ConstantValue().text,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      color: ConstantValue().text.withOpacity(0.23),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ConstantValue().text,
                    fontSize: size.width * 0.055,
                  ),
                ),
              ),
            ),
          ),
          Customized().sizedwidth(size.width * 0.05),
        ],
      ),
    );
  }

  stempincommistion(
    Size size,
    Function func,
    String name,
    String date,
    bool invoice,
  ) {
    return Column(
      children: [
        sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.03,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ConstantValue().white,
              borderRadius: BorderRadius.circular(8),
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
                Container(
                  width: size.width * 0.15,
                  height: size.width * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: invoice
                        ? ConstantValue().greene
                        : ConstantValue().orange,
                  ),
                ),
                sizedwidth(size.width * 0.1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: ConstantValue().text,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      sizedheight(size.height * 0.015),
                      Text(
                        date,
                        style: TextStyle(
                          color: ConstantValue().text,
                          fontSize: size.width * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        sizedheight(size.height * 0.015),
      ],
    );
  }

  sellerstempcommition(
    Size size,
    Function func,
    String name,
    String price,
    bool invoice,
  ) {
    return Column(
      children: [
        sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
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
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: invoice
                                ? ConstantValue().greene
                                : ConstantValue().orange,
                          ),
                        ),
                        sizedwidth(size.width * 0.05),
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              color: ConstantValue().text,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.05,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                sizedwidth(size.width * 0.05),
                Text(
                  'Kr $price',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05,
                    color: ConstantValue().greene,
                  ),
                ),
              ],
            ),
          ),
        ),
        sizedheight(size.height * 0.015),
      ],
    );
  }

  totsalandanother(
    Size size,
    String totselers,
    String sels,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.05,
      ),
      child: Row(
        children: [
          Container(
            width: size.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${ConstantValue().total} ${ConstantValue().sellers} : ',
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: ConstantValue().text,
                  ),
                ),
                Text(
                  totselers,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    color: ConstantValue().text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${ConstantValue().fullfortsalg} : ',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: ConstantValue().text,
                    ),
                  ),
                  Text(
                    sels,
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: ConstantValue().text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  selernameandkam(
    Size size,
    Function func,
    String name,
    String total,
  ) {
    return Column(
      children: [
        sizedheight(size.height * 0.015),
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.03,
            ),
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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: ConstantValue().text,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.07,
                    ),
                  ),
                ),
                sizedwidth(size.width * 0.05),
                Text(
                  'Kr $total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.055,
                    color: ConstantValue().greene,
                  ),
                ),
              ],
            ),
          ),
        ),
        sizedheight(size.height * 0.015),
      ],
    );
  }

  snak(String title, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: ConstantValue().white,
      ),
    );
  }

  datanot(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
      ),
      width: double.infinity,
      child: Image.asset(
        ConstantValue().dnf,
        height: size.height * 0.45,
        fit: BoxFit.contain,
      ),
    );
  }

  loading() {
    return Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  wrongDialog(String message, BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: size.height * 0.25,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ConstantValue().wrong,
                fit: BoxFit.cover,
                height: size.height * 0.1,
              ),
              SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ConstantValue().redi,
                  fontSize: size.width * 0.055,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  wrongdouble(
    String message1,
    String message2,
    BuildContext context,
    Size size,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: size.height * 0.3,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ConstantValue().wrong,
                fit: BoxFit.cover,
                height: size.height * 0.1,
              ),
              SizedBox(height: 20),
              Text(
                message1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ConstantValue().redi,
                  fontSize: size.width * 0.055,
                ),
              ),
              Text(
                message2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ConstantValue().redi,
                  fontSize: size.width * 0.055,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dnfsmall(Size size) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        ConstantValue().dnf,
        height: size.height * 0.4,
        fit: BoxFit.contain,
      ),
    );
  }

  truediload(String message, BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: size.height * 0.25,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ConstantValue().truegif,
                fit: BoxFit.cover,
                height: size.height * 0.1,
              ),
              SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ConstantValue().greene,
                  fontSize: size.width * 0.055,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  disbaledtextfield(
    Size size,
    String title,
    TextEditingController controller,
    bool lock,
    Function func,
  ) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title :',
            style: TextStyle(
              color: ConstantValue().text,
              fontSize: size.width * 0.045,
            ),
          ),
          sizedheight(size.height * 0.01),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: size.width * 0.045,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ConstantValue().white,
              borderRadius: BorderRadius.circular(8),
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
                title == ConstantValue().mobile
                    ? Container(
                        padding: EdgeInsets.only(right: size.width * 0.03),
                        margin: EdgeInsets.only(right: size.width * 0.04),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 1,
                              color: ConstantValue().text,
                            ),
                          ),
                        ),
                        child: Text(
                          '+47',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ConstantValue().text,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                      )
                    : SizedBox(),
                Expanded(
                  child: TextField(
                    enabled: false,
                    obscureText: lock ? true : false,
                    controller: controller,
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: ConstantValue().text,
                    ),
                    decoration: InputDecoration(
                      hintText: title,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                title == ConstantValue().password
                    ? Container(
                        //padding: EdgeInsets.only(right: size.width * 0.03),
                        //margin: EdgeInsets.only(right: size.width * 0.04),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            func();
                          },
                          child: Icon(
                            lock
                                ? Icons.lock_outline_sharp
                                : Icons.lock_open_outlined,
                            color: ConstantValue().text,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  valuewithdiolog(
    BuildContext context,
    Size size,
    String title,
    TextEditingController controller,
    Function func,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: size.height * 0.25,
          width: size.width * 0.8,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sizedheight(size.height * 0.04),
              textfeildwithtitle(
                size,
                title,
                controller,
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      onTap: () {
                        func();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.012,
                          horizontal: size.width * 0.05,
                        ),
                        color: ConstantValue().greene,
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: ConstantValue().white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  sellerinsetupshimmer(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.03,
      ),
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: ConstantValue().white,
        highlightColor: ConstantValue().grey,
        child: Row(
          children: [
            Container(
              width: size.width * 0.25,
              height: size.width * 0.25,
              color: ConstantValue().white,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width * 0.3,
                      height: 50,
                      color: ConstantValue().white,
                    ),
                    Customized().sizedheight(size.height * 0.002),
                    Container(
                      width: size.width * 0.4,
                      height: 40,
                      color: ConstantValue().white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  categoryshimmer(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.025,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ConstantValue().text,
          ),
        ),
      ),
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: ConstantValue().white,
        highlightColor: ConstantValue().grey,
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: size.width * 0.35,
                height: 40,
                color: ConstantValue().white,
              ),
            ),
            sizedwidth(size.width * 0.04),
            Icon(
              Icons.arrow_forward_ios,
              color: ConstantValue().text,
              size: size.width * 0.06,
            ),
          ],
        ),
      ),
    );
  }

  pricefetch(Size size) {
    return Shimmer.fromColors(
      child: Container(
        width: size.width * 0.2,
        height: 30,
        color: ConstantValue().white,
      ),
      baseColor: ConstantValue().white,
      highlightColor: ConstantValue().grey,
    );
  }
}
