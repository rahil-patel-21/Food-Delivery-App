import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/RestaurantDetails.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/Screens/Cart/Cart.dart';
import 'package:product/Screens/RestaurantItemList/RestaurantItemList.dart';
import 'package:product/Screens/ReviewListScreen/ReviewListScreen.dart';
import 'package:product/generated/i18n.dart';

import 'Widgets/ReviewWidgets/ReviewWidgets.dart';

void main() => runApp(new BannerDetailsScreen());

class BannerDetailsScreen extends StatefulWidget {
  final restaurantID;
  BannerDetailsScreen({Key key, this.restaurantID}) : super(key: key);
  @override
  _BannerDetailsScreenState createState() => _BannerDetailsScreenState();
}

class _BannerDetailsScreenState extends State<BannerDetailsScreen> {
  var itemCount = 0;
  var totlaPrice = 0.0;
  bool isFirst = false;
  var result = ResDetails();
  bool isGrid = false;

  InterstitialAd myInterstitial;

  @override
  void initState() {
    // try {
    //   SharedManager.shared.myBanner.dispose();
    //   SharedManager.shared.myBanner = null;
    // } catch (ex) {
    //   print("banner dispose error");
    // }

    _setIntestatialAdds();

    super.initState();
    print("Restaurant id:${widget.restaurantID}");
    SharedManager.shared.restaurantID = this.widget.restaurantID;
  }

  @override
  void dispose() {
    try {
      this.myInterstitial.dispose();
      this.myInterstitial = null;
    } catch (ex) {
      print("banner dispose error");
    }
    super.dispose();
  }

