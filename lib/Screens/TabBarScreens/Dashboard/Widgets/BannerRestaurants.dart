import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/BannerDetailsScreen/BannerDetailsScreen.dart';
import 'package:product/Screens/GoogleMapView/GoogleMapview.dart';

class BannerRestaurants extends StatelessWidget {
  final double width;
  final List<BannerRestaurent> bannerData;
  BannerRestaurants(this.width, this.bannerData);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: (width / 2 + 20),
      color: AppColor.colorGyay_100,
      padding: new EdgeInsets.only(top: 15, bottom: 15),
      child: CarouselSlider.builder(
        itemCount: bannerData.length,
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 1.0,
          enlargeCenterPage: true,
        ),
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              // Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context)=>RestaurantDetails()));
              SharedManager.shared.oldResID = SharedManager.shared.restaurantID;
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => BannerDetailsScreen(
                        restaurantID: bannerData[index].id,
                      )));
            },
            child: new Hero(
              tag: index,
              child: new Container(
                // padding: new EdgeInsets.only(left: 15, right: 5),
                // height: (width / 2 + 15),
                width: width,
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(bannerData[index].image),
                              fit: BoxFit.cover)),
                    ),
                    new Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    new Align(
                      alignment: Alignment.bottomCenter,
                      child: new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                              colors: <Color>[
                                new Color(0xFFFFFFFF).withOpacity(0),
                                new Color(0xFFFFFFFF).withOpacity(0),
                              ],
                              stops: [
                                0.0,
                                1.0
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(0.0, 1.0)),
                        ),
                        width: width,
                        padding:
                            new EdgeInsets.only(top: 10, left: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 8,
                                      ),
                                      setCommonText(
                                          (bannerData[index].review != null)
                                              ? '${bannerData[index].review}'
                                              : '0.0',
                                          AppColor.white,
                                          15.0,
                                          FontWeight.bold,
                                          1),
                                      Icon(
                                        Icons.star,
                                        color: AppColor.white,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Expanded(
                                  child: new Container(
                                    // color: AppColor.red,
                                    // height: 100,
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        setCommonText(
                                            bannerData[index].name,
                                            AppColor.white,
                                            18.0,
                                            FontWeight.bold,
                                            1),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        setCommonText(
                                            bannerData[index].address,
                                            AppColor.amber.shade300,
                                            15.0,
                                            FontWeight.bold,
                                            2),
                                      ],
                                    ),
                                  ),
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new IconButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    GoogleMapView(
                                                      bannerData: bannerData,
                                                    )));
                                      },
                                      icon: new Icon(Icons.place,
                                          color: AppColor.red[800]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    (bannerData[index].isAvailable == '0')
                        ? setRestaurantClosedWidget(
                            context, 'Restaurant Closed')
                        : Text('')
                  ],
                ),
              ),
            ),
          );
        },
      ),
      // child: new ListView.builder(
      //   itemCount: bannerData.length,
      //   scrollDirection: Axis.horizontal,
      //   itemBuilder: (context, int index) {
      //     return new GestureDetector(
      //       onTap: () {
      //         // Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context)=>RestaurantDetails()));
      //         SharedManager.shared.oldResID = SharedManager.shared.restaurantID;
      //         Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      //             builder: (context) => BannerDetailsScreen(
      //                   restaurantID: bannerData[index].id,
      //                 )));
      //       },
      //       child: new Hero(
      //         tag: index,
      //         child: new Container(
      //           padding: new EdgeInsets.only(left: 15, right: 5),
      //           // height: (width / 2 + 15),
      //           width: width / 1.2,
      //           child: new Stack(
      //             children: <Widget>[
      //               new Container(
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(8),
      //                     image: DecorationImage(
      //                         image: NetworkImage(bannerData[index].image),
      //                         fit: BoxFit.cover)),
      //               ),
      //               new Container(
      //                 decoration: BoxDecoration(
      //                     color: Colors.black.withOpacity(0.3),
      //                     borderRadius: BorderRadius.circular(8)),
      //               ),
      //               new Align(
      //                 alignment: Alignment.bottomCenter,
      //                 child: new Container(
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(8),
      //                     gradient: LinearGradient(
      //                         colors: <Color>[
      //                           new Color(0xFFFFFFFF).withOpacity(0),
      //                           new Color(0xFFFFFFFF).withOpacity(0),
      //                         ],
      //                         stops: [
      //                           0.0,
      //                           1.0
      //                         ],
      //                         begin: FractionalOffset(0.0, 0.0),
      //                         end: FractionalOffset(0.0, 1.0)),
      //                   ),
      //                   height: 100,
      //                   width: width,
      //                   padding: new EdgeInsets.all(10),
      //                   child: new Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: <Widget>[
      //                       new Expanded(
      //                         child: new Container(
      //                           // color: AppColor.red,
      //                           height: 100,
      //                           child: new Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: <Widget>[
      //                               setCommonText(
      //                                   bannerData[index].name,
      //                                   AppColor.white,
      //                                   18.0,
      //                                   FontWeight.bold,
      //                                   1),
      //                               SizedBox(
      //                                 height: 3,
      //                               ),
      //                               setCommonText(
      //                                   bannerData[index].address,
      //                                   AppColor.amber,
      //                                   15.0,
      //                                   FontWeight.bold,
      //                                   2),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       new Column(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: <Widget>[
      //                           new IconButton(
      //                             onPressed: () {
      //                               Navigator.of(context, rootNavigator: true)
      //                                   .push(MaterialPageRoute(
      //                                       builder: (context) => GoogleMapView(
      //                                             bannerData: bannerData,
      //                                           )));
      //                             },
      //                             icon: new Icon(Icons.place,
      //                                 color: AppColor.red[800]),
      //                           ),
      //                         ],
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
