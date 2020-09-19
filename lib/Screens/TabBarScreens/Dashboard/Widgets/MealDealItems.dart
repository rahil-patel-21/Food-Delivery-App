import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/AllRestaurantList/AllRestaurantList.dart';
import 'package:product/Screens/BannerDetailsScreen/BannerDetailsScreen.dart';
import 'package:product/generated/i18n.dart';

class MealDealsItems extends StatelessWidget {
  final double width;
  final List<MealDeal> mealDealList;
  MealDealsItems(this.width, this.mealDealList);
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: width,
      height: 190,
      // color: AppColor.red,
      padding: new EdgeInsets.only(top: 8),
      child: new Column(
        children: <Widget>[
          Container(
            padding: new EdgeInsets.only(left: 15, right: 15),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                setCommonText(S.current.mealDeals, AppColor.black, 18.0,
                    FontWeight.w600, 1),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllRestaurantList(
                              title: S.current.mealDeals,
                              apiKey: APIS.mealDeals,
                              isMealDeal: true,
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
            // color: AppColor.red,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mealDealList.length,
              itemBuilder: (context, index) {
                return new GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => BannerDetailsScreen(
                                  restaurantID: mealDealList[index].id,
                                )));
                  },
                  child: new Container(
                    width: width / 2.5,
                    padding: new EdgeInsets.all(8),
                    child: new Material(
                      color: AppColor.white,
                      elevation: 1.0,
                      borderRadius: new BorderRadius.circular(8),
                      child: new Stack(
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Expanded(
                                flex: 1,
                                child: new Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            mealDealList[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ],
                          ),
                          new Container(
                            decoration: BoxDecoration(
                                color: AppColor.black.withOpacity(0.6),
                                borderRadius: new BorderRadius.circular(8)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                width: width / 2.5,
                                padding: new EdgeInsets.only(bottom: 3),
                                child: new Container(
                                  padding: new EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new Text(
                                        mealDealList[index].name,
                                        style: new TextStyle(
                                            fontSize: 13,
                                            color: AppColor.amber,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 3),
                                      new Text(
                                        mealDealList[index].name,
                                        style: new TextStyle(
                                            fontSize: 12,
                                            color: AppColor.white,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
