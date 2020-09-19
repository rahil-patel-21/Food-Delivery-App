import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/AllRestaurantList/AllRestaurantList.dart';
import 'package:product/Screens/RestaurantDetails/RestaurantDetails.dart';
import 'package:product/generated/i18n.dart';

class TopRestaurants extends StatelessWidget {
  final double width;
  final List<TopRestaurents> topRestaurant;
  TopRestaurants(this.width, this.topRestaurant);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: width,
      height: 200,
      // color: AppColor.red[100],
      padding: new EdgeInsets.only(top: 8),
      child: new Column(
        children: <Widget>[
          Container(
            padding: new EdgeInsets.only(left: 15, right: 10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                setCommonText(S.current.topRestaurants, AppColor.black, 18.0,
                    FontWeight.w600, 1),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllRestaurantList(
                              title: S.current.topRestaurants,
                              apiKey: APIS.allTopRestaurant,
                              isMealDeal: false,
                            )));
                  },
                  child: setCommonText(S.current.seeAll, AppColor.themeColor,
                      16.0, FontWeight.w600, 1),
                )
              ],
            ),
          ),
          new Container(
            width: width,
            height: 150,
            // color: Colors.red,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topRestaurant.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => RestaurantDetails(
                                  restaurantID: topRestaurant[index].id,
                                )));
                  },
                  child: new Container(
                    width: width / 2.5,
                    padding: new EdgeInsets.all(8),
                    child: Stack(
                      children: <Widget>[
                        new Material(
                          color: AppColor.white,
                          elevation: 1.0,
                          borderRadius: new BorderRadius.circular(8),
                          child: new Column(
                            children: <Widget>[
                              new Expanded(
                                flex: 2,
                                child: Stack(
                                  children: <Widget>[
                                    new Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                topRestaurant[index].image),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color:
                                              AppColor.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    Positioned(
                                        top: 8,
                                        right: 0,
                                        child: Container(
                                          height: 20,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: AppColor.amber.shade700,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              setCommonText(
                                                  (topRestaurant[index]
                                                              .review !=
                                                          null)
                                                      ? '${topRestaurant[index].review}'
                                                      : '0.0',
                                                  AppColor.white,
                                                  13.0,
                                                  FontWeight.w500,
                                                  1),
                                              Icon(
                                                Icons.star,
                                                color: AppColor.white,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        (topRestaurant[index].isAvailable == '0')
                            ? setRestaurantClosedWidget(context, 'Closed')
                            : Text('')
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