  _setIntestatialAdds() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['food', 'Zometo', 'Food Panda', 'Uber Eats'],
      contentUrl: 'google.com',
      childDirected: false, // or MobileAdGender.female, MobileAdGender.unknown
      testDevices: <String>[], // Android emulators are considered test devices
    );

    this.myInterstitial = InterstitialAd(
      adUnitId: Keys.interstatialID,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );

    FirebaseAdMob.instance.initialize(appId: Keys.admobAppID);
    this.myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }

  _setSocialWidgets(double width, String review, String resName) {
    return new Container(
      width: width,
      height: 80,
      // color: AppColor.red,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.share,
                color: AppColor.black,
              ),
              setCommonText(
                  S.current.share, AppColor.black, 14.0, FontWeight.w600, 1)
            ],
          ),
          SizedBox(
            width: 30,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.phone,
                color: AppColor.black,
              ),
              setCommonText(
                  S.current.contact, AppColor.black, 14.0, FontWeight.w600, 1)
            ],
          ),
          SizedBox(
            width: 30,
          ),
          InkWell(
            onTap: () {
              if (review != '0.0') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReviewListScreen(
                        restaurantId: this.widget.restaurantID,
                        restaurantName: resName),
                    fullscreenDialog: true));
              } else {
                SharedManager.shared.showAlertDialog(
                    '${S.current.reviewNotAvailable}', context);
              }
            },
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    setCommonText(
                        '$review', AppColor.black, 16.0, FontWeight.bold, 1),
                    Icon(
                      Icons.star,
                      color: AppColor.orange,
                      size: 18,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                setCommonText("${S.current.reviews}", AppColor.black, 13.0,
                    FontWeight.w600, 1)
              ],
            ),
          )
        ],
      ),
    );
  }

  _setRestaurantDetails(List<Categories> categories) {
    return new Container(
        // color:AppColor.red,
        padding: new EdgeInsets.only(left: 15, right: 15, top: 5),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            setCommonText(S.current.res_recommenditions, AppColor.black, 22.0,
                FontWeight.w500, 1),
            SizedBox(
              height: 5,
            ),
            new Wrap(
                spacing: 5,
                runSpacing: 0,
                alignment: WrapAlignment.start,
                children: _setChipsWidgets(categories)),
            Divider(
              color: AppColor.grey,
            ),
          ],
        ));
  }

  List<Chip> _setChipsWidgets(List<Categories> categories) {
    List<Chip> chips = [];
    for (int i = 0; i < categories.length; i++) {
      final chip = new Chip(
        backgroundColor: AppColor.themeColor,
        label: setCommonText('${categories[i].categoryName}', AppColor.white,
            14.0, FontWeight.w500, 1),
      );
      chips.add(chip);
    }
    return chips;
  }

  _setAddressWidgets(
      String address, String discount, String openingTime, String closingTime) {
    return new Container(
      // height: 155,
      // color: AppColor.red,
      padding: new EdgeInsets.only(top: 3, left: 15, right: 15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          setCommonText(S.current.res_address, AppColor.grey[500], 18.0,
              FontWeight.w500, 1),
          SizedBox(height: 3),
          new Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: new Container(
                    // color: AppColor.white,
                    height: 50,
                    child: setCommonText(
                        address, AppColor.black, 16.0, FontWeight.w600, 2)),
              ),
            ],
          ),
          new Divider(
            color: AppColor.grey,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              setCommonText(S.current.delivery_in_minutes, AppColor.amber, 16.0,
                  FontWeight.w600, 2),
              SizedBox(
                height: 5,
              ),
              setCommonText('$discount% ${S.current.all_offer}', AppColor.teal,
                  16.0, FontWeight.w500, 1),
            ],
          ),
          Divider(
            color: AppColor.grey,
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText(S.current.opening_time, AppColor.amber, 16.0,
                      FontWeight.w600, 2),
                  SizedBox(
                    height: 5,
                  ),
                  setCommonText('$openingTime AM', AppColor.teal, 14.0,
                      FontWeight.w500, 1),
                ],
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText(S.current.closing_time, AppColor.amber, 16.0,
                      FontWeight.w600, 2),
                  SizedBox(
                    height: 5,
                  ),
                  setCommonText('$closingTime PM', AppColor.teal, 14.0,
                      FontWeight.w500, 1),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText('${S.current.availability}', AppColor.black,
                      16.0, FontWeight.w600, 2),
                  SizedBox(
                    height: 5,
                  ),
                  (result.isAvailable == '1')
                      ? setCommonText('${S.current.open}', Colors.green, 16.0,
                          FontWeight.bold, 1)
                      : setCommonText('${S.current.closed}', AppColor.red, 16.0,
                          FontWeight.bold, 1),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: AppColor.grey,
          )
        ],
      ),
    );
  }

  _setDynamicCategory(int subCatCount, dynamic data, double width,
      List<Categories> categories) {
    return Container(
      height: (categories.length == 1)
          ? (460 * subCatCount).toDouble()
          : calculateTotalHeight(data),
      // color: AppColor.red,
      child: new ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: subCatCount,
        itemBuilder: (context, index) {
          return _checkStatus(
              categories[index].isGrid,
              index,
              width,
              categories[index].subcategories,
              categories[index].categoryName,
              categories);
        },
      ),
    );
  }

  double calculateTotalHeight(List<Categories> categories) {
    var height = 0.0;
    for (var category in categories) {
      if (category.isGrid) {
        height = height +
            ((category.subcategories.length >= 3)
                ? (3 * 140)
                : (category.subcategories.length * 140));
      } else {
        height = height +
            ((category.subcategories.length >= 3)
                ? (3 * 150)
                : (category.subcategories.length * 150));
      }
    }
    print("Final Height is:$height");
    return height;
  }

  _checkStatus(bool status, int index, double width, List<Subcategories> data,
      String subCatName, List<Categories> categories) {
    if (status) {
      return _setSubCategoryGrid(
          (150.0 * ((data.length >= 3) ? 3 : data.length)),
          subCatName,
          width,
          index,
          data,
          categories);
    } else {
      return _setSubCategoryList(
          (175.0 * ((data.length >= 3) ? 3 : data.length)),
          subCatName,
          index,
          data,
          categories);
    }
  }

  _setSubCategoryList(double height, String subCategoryTitle, int index,
      List<Subcategories> data, List<Categories> categories) {
    return new Container(
      // color: AppColor.themeColor,
      height: (data.length >= 3)
          ? 410
          : (data.length == 1) ? (data.length * 170.0) : (data.length * 140.0),
      padding: new EdgeInsets.only(left: 15, right: 15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: new Container(
                    child: new Text(
                      subCategoryTitle,
                      style: new TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
              new Expanded(
                flex: 2,
                child: new Container(
                  height: 50,
                  // color: AppColor.red,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new IconButton(
                        icon: categories[index].isGrid
                            ? Icon(Icons.grid_on, color: AppColor.amber)
                            : Icon(Icons.list, color: AppColor.amber),
                        onPressed: () {
                          setState(() {
                            if (categories[index].isGrid) {
                              categories[index].isGrid = false;
                            } else {
                              categories[index].isGrid = true;
                            }
                          });
                        },
                      ),
                      data.length > 4
                          ? new GestureDetector(
                              onTap: () async {
                                if (result.isAvailable == '1') {
                                  final status = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantItemList(
                                                itemList: data,
                                                title: categories[index]
                                                    .categoryName,
                                              )));
                                  if (status) {
                                    setState(() {
                                      this.itemCount = 0;
                                      this.totlaPrice = 0.0;
                                      SharedManager.shared.cartItems = [];
                                      // this.itemCount =  _setItemCount(categories);
                                      for (var category in categories) {
                                        for (var subCat
                                            in category.subcategories) {
                                          if (subCat.isAdded) {
                                            SharedManager.shared.cartItems
                                                .add(subCat);
                                          }
                                        }
                                      }

                                      for (var item
                                          in SharedManager.shared.cartItems) {
                                        this.itemCount = this.itemCount + 1;
                                        this.totlaPrice = this.totlaPrice +
                                            (double.parse(item.price) -
                                                double.parse(item.discount));
                                      }
                                    });
                                  }
                                } else {
                                  commonRestaurantCloseAlert(context);
                                }
                              },
                              child: new Container(
                                  child: setCommonText(
                                      S.current.seeAll,
                                      AppColor.themeColor,
                                      15.0,
                                      FontWeight.w400,
                                      1)))
                          : new Text('')
                    ],
                  ),
                ),
              )
            ],
          ),
          new Container(
            height: (data.length >= 3) ? 350.0 : data.length * 115.0,
            // color: AppColor.black,
            child: new ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length >= 3 ? 3 : data.length,
              itemBuilder: (context, row) {
                return new Container(
                  padding: new EdgeInsets.all(5),
                  // height: (data.length >=3)?((500.0 - 120.0)/3):((data.length == 1)?(height - 50)/(data.length):
                  // (height - 140)/(data.length)),
                  // height: (data.length >= 3)
                  //     ? ((500.0 - 120.0) / 3)
                  //     : (height - 80) / 2,
                  child: new Material(
                    color: AppColor.white,
                    elevation: 3.0,
                    borderRadius: new BorderRadius.circular(5),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                            flex: 1,
                            child: new Stack(
                              children: <Widget>[
                                new Container(
                                  height: 105,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    // color: AppColor.amber,
                                    image: DecorationImage(
                                        // image: AssetImage(
                                        // 'Assets/RestaurantDetails/vegFood.jpg'),
                                        image: NetworkImage(data[row].image),
                                        fit: BoxFit.cover),
                                    borderRadius: new BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                  ),
                                ),
                                new Align(
                                  alignment: Alignment.bottomRight,
                                  child: new Container(
                                    padding: new EdgeInsets.all(5),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: (data[row].type == "1")
                                              ? AssetImage(
                                                  'Assets/RestaurantDetails/veg.png')
                                              : AssetImage(
                                                  'Assets/RestaurantDetails/nonVeg.png'),
                                          fit: BoxFit.cover),
                                      borderRadius: new BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5)),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 105,
                                  child: (data[row].isAvailable == '0')
                                      ? setItemOutOfStockWidget(
                                          context, '${S.current.outOfStock}')
                                      : Text(''),
                                )
                              ],
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        new Expanded(
                          flex: 2,
                          child: new Container(
                            padding: new EdgeInsets.only(top: 10, right: 10),
                            color: AppColor.white,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    new Expanded(
                                      flex: 2,
                                      child: new Container(
                                        color: AppColor.white,
                                        height: 40,
                                        child: new Align(
                                          alignment: Alignment.centerLeft,
                                          child: new Text(
                                            data[row].name,
                                            style: new TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: 5,),
                                    new Expanded(
                                      flex: 1,
                                      child: new Container(
                                        height: 35,
                                        child: new Material(
                                          color: AppColor.grey[600],
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                          child: new Container(
                                            padding: new EdgeInsets.all(2),
                                            child: InkWell(
                                              onTap: () {
                                                if (data[row].isAvailable ==
                                                    '1') {
                                                  setState(() {
                                                    if (data[row].isAdded) {
                                                      data[row].isAdded = false;
                                                    } else {
                                                      data[row].isAdded = true;
                                                    }
                                                    this.itemCount =
                                                        _setItemCount(
                                                            categories);
                                                  });
                                                } else {
                                                  commonItemOutofStockAlert(
                                                      context);
                                                }
                                              },
                                              child: new Material(
                                                color: AppColor.white,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10),
                                                child: new Center(
                                                  child: data[row].isAdded
                                                      ? setCommonText(
                                                          S.current.added,
                                                          AppColor.red,
                                                          12.0,
                                                          FontWeight.w600,
                                                          1)
                                                      : setCommonText(
                                                          S.current.add_plus,
                                                          AppColor.themeColor,
                                                          12.0,
                                                          FontWeight.w600,
                                                          1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                setCommonText(
                                    data[row].description,
                                    AppColor.grey[600],
                                    12.0,
                                    FontWeight.w500,
                                    2),
                                SizedBox(
                                  height: 3,
                                ),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        setCommonText('4.0', AppColor.orange,
                                            12.0, FontWeight.w600, 1),
                                        new Icon(
                                          Icons.star,
                                          color: AppColor.orange,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        setCommonText(
                                            S.current.votes,
                                            AppColor.grey,
                                            12.0,
                                            FontWeight.w600,
                                            1),
                                      ],
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        new Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            setCommonText(
                                                '${Currency.curr}${data[row].price}',
                                                AppColor.grey[600],
                                                12.0,
                                                FontWeight.w600,
                                                1),
                                            new Container(
                                              height: 2,
                                              width: 40,
                                              color: AppColor.grey[700],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        setCommonText(
                                            '${Currency.curr}${double.parse(data[row].price) - double.parse(data[row].discount)}',
                                            AppColor.black,
                                            12.0,
                                            FontWeight.w700,
                                            1),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
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

  _setSubCategoryGrid(double height, String subCategoryTitle, double width,
      int index, List<Subcategories> data, List<Categories> categories) {
    return new Container(
      // color: AppColor.green,
      height: (data.length == 1) ? height + 80 : height - 40,
      padding: new EdgeInsets.only(left: 15, right: 15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: new Container(
                    child: new Text(
                      subCategoryTitle,
                      style: new TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
              new Expanded(
                flex: 2,
                child: new Container(
                  height: 50,
                  // color: AppColor.red,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new IconButton(
                        icon: categories[index].isGrid
                            ? Icon(Icons.grid_on, color: AppColor.amber)
                            : Icon(Icons.list, color: AppColor.amber),
                        onPressed: () {
                          setState(() {
                            if (categories[index].isGrid) {
                              categories[index].isGrid = false;
                            } else {
                              categories[index].isGrid = true;
                            }
                          });
                        },
                      ),
                      data.length > 4
                          ? new GestureDetector(
                              onTap: () async {
                                if (result.isAvailable == '1') {
                                  final status = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantItemList(
                                                itemList: data,
                                                title: categories[index]
                                                    .categoryName,
                                              )));
                                  if (status) {
                                    setState(() {
                                      this.itemCount = 0;
                                      this.totlaPrice = 0.0;
                                      SharedManager.shared.cartItems = [];
                                      // this.itemCount =  _setItemCount(categories);
                                      for (var category in categories) {
                                        for (var subCat
                                            in category.subcategories) {
                                          if (subCat.isAdded) {
                                            SharedManager.shared.cartItems
                                                .add(subCat);
                                          }
                                        }
                                      }

                                      for (var item
                                          in SharedManager.shared.cartItems) {
                                        this.itemCount = this.itemCount + 1;
                                        this.totlaPrice = this.totlaPrice +
                                            (double.parse(item.price) -
                                                double.parse(item.discount));
                                      }
                                    });
                                  }
                                } else {
                                  commonRestaurantCloseAlert(context);
                                }
                              },
                              child: new Container(
                                  child: setCommonText(
                                      S.current.seeAll,
                                      AppColor.themeColor,
                                      15.0,
                                      FontWeight.w400,
                                      1)))
                          : new Text('')
                    ],
                  ),
                ),
              )
            ],
          ),
          new Container(
            height: (data.length >= 3)
                ? 360
                : (data.length == 1) ? height + 30 : height - 120,
            width: width,
            // color:AppColor.red,
            child: new GridView.count(
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 6 / 6.5,
              crossAxisCount: 2,
              children:
                  List.generate((data.length > 4) ? 4 : data.length, (row) {
                return new GestureDetector(
                  onTap: () async {},
                  child: new Container(
                    // color: AppColor.white,
                    padding: new EdgeInsets.all(4),
                    child: Stack(
                      children: <Widget>[
                        new Material(
                          elevation: 3.0,
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(6),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Expanded(
                                flex: 3,
                                child: new Stack(
                                  children: <Widget>[
                                    new Container(
                                      // color: AppColor.green,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  data[row].image)),
                                          borderRadius: new BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6))),
                                    ),
                                    new Container(
                                      padding: new EdgeInsets.all(5),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: (data[row].type == "1")
                                                ? AssetImage(
                                                    'Assets/RestaurantDetails/veg.png')
                                                : AssetImage(
                                                    'Assets/RestaurantDetails/nonVeg.png'),
                                            fit: BoxFit.cover),
                                        borderRadius: new BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              new Expanded(
                                flex: 2,
                                child: new Container(
                                  // color: AppColor.white,
                                  width: width,
                                  padding: new EdgeInsets.only(
                                      left: 5, top: 0, right: 5),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      setCommonText(
                                          data[row].name,
                                          AppColor.grey[800],
                                          12.0,
                                          FontWeight.w700,
                                          1),
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              new Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  setCommonText(
                                                      data[row].price,
                                                      AppColor.grey[500],
                                                      12.0,
                                                      FontWeight.w500,
                                                      1),
                                                  new Container(
                                                    height: 2,
                                                    width: 40,
                                                    color: AppColor.grey[700],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              setCommonText(
                                                  '${(double.parse(data[row].price)) - (double.parse(data[row].discount))}',
                                                  AppColor.black,
                                                  12.0,
                                                  FontWeight.w600,
                                                  1),
                                            ],
                                          ),
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new Expanded(
                                            flex: 3,
                                            child: new Container(
                                              height: 30,
                                              // color:AppColor.red,
                                              child: new Wrap(
                                                children: <Widget>[
                                                  setCommonText(
                                                      '${data[row].description}',
                                                      AppColor.grey,
                                                      12.0,
                                                      FontWeight.w500,
                                                      2),
                                                ],
                                              ),
                                            ),
                                          ),
                                          new Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (data[row].isAdded) {
                                                    data[row].isAdded = false;
                                                  } else {
                                                    data[row].isAdded = true;
                                                  }
                                                  this.itemCount =
                                                      _setItemCount(categories);
                                                });
                                              },
                                              child: new Container(
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColor.grey),
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(10)),
                                                child: new Center(
                                                  child: data[row].isAdded
                                                      ? Icon(Icons.check,
                                                          color: AppColor.red,
                                                          size: 18)
                                                      : setCommonText(
                                                          "+",
                                                          AppColor.themeColor,
                                                          20.0,
                                                          FontWeight.w700,
                                                          1),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        (data[row].isAvailable == '0')
                            ? setItemOutOfStockWidget(
                                context, '${S.current.outOfStock}')
                            : Text(''),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  int _setItemCount(List<Categories> categoryList) {
    var count = 0;
    var price = 0.0;
    SharedManager.shared.cartItems = [];
    for (int i = 0; i < categoryList.length; i++) {
      List<Subcategories> subList = categoryList[i].subcategories;
      for (int j = 0; j < subList.length; j++) {
        if (subList[j].isAdded) {
          count = count + 1;
          price = price +
              (double.parse(subList[j].price) -
                  double.parse(subList[j].discount));
          SharedManager.shared.cartItems.add(subList[j]);
        }
      }
    }
    this.totlaPrice = price;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    resDetailsBloc.fetchRestaurantDetails(widget.restaurantID, APIS.resDetails);

    _setHeroImage(String strUrl) {
      return new Hero(
        tag: 0,
        child: new Stack(
          children: <Widget>[
            new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(strUrl),
                  // image: new AssetImage('Assets/RestaurantDetails/RestaurantApp.jpg'),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width - 150),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[
                        new Color(0x00000000),
                        new Color(0x00FFFFFF),
                      ],
                      stops: [
                        0.0,
                        1.0
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.0, 1.0)),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return new Scaffold(
      body: new StreamBuilder(
        stream: resDetailsBloc.restaurantDetails,
        builder: (context, AsyncSnapshot<ResRestaurantDetails> snapshot) {
          if (snapshot.hasData) {
            if (!isFirst) {
              this.isFirst = true;
              this.result = snapshot.data.result;
              SharedManager.shared.resLatitude = this.result.latitude;
              SharedManager.shared.resLongitude = this.result.longitude;
              SharedManager.shared.resAddress = this.result.address;
              SharedManager.shared.resImage = this.result.bannerImage;
              SharedManager.shared.resName = this.result.name;
            } else {
//
            }
            // var result = snapshot.data.result;
            print("Restaurant final result:$result");
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  backgroundColor: AppColor.themeColor,
                  iconTheme: IconThemeData(color: AppColor.white),
                  expandedHeight: MediaQuery.of(context).size.width - 120,
                  elevation: 0.1,
                  pinned: true,
                  flexibleSpace: new FlexibleSpaceBar(
                    centerTitle: true,
                    title: setCommonText(
                        result.name, AppColor.white, 16.0, FontWeight.w500, 2),
                    background: new Stack(
                      children: <Widget>[
                        _setHeroImage(result.bannerImage),
                        Container(
                          color: AppColor.black.withOpacity(0.5),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: new EdgeInsets.all(8),
                    child: new Container(
                      color: AppColor.white,
                      child: new Column(
                        children: <Widget>[
                          _setSocialWidgets(
                              width,
                              (result.avgReview != null)
                                  ? result.avgReview
                                  : '0.0',
                              result.name),
                          _setRestaurantDetails(result.categories),
                          _setAddressWidgets(result.address, result.discount,
                              result.openingTime, result.closingTime),
                          _setDynamicCategory(result.categories.length,
                              result.categories, width, result.categories),
                          ReviewWidgets(result.reviews,
                              this.widget.restaurantID, result.name),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10.0),
          child: (this.itemCount > 0)
              ? new Container(
                  color: AppColor.grey[100],
                  height: 50,
                  child: new Material(
                      color: AppColor.themeColor,
                      borderRadius: new BorderRadius.circular(30),
                      child: new Container(
                        padding: new EdgeInsets.only(left: 20, right: 15),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  "${this.itemCount} ${S.current.items}",
                                  style: new TextStyle(
                                      color: AppColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                new Text(
                                  "${S.current.totals} ${Currency.curr}${this.totlaPrice}",
                                  style: new TextStyle(
                                      color: AppColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () {
                                    if (result.isAvailable == '1') {
                                      List<Subcategories> listData = [];
                                      for (int i = 0;
                                          i < this.result.categories.length;
                                          i++) {
                                        List<Subcategories> subList = this
                                            .result
                                            .categories[i]
                                            .subcategories;
                                        for (int j = 0;
                                            j < subList.length;
                                            j++) {
                                          if (subList[j].isAdded) {
                                            listData.add(subList[j]);
                                          }
                                        }
                                      }
                                      SharedManager.shared.cartItems = listData;
                                      SharedManager.shared.resAddress =
                                          this.result.address;
                                      SharedManager.shared.resImage =
                                          this.result.bannerImage;
                                      SharedManager.shared.resName =
                                          this.result.name;
                                      SharedManager.shared.isFromTab = false;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => CartApp()));
                                    } else {
                                      commonRestaurantCloseAlert(context);
                                    }
                                  },
                                  child: new Text(
                                    S.current.view_cart,
                                    style: new TextStyle(
                                        fontSize: 16,
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                new Icon(Icons.arrow_forward,
                                    color: AppColor.white)
                              ],
                            )
                          ],
                        ),
                      )),
                )
              : null),
    );
  }
}
