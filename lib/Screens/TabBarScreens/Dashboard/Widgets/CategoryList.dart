import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/CategoryListScreen/CategoryListScreen.dart';
import 'package:product/Screens/SubcategoryListScreen/SubcategoryListScreen.dart';
import 'package:product/generated/i18n.dart';

class CategoryList extends StatelessWidget {
  final List<Categories> categoryList;
  CategoryList(this.categoryList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      // color: AppColor.red,
      padding: new EdgeInsets.only(left: 2, right: 8, bottom: 5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                setCommonText('${S.current.trendingCategory}', AppColor.black,
                    18.0, FontWeight.w500, 1),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoryListScreen()));
                  },
                  child: setCommonText(S.current.seeAll, AppColor.themeColor,
                      16.0, FontWeight.w600, 1),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: Container(
            color: AppColor.grey[100],
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (builder, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SubcategoryListScreen(
                                categoryID: categoryList[index].categoryId,
                                categoryName: categoryList[index].categoryName,
                              )));
                    },
                    child: Container(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 80,
                            // color: AppColor.amber,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${categoryList[index].image}'))),
                          ),
                          SizedBox(height: 5),
                          setCommonText('${categoryList[index].categoryName}',
                              AppColor.black87, 13.0, FontWeight.w500, 1)
                        ],
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }
}
