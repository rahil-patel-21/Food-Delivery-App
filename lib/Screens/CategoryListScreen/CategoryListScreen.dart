import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/CategoryListBLoC.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelCategoryList.dart';
import 'package:product/Screens/SubcategoryListScreen/SubcategoryListScreen.dart';
import 'package:product/generated/i18n.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  BannerAd myBanner;

  _setBannerAdds() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['food', 'Zometo', 'Food Panda', 'Uber Eats'],
      contentUrl: 'google.com',
      childDirected: false, // or MobileAdGender.female, MobileAdGender.unknown
      testDevices: <String>[], // Android emulators are considered test devices
    );

    this.myBanner = BannerAd(
      adUnitId: Keys.bannerID,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    FirebaseAdMob.instance.initialize(appId: Keys.admobAppID);

    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 0.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    _setBannerAdds();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    try {
      this.myBanner.dispose();
      this.myBanner = null;
    } catch (ex) {
      print("banner dispose error");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    categoryListBloc.fetchAllCategoryList();
    return Scaffold(
      appBar: AppBar(
        title: setCommonText('${S.current.categories}', AppColor.white, 20.0,
            FontWeight.w500, 1),
        backgroundColor: AppColor.themeColor,
        elevation: 1.0,
        leading: IconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: AppColor.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: StreamBuilder(
          stream: categoryListBloc.categoryList,
          builder: (context, AsyncSnapshot<ResCategoryList> snapshot) {
            if (snapshot.hasData) {
              final categoryList = snapshot.data.categoryList;
              return Container(
                color: AppColor.white,
                child: Column(
                  children: [
                    Expanded(
                      child: new GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 0.67,
                        children: new List<Widget>.generate(categoryList.length,
                            (index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SubcategoryListScreen(
                                        categoryID:
                                            categoryList[index].categoryId,
                                        categoryName:
                                            categoryList[index].categoryName,
                                      )));
                            },
                            child: new GridTile(
                              child: new Card(
                                  elevation: 0.0,
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                            padding: new EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                left: 4,
                                                right: 4),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        categoryList[index]
                                                            .image),
                                                  )),
                                            ),
                                          )),
                                      Expanded(
                                          child: Container(
                                        // color: AppColor.orange.shade300,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            setCommonText(
                                                categoryList[index]
                                                    .categoryName,
                                                AppColor.black87,
                                                15.0,
                                                FontWeight.w500,
                                                1),
                                            setCommonText(
                                                '${categoryList[index].totalCount} ${S.current.items}',
                                                AppColor.grey[500],
                                                13.0,
                                                FontWeight.w500,
                                                1)
                                          ],
                                        ),
                                        padding: new EdgeInsets.only(
                                            left: 12, right: 12),
                                      ))
                                    ],
                                  )),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
