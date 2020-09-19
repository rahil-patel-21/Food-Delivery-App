import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';

class RestaurantDetailsWidget extends StatelessWidget {
  final String resName;
  final String resAddress;
  RestaurantDetailsWidget(this.resName, this.resAddress);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // height: 110,
      // color: AppColor.green,
      padding: new EdgeInsets.all(10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Divider(
            color: AppColor.grey[400],
          ),
          setCommonText(resName, AppColor.black, 18.0, FontWeight.w500, 1),
          SizedBox(
            height: 5,
          ),
          setCommonText(resAddress, AppColor.grey, 15.0, FontWeight.w400, 2),
        ],
      ),
    );
  }
}
