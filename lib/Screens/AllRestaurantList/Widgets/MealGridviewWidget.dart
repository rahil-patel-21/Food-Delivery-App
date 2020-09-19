import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelMealDeals.dart';
import 'package:product/Screens/BannerDetailsScreen/BannerDetailsScreen.dart';
import 'package:product/generated/i18n.dart';

class GridViewMealWidget extends StatelessWidget {
  final List<Result> data;
  GridViewMealWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 2,
        children: new List<Widget>.generate(data.length, (index) {
          return new GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => BannerDetailsScreen(
                        restaurantID: data[index].id,
                      )));
            },
            child: new Container(
              color: Colors.white,
              padding: new EdgeInsets.all(5),
              child: new Material(
                elevation: 1.0,
                borderRadius: new BorderRadius.circular(8),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: new Container(
                          // color: Colors.red,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data[index].image),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                        )),
                    Expanded(
                        flex: 4,
                        child: new Container(
                            // color: Colors.yellow,
                            padding: new EdgeInsets.only(
                                left: 3, right: 3, bottom: 2, top: 2),
                            child: _setCommonWidgetsForMealList(
                                14.0, 11.0, 11.0, 11.0, 12, data[index]))),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

_setCommonWidgetsForMealList(double titlFont, double descriptionFont,
    double ratingFont, double priceFont, double rationIconSize, Result item) {
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 2),
      setCommonText(item.name, Colors.black, titlFont, FontWeight.w500, 1),
      SizedBox(height: 3),
      setCommonText(item.restaurantName, Colors.grey[700], descriptionFont,
          FontWeight.w400, 1),
      SizedBox(
        height: 3,
      ),
      new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              setCommonText(
                  "4.1", Colors.orange, ratingFont, FontWeight.w500, 1),
              SizedBox(width: 2),
              new Icon(
                Icons.star,
                size: rationIconSize,
                color: Colors.orange,
              ),
              SizedBox(width: 2),
              setCommonText("12 ${S.current.reviews}", Colors.grey, ratingFont,
                  FontWeight.w400, 1),
            ],
          ),
          new Row(
            children: <Widget>[
              setCommonText(
                  '${Currency.curr}${(double.parse(item.price) - (double.parse(item.discount)))}',
                  Colors.black,
                  priceFont,
                  FontWeight.w600,
                  1),
            ],
          )
        ],
      )
    ],
  );
}
